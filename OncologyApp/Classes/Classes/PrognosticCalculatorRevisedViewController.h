//
//  PrognosticCalculatorRevisedViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 1/26/13.
//
//

#import <UIKit/UIKit.h>
#import "GenericGroupedTableViewController.h"

@interface PrognosticCalculatorRevisedViewController :  UIViewController  <UITableViewDataSource, UITableViewDelegate>
{
}

@property (strong, nonatomic) NSString *type;

@property (strong, nonatomic) IBOutlet UIButton *computeBtn;
@property (strong, nonatomic) IBOutlet UITableView *tv;

@property (strong, nonatomic) GenericGroupedTableViewController *detailViewController;

- (IBAction)compute:(id)sender;

@end
