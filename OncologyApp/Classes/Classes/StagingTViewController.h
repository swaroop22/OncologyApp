//
//  StagingTViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 10/28/12.
//
//

#import <UIKit/UIKit.h>
#import "StagingNViewController.h"

@interface StagingTViewController : UITableViewController {
    UINib                   *cellLoader;
}

@property (nonatomic, retain) UITableView *tnmTTableView;
@property (nonatomic, retain) NSMutableArray *tnmT;
@property (strong, nonatomic) StagingNViewController *stagingNViewController;
@property (strong, nonatomic) NSString *listID;

@end
