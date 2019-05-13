//
//  LymphomaListViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 1/12/13.
//
//

#import <UIKit/UIKit.h>
#import "LymphomaDetailViewController.h"

@interface LymphomaListViewController : UITableViewController {
    UINib                   *cellLoader;
}

@property (nonatomic, retain) NSMutableArray *lymphomaList;
@property (strong, nonatomic) LymphomaDetailViewController *lymphomaDetailViewController;

@end