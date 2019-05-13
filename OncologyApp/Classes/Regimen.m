//
//  Regimen.m
//  OncologyApp
//
//  Created by Satheesh Kathula on 10/14/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Regimen.h"

static sqlite3_stmt *init_statement = nil;

@implementation Regimen

- (id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db {
    if (self = [super init]) {
        primaryKey = pk;
        regimenDB = db;
        if (init_statement == nil) {
            const char *sql = "SELECT categoryID,parentID,title, detail, childIndicaor FROM regimen WHERE pk=?";
            if (sqlite3_prepare_v2(regimenDB, sql, -1, &init_statement, NULL) != SQLITE_OK) {
                NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(regimenDB));
            }
        }

		sqlite3_bind_int(init_statement, 1, (int)primaryKey);
		
        if (sqlite3_step(init_statement) == SQLITE_ROW) 
		{
			self.categoryID = sqlite3_column_int(init_statement,0);
			self.parentID = sqlite3_column_int(init_statement,1);
            self.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 2)];
            //self.detail = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 3)];
			self.childIndicator = sqlite3_column_int(init_statement,4);
        }
        // Reset the statement for future reuse.
        sqlite3_reset(init_statement);
    }
    return self;
}

#pragma mark Properties

- (NSInteger)primaryKey {
    return primaryKey;
}

- (NSString *)title {
    return title;
}

- (void)setTitle:(NSString *)aString {
    [title release];
    title = [aString copy];
}

- (NSString *)detail {
    return detail;
}

- (void)setDetail:(NSString *)aString {
    [detail release];
    detail = [aString copy];
}

- (NSInteger)categoryID {
    return categoryID;
}

- (void)setCategoryID:(NSInteger)nInt {
    categoryID = nInt;
}

- (NSInteger)parentID {
    return parentID;
}

- (void)setParentID:(NSInteger)nInt {
    parentID = nInt;
}

- (NSInteger)childIndicator {
    return childIndicator;
}

- (void)setChildIndicator:(NSInteger)nInt {
    childIndicator = nInt;
}

@end
