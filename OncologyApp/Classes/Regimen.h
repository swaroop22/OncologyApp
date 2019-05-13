//
//  Regimen.h
//  OncologyApp
//
//  Created by Satheesh Kathula on 10/14/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Regimen : NSObject 
{
	sqlite3 *regimenDB;
	
	NSInteger	primaryKey;
	NSInteger	categoryID;
	NSInteger	parentID;
	NSString	*title;
	NSString	*detail;
	NSInteger	childIndicator;
	
}

- (id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db;

@property (assign, nonatomic, readonly) NSInteger primaryKey;
@property (assign, nonatomic) NSInteger categoryID;
@property (nonatomic) NSInteger parentID;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *detail;
@property (nonatomic) NSInteger childIndicator;

@end
