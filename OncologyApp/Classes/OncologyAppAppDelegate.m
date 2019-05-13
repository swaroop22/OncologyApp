//
//  OncologyAppAppDelegate.m
//  OncologyApp
//
//  Created by Satheesh Kathula on 10/14/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "OncologyAppAppDelegate.h"

@interface OncologyAppAppDelegate (Private)
- (void)createEditableCopyOfDatabaseIfNeeded;
@end

@implementation OncologyAppAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize navigationBar;
@synthesize tnmT, tnmN, tnmM, tnmStage, tnmListId, regimenList, tnmList;
@synthesize ECOGTCGroup;//, ECOGTCSubGroup;
@synthesize gen2brandArray;

NSString *const PREV_DB_NAME=@"cancerregimens.1.0.sqlite";
NSString *const DB_NAME=@"cancerregimens.1.1.0.sqlite";

- (id)init {
	if (self = [super init]) {
		// 
	}
	return self;
}


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
    [self createEditableCopyOfDatabaseIfNeeded];
    const char *sql = "SELECT * FROM tnmList";
    self.tnmList = [self loadTNMList:sql];
    
    [self getPatientTypeList];
    
    [self loadECOGTCGroup];
 
    [self loadGen2Brand];

    // Configure and show the window
	[window addSubview:[navigationController view]];
    window.rootViewController = navigationController;
	[window makeKeyAndVisible];
    
}

// Delete db files
- (void)removeDB {
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSString *item;
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    for (item in contents)
    {
        if ([[item pathExtension]isEqualToString:@"sqlite"])
        {
            [fileManager removeItemAtPath:item error:&error];
        }
    }}

// Creates a writable copy of the bundled default database in the application Documents directory.
- (void)createEditableCopyOfDatabaseIfNeeded {
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *oldDBPath = [documentsDirectory stringByAppendingPathComponent:PREV_DB_NAME];
    if ([fileManager fileExistsAtPath:oldDBPath isDirectory:FALSE]) {
        [fileManager removeItemAtPath:oldDBPath error:&error];
    }
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    success = [fileManager fileExistsAtPath:writableDBPath];
    
    // check if timestamps are different
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DB_NAME];
//    if (success) {
//        NSDictionary* attrs1 = [fileManager attributesOfItemAtPath:defaultDBPath error:nil];
//        NSDictionary* attrs2 = [fileManager attributesOfItemAtPath:writableDBPath error:nil];
//        if (((NSDate*)[attrs1 objectForKey: NSFileCreationDate]) != ((NSDate*)[attrs2 objectForKey: NSFileCreationDate])) {
//            [fileManager removeItemAtPath:writableDBPath error:&error];
//            success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
//        }
//    }
    
    if (success) return;
    
    // remove older version of db
    [self removeDB];
    // The writable database does not exist, so copy the default to the appropriate location.
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

- (NSMutableArray *)loadTNMList:(const char *)sql {
    NSMutableArray *l_tnmList = [[NSMutableArray alloc] init];
    //tnmArray = l_tnmT;
    //[l_tnmT release];
    
	// The database is stored in the application bundle.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
	// Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        //const char *tname = [tableName UTF8String];
        //char *sql = "SELECT * FROM ";
        //sql = strcat(sql, tname);
        
        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
				
                int primaryKey = sqlite3_column_int(statement, 0);
				[l_tnmList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSString stringWithFormat:@"%d", primaryKey], @"code",
                                      [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)], @"description", nil]];
			}
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"loadTNM_T(): Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
    
    return l_tnmList;
}

- (void)getPatientTypeList {
    self.patientTypeList = [[NSMutableArray alloc] init];
    
	// The database is stored in the application bundle.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
	// Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        //const char *tname = [tableName UTF8String];
        char *sql = "SELECT * FROM PatientType";
        
        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
				
                int primaryKey = sqlite3_column_int(statement, 0);
				[self.patientTypeList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                             [NSString stringWithFormat:@"%d", primaryKey], @"code",
                                             [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)], @"title", nil]];
			}
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"getPatientTypeList(): Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }    
}


- (void) getCancerTypesByPatientTypeID: (NSInteger) patientTypeID {
    
    self.cancerTypeList = [[NSMutableArray alloc] init];
    
	// The database is stored in the application bundle.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
	// Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        //const char *tname = [tableName UTF8String];
        NSString *s_sql = [NSString stringWithFormat:@"select pk, title from CancerType where PatientTypeId = %ld", (long)patientTypeID];
        const char *sql = [s_sql UTF8String];
        
        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
				
                int primaryKey = sqlite3_column_int(statement, 0);
				[self.cancerTypeList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                             [NSString stringWithFormat:@"%d", primaryKey], @"code",
                                             [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)], @"title", nil]];
			}
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"getCancerTypesByPatientTypeID(): Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }    
}

- (void) getSubCancerTypes1ByCancerTypeID: (NSInteger) cancerTypeID {
    
    self.subCancerTypeList1 = [[NSMutableArray alloc] init];
    
	// The database is stored in the application bundle.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
	// Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        //const char *tname = [tableName UTF8String];
        NSString *s_sql = [NSString stringWithFormat:@"select pk, title from SubCancerType1 where CancerTypeId = %ld", (long)cancerTypeID];
        const char *sql = [s_sql UTF8String];
        
        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
				
                int primaryKey = sqlite3_column_int(statement, 0);
				[self.subCancerTypeList1 addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSString stringWithFormat:@"%d", primaryKey], @"code",
                                                [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)], @"title", nil]];
			}
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"getSubCancerTypes1ByCancerTypeID(): Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
}

- (void) getSubCancerTypes2BySubCancerTypeID1: (NSInteger) subCancerTypeID1 {
    
    self.subCancerTypeList2 = [[NSMutableArray alloc] init];
    
	// The database is stored in the application bundle.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
	// Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        //const char *tname = [tableName UTF8String];
        NSString *s_sql = [NSString stringWithFormat:@"select pk, title from SubCancerType2 where SubCancerTypeId1 = %ld", (long)subCancerTypeID1];
        const char *sql = [s_sql UTF8String];
        
        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
				
                int primaryKey = sqlite3_column_int(statement, 0);
				[self.subCancerTypeList2 addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSString stringWithFormat:@"%d", primaryKey], @"code",
                                                [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)], @"title", nil]];
			}
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"getSubCancerTypes2ByCancerTypeID(): Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
}

- (void) getRegimensBySubCancerTypeID2: (NSInteger) subCancerTypeID2 {
    
    self.regimenList = [[NSMutableArray alloc] init];
    
	// The database is stored in the application bundle.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
	// Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        //const char *tname = [tableName UTF8String];
        NSString *s_sql = [NSString stringWithFormat:@"select pk, disp_name from RegimenDetail where SubCancerTypeId2 = %ld", (long)subCancerTypeID2];
        const char *sql = [s_sql UTF8String];
        
        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
				
                int primaryKey = sqlite3_column_int(statement, 0);
				[self.regimenList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                    [NSString stringWithFormat:@"%d", primaryKey], @"code",
                                                    [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)], @"title", nil]];
			}
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"getSubCancerTypes2ByCancerTypeID(): Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
}

- (void)loadTNMByID: (int)listID {
    [self.tnmT removeAllObjects];
    [self.tnmN removeAllObjects];
    [self.tnmM removeAllObjects];
    
    NSString *sql = [NSString stringWithFormat:@"select code, description from tnmT where listID = %d", listID];
    self.tnmT = [self loadTNM:[sql UTF8String]];
    sql = [NSString stringWithFormat:@"select code, description from tnmN where listID = %d", listID];
    self.tnmN = [self loadTNM:[sql UTF8String]];
    sql = [NSString stringWithFormat:@"select code, description from tnmM where listID = %d", listID];
    self.tnmM = [self loadTNM:[sql UTF8String]];
    [self loadTNMStage:listID];
}

- (NSMutableArray *)loadTNM:(const char *)sql {
    NSMutableArray *l_tnm = [[NSMutableArray alloc] init];
    //tnmArray = l_tnmT;
    //[l_tnmT release];
    
	// The database is stored in the application bundle.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
	// Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        //const char *tname = [tableName UTF8String];
        //char *sql = "SELECT * FROM ";
        //sql = strcat(sql, tname);
        
        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
				
				[l_tnm addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)], @"code",
                                      [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)], @"description", nil]];
			}
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"loadTNM_T(): Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
    
    return l_tnm;
}

- (void) loadTNMStage:(int)listID {
    NSMutableArray *l_tnmStage = [[NSMutableArray alloc] init];
    self.tnmStage = l_tnmStage;
    [l_tnmStage release];
    
	// The database is stored in the application bundle.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
	// Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        NSString *sql = [NSString stringWithFormat:@"select t_code, n_code, m_code, stage, g_code from tnmStage where listID = %d", listID];
        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
				
				[self.tnmStage addObject:[NSDictionary dictionaryWithObjectsAndKeys:
										[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)], @"t_code",
                                        [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)], @"n_code",
                                        [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)], @"m_code",
										[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)], @"stage", nil]];
			}
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"loadTNM_T(): Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }    
}

- (NSString*)getCSS {
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *cssPath = [[NSBundle mainBundle]
                            pathForResource:@"iPhone"
                            ofType:@"css"];
    
    
	NSString *css = [NSString stringWithContentsOfFile:cssPath
                                                         encoding:NSUTF8StringEncoding
                                                            error:nil];
    
    
    return css;
    
}

- (RegimenDetail*)getRegimenDetailByID:(NSInteger)regimenID {	
	// The database is stored in the application bundle. 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
	RegimenDetail *regimenDetail = nil;
	// Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
		regimenDetail = [[RegimenDetail alloc] initWithRegimenID:regimenID database:database];

	}
	return regimenDetail;
}

- (NSString*)getStagingByTNM:(NSString *)t_code n_code:(NSString *)n_code m_code:(NSString *)m_code {
	// The database is stored in the application bundle.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
    NSString *staging = @"No Stage information available for the selected TNM.";
    
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        const char *sql = "SELECT stage FROM tnmStage WHERE ((t_code = 'Any T') OR (t_code = ?)) AND ((n_code = 'Any N') OR (n_code = ?)) AND (m_code = ?)";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [t_code UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [n_code UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [m_code UTF8String], -1, SQLITE_TRANSIENT);
            
            if (sqlite3_step(statement) == SQLITE_ROW) {
				staging = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
			}
		}
	}
    
    return staging;

}

- (NSMutableArray*)getRegimenMedicationsByID:(NSInteger)regimenID {	
	// The database is stored in the application bundle. 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
	NSMutableArray *medications = [[NSMutableArray alloc] init];
	
	// Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        const char *sql = "SELECT medication, dosage FROM regimen_medication where regimenID = ?";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
			sqlite3_bind_int(statement, 1, (int)regimenID);
			
			
			
            while (sqlite3_step(statement) == SQLITE_ROW) {
				
				[medications addObject:[NSDictionary dictionaryWithObjectsAndKeys:
										[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)], @"medication",
										[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)], @"dosage", nil]];
			}			
		}
	}
	return medications;
}


- (void) loadECOGTCGroup {
    self.ECOGTCGroup = [[NSMutableArray alloc] init];
    
	// The database is stored in the application bundle.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
	// Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        NSString *sql = [NSString stringWithFormat:@"select GroupId, title from ECOGTCGroup"];
        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
				
				[self.ECOGTCGroup addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 0)], @"code",
                                          [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)], @"description", nil]];
			}
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"loadECOGTCGroup: Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }    
}

- (NSMutableArray*) loadECOGTCSubGroup: (int)groupId {
    NSMutableArray* ECOGTCSubGroups = [[[NSMutableArray alloc] init] autorelease];
    
	// The database is stored in the application bundle.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
	// Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        NSString *sql = [NSString stringWithFormat:@"select SubGroupId, title, GroupId from ECOGTCSubGroup where GroupId = %d", groupId];
        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
				
				[ECOGTCSubGroups addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                             [NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 0)], @"SubGroupId",
                                             [[[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)] stringByReplacingOccurrencesOfString:@"^^^" withString:@"\u00B3"] stringByReplacingOccurrencesOfString:@"\\deg" withString:@"\u2070"], @"description", nil]];
			}
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"loadECOGTCSubGroup: Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
    
    return ECOGTCSubGroups;
}

- (NSMutableArray*) loadECOGTCOptions:(int)subGroupId {
    NSMutableArray* ECOGTCOptions = [[NSMutableArray alloc] init];
    
	// The database is stored in the application bundle.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
	// Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        NSString *sql = [NSString stringWithFormat:@"select grade, title, SubGroupId from ECOGTCOptions where SubGroupId = %d", subGroupId];
        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
				
				[ECOGTCOptions addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 0)], @"code",
                                          [[[[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)] stringByReplacingOccurrencesOfString:@"^^^" withString:@"\u00B3"] stringByReplacingOccurrencesOfString:@"^deg" withString:@"\u2070"] stringByReplacingOccurrencesOfString:@"^nl" withString:@"\n"], @"description", nil]];
            }
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"loadECOGTCOptions: Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
    
    return ECOGTCOptions;
}

- (void) loadGen2Brand {
    self.gen2brandArray = [[NSMutableArray alloc] init];
    
    // The database is stored in the application bundle.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        NSString *sql = [NSString stringWithFormat:@"select distinct generic, brand_name from gen2brand order by generic"];
        sqlite3_stmt *statement;
        // Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
        // The third parameter is either the length of the SQL string or -1 to read up to the first null terminator.
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            // We "step" through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {

                [self.gen2brandArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)], @"generic",
                                        [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)], @"brand_name", nil]];                
            }
        }
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(statement);
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"loadGen2Brand: Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
    }
}


- (void) displayDisclaimer {
    // check if date file exists
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"disclaimer_popup.txt"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:path];
    
    BOOL displayMsg = FALSE;

    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *now = [[NSDate alloc] init];
    NSString *dateString = [format stringFromDate:now];
    NSData *data = [dateString dataUsingEncoding:NSUTF8StringEncoding];

    if (!success) {
        displayMsg = TRUE;
    }
    else {
        // Read existing date
        
        NSDate *pastDate = nil;
        
        NSError *error = NULL;
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        if (error == NULL) {
            // Compare dates
            pastDate = [format dateFromString:content];
            NSDate *currentDate = [format dateFromString:dateString];
            NSTimeInterval timeDifference = [pastDate timeIntervalSinceDate:currentDate];
            // if more than 30 days then display message
            int numberOfDays = timeDifference/86400;
            if (numberOfDays > 14) {
                displayMsg = TRUE;
            }
        }
        
    }

    if (displayMsg) {
        // delete previous file
        [fileManager removeItemAtPath:path error:nil];
        // Create file with current date
        [fileManager createFileAtPath:path contents:nil attributes:nil];
        NSFileHandle* pfile = [NSFileHandle fileHandleForWritingAtPath:path];
        [pfile writeData:data];
        [pfile closeFile];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disclaimer"
                                                        message:@"This application is for information only and is not intended to recommend the treatment. End user is responsilble to check for the accuracy of the information provided."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self displayDisclaimer];
}
- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[regimens release];
	[navigationBar release];
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
