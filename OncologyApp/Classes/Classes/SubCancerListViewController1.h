//
//  SubCancerListViewController1.h
//  OncologyApp
//
//  Created by Niranjan Kode on 9/27/12.
//
//

#import <UIKit/UIKit.h>
#import "RegimenListViewController.h"
#import "SubCancerListViewController2.h"

@interface SubCancerListViewController1 : UITableViewController {
    IBOutlet UITableView	*cancerListTableView;
    NSMutableArray			*cancerList;
    UINib *cellLoader;
}

@property (assign, nonatomic) NSInteger patientTypeId;
@property (nonatomic, retain) UITableView *cancerListTableView;
@property (nonatomic, retain) NSMutableArray *cancerList;
@property (strong, nonatomic) RegimenListViewController *regimenListViewController;
@property (strong, nonatomic) SubCancerListViewController2 *subCancerListViewController2;

@end
