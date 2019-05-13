//
//  BSACalculatorViewController.h
//  Medgets
//
//  Created by Niranjan Kode on 8/31/08.
//  Copyright Gentech Solutions, LLC 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReferenceViewController.h"

@class ReferenceViewController;

@interface BSACalculatorViewController : UIViewController 
{
	IBOutlet UITextField *height;
	IBOutlet UITextField *weight;
	IBOutlet UITextField *result;
	IBOutlet UILabel *lresult;
	IBOutlet UISegmentedControl *htSeg;
	IBOutlet UISegmentedControl *wtSeg;
	IBOutlet UILabel *calcTitle;
	
	ReferenceViewController *modalViewController;

}

- (IBAction)calculateBSA:(id)sender;

@end
