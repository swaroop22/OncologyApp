//
//  PrognosticScoresViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 1/21/13.
//
//

#import <UIKit/UIKit.h>
#import "PrognosticScoresDetailViewController.h"

@interface PrognosticScoresViewController : UITableViewController {
    UINib                   *cellLoader;
}

@property (strong, nonatomic) NSString *mynibName;
@property (strong, nonatomic) NSString *scaleName;
@property (strong, nonatomic) NSString *detailTitle;
@property (nonatomic) int subGroupId;
//@property (nonatomic, retain) NSMutableArray *karnofskyDict;
@property (strong, nonatomic) PrognosticScoresDetailViewController *detailViewController;

@end
