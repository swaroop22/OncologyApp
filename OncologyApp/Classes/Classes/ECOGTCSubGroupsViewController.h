//
//  ECOGTCSubGroupsViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 1/21/13.
//
//

#import <UIKit/UIKit.h>

@interface ECOGTCSubGroupsViewController : UITableViewController {
    UINib                   *cellLoader;
}

@property (strong, nonatomic) NSString *detailTitle;
@property (nonatomic, retain) NSMutableArray *ECOGTCSubGroups;

@end
