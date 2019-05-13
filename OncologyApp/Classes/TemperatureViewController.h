//
//  TemperatureViewController.h
//  Medgets
//
//  Created by Niranjan Kode on 8/31/08.
//  Copyright Gentech Solutions, LLC 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReferenceViewController.h"

@class ReferenceViewController;

@interface TemperatureViewController : UIViewController <UITextFieldDelegate>
{
	IBOutlet UILabel *calcTitle;
	IBOutlet UITextField *f;
	IBOutlet UITextField *c;
	IBOutlet UITextField *k;
	
	ReferenceViewController *modalViewController;
}

- (IBAction)convertFromF:(id)sender;
- (IBAction)convertFromC:(id)sender;
- (IBAction)convertFromK:(id)sender;

@end
