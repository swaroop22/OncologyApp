//
//  RegimentVC.h
//  OncologyApp
//
//  Created by Satheesh Kathula on 10/15/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegimenVC : UIViewController 
{
	//NSArray							*listContent;
	IBOutlet UITableView	*myTableView;
	NSInteger vcLevel;
	NSInteger vcParentID;
}


//@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, retain) UITableView *myTableView;
@property (assign, nonatomic) NSInteger vcLevel;
@property (assign, nonatomic) NSInteger vcParentID;



@end
