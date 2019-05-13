//
//  StagingNViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 10/28/12.
//
//

#import <UIKit/UIKit.h>
#import "StagingMViewController.h"

@interface StagingNViewController : UITableViewController {
    UINib                   *cellLoader;    
}

@property (nonatomic, retain) UITableView *tnmNTableView;
@property (nonatomic, retain) NSMutableArray *tnmN;
@property (strong, nonatomic) StagingMViewController *stagingMViewController;
@property (strong, nonatomic) NSString *t_code;
@property (strong, nonatomic) NSString *t_desc;

@end
