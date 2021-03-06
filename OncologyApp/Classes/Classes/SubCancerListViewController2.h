//
//  SubCancerListViewController2.h
//  OncologyApp
//
//  Created by Niranjan Kode on 9/27/12.
//
//

#import <UIKit/UIKit.h>
#import "RegimenListViewController.h"

@interface SubCancerListViewController2 : UITableViewController {
    IBOutlet UITableView	*cancerListTableView;
    NSMutableArray			*cancerList;
    UINib *cellLoader;
}

@property (assign, nonatomic) NSInteger patientTypeId;
@property (nonatomic, retain) UITableView *cancerListTableView;
@property (nonatomic, retain) NSMutableArray *cancerList;
@property (strong, nonatomic) RegimenListViewController *regimenListViewController;

@end
