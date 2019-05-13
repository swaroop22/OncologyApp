//
//  RegimenDetailVC.h
//  OncologyApp
//
//  Created by Satheesh Kathula on 10/18/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegimenDetail.h"

@interface RegimenDetailVC : UIViewController 
{
	IBOutlet UITableView	*myTableView;
	NSInteger vcRegimenID;
	RegimenDetail *regimenDetail;
	NSMutableArray *medications;
}


@property (nonatomic, retain) RegimenDetail *regimenDetail;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *medications;
@property (assign, nonatomic) NSInteger vcRegimenID;

@end
