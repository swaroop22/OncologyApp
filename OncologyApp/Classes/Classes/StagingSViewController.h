//
//  StagingSViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 10/28/12.
//
//

#import <UIKit/UIKit.h>
#import "StagingDetailViewController.h"

@interface StagingSViewController : UITableViewController {
    UINib                   *cellLoader;
}

@property (nonatomic, retain) UITableView *tnmSTableView;
@property (nonatomic, retain) NSMutableArray *tnmS;
@property (strong, nonatomic) NSString *t_code;
@property (strong, nonatomic) NSString *t_desc;
@property (strong, nonatomic) NSString *n_code;
@property (strong, nonatomic) NSString *n_desc;
@property (strong, nonatomic) NSString *m_code;
@property (strong, nonatomic) NSString *m_desc;
@property (strong, nonatomic) StagingDetailViewController *stagingDetailViewController;

@end
