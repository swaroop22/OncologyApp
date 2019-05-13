//
//  CancerListViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 9/27/12.
//
//

#import <UIKit/UIKit.h>
#import "RegimenListViewController.h"
#import "SubCancerListViewController1.h"

@interface CancerListViewController : UITableViewController {
    IBOutlet UITableView	*cancerListTableView;
    NSMutableArray			*cancerList;
    UINib *cellLoader;
}

@property (assign, nonatomic) NSInteger patientTypeId;
@property (nonatomic, retain) UITableView *cancerListTableView;
@property (nonatomic, retain) NSMutableArray *cancerList;
@property (strong, nonatomic) RegimenListViewController *regimenListViewController;
@property (strong, nonatomic) SubCancerListViewController1 *subCancerListViewController1;

@end
