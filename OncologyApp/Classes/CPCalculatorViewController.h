//
//  CPCalculatorViewController.h
//  Medgets
//
//  Created by Niranjan Kode on 8/31/08.
//  Copyright Gentech Solutions, LLC 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReferenceViewController.h"

@class ReferenceViewController;

//@interface CPCalculatorViewController : UIViewController <UITextFieldDelegate>
@interface CPCalculatorViewController : UIViewController <UITextFieldDelegate>
{
		IBOutlet UILabel *calcTitle;
		IBOutlet UITextField *age;
		IBOutlet UITextField *LBMlbs;
		IBOutlet UITextField *serumCrmgdL;
		IBOutlet UITextField *LBMkgs;
		IBOutlet UITextField *serumCrmicromolL;
        IBOutlet UITextField *targetAUC;
        IBOutlet UILabel *totalDoseMen;
        IBOutlet UILabel *totalDoseWomen;
		ReferenceViewController *modalViewController;
}
	
- (IBAction)convertToLbs:(id)sender;
- (IBAction)convertToKgs:(id)sender;
//- (IBAction)convertTomgdL:(id)sender;
//- (IBAction)convertTomicromolL:(id)sender;
- (IBAction)calculateCCR:(id)sender;
//- (void)subcalculateCCR;
- (void)calculateDosing;
//- (IBAction) subcalculateCCR:(id)sender;
	
@end
