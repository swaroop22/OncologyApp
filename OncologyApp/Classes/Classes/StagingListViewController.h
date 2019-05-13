//
//  StagingListViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 11/15/12.
//
//

#import <UIKit/UIKit.h>
#import "StagingTViewController.h"

@interface StagingListViewController : UITableViewController {
    UINib                   *cellLoader;
}

@property (nonatomic, retain) UITableView *tnmTTableView;
@property (nonatomic, retain) NSMutableArray *tnmList;
@property (strong, nonatomic) StagingTViewController *stagingTViewController;

@end
