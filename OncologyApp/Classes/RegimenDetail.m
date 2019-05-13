//
//  RegimenDetail.m
//  OncologyApp
//
//  Created by Satheesh Kathula on 10/18/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "RegimenDetail.h"


static sqlite3_stmt *init_statement = nil;

@implementation RegimenDetail

@synthesize regimenID, name, schedule, emetogenicPotential, reference, title, cycle, primaryKey;
@synthesize brandName, dosageModification;

- (id)initWithRegimenID:(NSInteger)rID database:(sqlite3 *)db {
    if (self = [super init]) {
        regimenID = rID;
        regimenDB = db;
        if (init_statement == nil) {
            //const char *sql = "SELECT regimenID, title, cycle, reference FROM regimen_detail WHERE regimenID=?";
            const char *sql = "SELECT pk, name, schedule, emetogenic_potential, reference, dosage_modifications, brand_names FROM RegimenDetail WHERE pk=?";
            if (sqlite3_prepare_v2(regimenDB, sql, -1, &init_statement, NULL) != SQLITE_OK) {
                NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(regimenDB));
            }
        }
		
		sqlite3_bind_int(init_statement, 1, (int)regimenID);
		
        if (sqlite3_step(init_statement) == SQLITE_ROW) 
		{
			self.regimenID = sqlite3_column_int(init_statement,0);
            self.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 1)];
            self.schedule = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 2)];
            self.emetogenicPotential = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 3)];
            self.reference = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 4)];
            self.dosageModification = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 5)];
            self.brandName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 6)];
            //self.detail = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 3)];
        }
        // Reset the statement for future reuse.
        sqlite3_reset(init_statement);
    }
    return self;
}

#pragma mark Properties

//- (NSInteger)primaryKey {
//    return primaryKey;
//}
//
//- (NSString *)title {
//    return title;
//}
//
//- (void)setTitle:(NSString *)aString {
//    [title release];
//    title = [aString copy];
//}
//
//- (NSString *)cycle {
//    return cycle;
//}
//
//- (void)setCycle:(NSString *)aString {
//    [cycle release];
//    cycle = [aString copy];
//}
//
//- (NSString *)reference {
//    return reference;
//}
//
//- (void)setReference:(NSString *)aString {
//    [reference release];
//    reference = [aString copy];
//}
//
//- (NSInteger)regimenID {
//    return regimenID;
//}
//
//- (void)setRegimenID:(NSInteger)nInt {
//    regimenID = nInt;
//}

@end
