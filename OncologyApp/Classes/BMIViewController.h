//
//  BMIViewController.h
//  Medgets
//
//  Created by Niranjan Kode on 8/31/08.
//  Copyright Gentech Solutions, LLC 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReferenceViewController.h"

@class ReferenceViewController;

@interface BMIViewController : UIViewController <UITextFieldDelegate>{
	IBOutlet UILabel *calcTitle;
	IBOutlet UITextField *height;
	IBOutlet UITextField *weight;
	IBOutlet UITextField *result;
	IBOutlet UISegmentedControl *htSeg;
	IBOutlet UISegmentedControl *wtSeg;
	
	ReferenceViewController *modalViewController;
	
}

- (IBAction)calculateBMI:(id)sender;
@end
