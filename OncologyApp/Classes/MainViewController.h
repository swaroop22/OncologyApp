//
// File:	   MainViewController.h
//  Medgets
//
//  Created by Niranjan Kode on 8/31/08.
//  Copyright Gentech Solutions, LLC 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ReferenceViewController.h"

//@class ReferenceViewController;


@interface MainViewController : UIViewController <	UINavigationBarDelegate,
													UITableViewDelegate, UITableViewDataSource,
													UIActionSheetDelegate>
{
	IBOutlet UITableView	*myTableView;
	NSMutableArray			*menuList;
	UINib *cellLoader;
	//ReferenceViewController *aboutController;
	
}

@property (nonatomic, retain) NSMutableArray *menuList;
@property (nonatomic, retain) UITableView *myTableView;

@end

