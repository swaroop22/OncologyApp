//
//  PrognosticCalculatorViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 1/16/13.
//
//

#import <UIKit/UIKit.h>
#import "GenericGroupedTableViewController.h"

@interface PrognosticCalculatorViewController : UIViewController

@property (strong, nonatomic) NSString *mynibName;

@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *age;
@property (strong, nonatomic) IBOutlet UILabel *perfLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *perf;
@property (strong, nonatomic) IBOutlet UILabel *ldhLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *ldh;
@property (strong, nonatomic) IBOutlet UILabel *extranodalLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *extranodal;
@property (strong, nonatomic) IBOutlet UILabel *stageLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *stage;
@property (strong, nonatomic) IBOutlet UILabel *hemoglobinLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *hemoglobin;
@property (strong, nonatomic) IBOutlet UISegmentedControl *bonemarrow;
@property (strong, nonatomic) IBOutlet UISegmentedControl *karyotype;
@property (strong, nonatomic) IBOutlet UISegmentedControl *cytopenias;
@property (strong, nonatomic) IBOutlet UILabel *kpsLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *kps;
@property (strong, nonatomic) IBOutlet UILabel *serumLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *serum;
@property (strong, nonatomic) IBOutlet UILabel *nephrectomyLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *nephrectomy;

@property (strong, nonatomic) GenericGroupedTableViewController *detailViewController;

- (IBAction)compute:(id)sender;

@end
