//
//  StagingMViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 10/28/12.
//
//

#import <UIKit/UIKit.h>
#import "StagingDetailViewController.h"
#import "StagingSViewController.h"

@interface StagingMViewController : UITableViewController {
    UINib                   *cellLoader;
}

@property (nonatomic, retain) UITableView *tnmMTableView;
@property (nonatomic, retain) NSMutableArray *tnmM;
@property (strong, nonatomic) NSString *t_code;
@property (strong, nonatomic) NSString *t_desc;
@property (strong, nonatomic) NSString *n_code;
@property (strong, nonatomic) NSString *n_desc;
@property (strong, nonatomic) StagingDetailViewController *stagingDetailViewController;
@property (strong, nonatomic) StagingSViewController *stagingSViewController;

@end
