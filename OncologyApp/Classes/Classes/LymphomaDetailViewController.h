//
//  LymphomaDetailViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 1/12/13.
//
//

#import <UIKit/UIKit.h>

@interface LymphomaDetailViewController : UIViewController
{
}

@property (strong, nonatomic) NSString *stage;

@property (strong, nonatomic) IBOutlet UILabel *stageLabel;
@property (strong, nonatomic) IBOutlet UITextField *temperature;
@property (strong, nonatomic) IBOutlet UITextField *weightLoss;
@property (strong, nonatomic) IBOutlet UISegmentedControl *tempFormat;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sweat;



- (IBAction)sweatIndexChanged;
- (IBAction)tempFormatIndexChanged;
- (IBAction)tempChanged:(id)sender;
- (IBAction)weigthLossChanged:(id)sender;

@end
