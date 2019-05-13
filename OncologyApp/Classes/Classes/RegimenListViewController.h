//
//  RegimenListViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 9/27/12.
//
//

#import <UIKit/UIKit.h>
#import "RegimenDetailViewController.h"

@interface RegimenListViewController : UITableViewController {
    IBOutlet UITableView	*regimenListTableView;
    NSMutableArray			*regimenList;
    UINib *cellLoader;
}

@property (nonatomic, retain) UITableView *regimenListTableView;
@property (nonatomic, retain) NSMutableArray *regimenList;
@property (strong, nonatomic) RegimenDetailViewController *regimenDetailViewController;
@property (strong, nonatomic) NSString *listID;


@end
