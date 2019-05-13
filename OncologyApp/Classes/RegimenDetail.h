//
//  RegimenDetail.h
//  OncologyApp
//
//  Created by Satheesh Kathula on 10/18/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface RegimenDetail : NSObject 
{
	sqlite3 *regimenDB;
	
	NSInteger	primaryKey;
	NSInteger	regimenID;
	NSString	*title;
	NSString	*name;
    NSString    *schedule;
	NSString	*emetogenicPotential;
	NSString	*reference;
	NSString	*cycle;
	NSString	*brandName;
	NSString	*dosageModification;
    
}

- (id)initWithRegimenID:(NSInteger)rID database:(sqlite3 *)db;

@property (assign, nonatomic, readonly) NSInteger primaryKey;
@property (assign, nonatomic) NSInteger regimenID;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *schedule;
@property (copy, nonatomic) NSString *emetogenicPotential;
@property (copy, nonatomic) NSString *reference;
@property (copy, nonatomic) NSString *cycle;
@property (copy, nonatomic) NSString *brandName;
@property (copy, nonatomic) NSString *dosageModification;

@end
