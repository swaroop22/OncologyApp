//
//  AbsNeutrophilCountViewController.h
//  Medgets
//
//  Created by Niranjan Kode on 8/31/08.
//  Copyright Gentech Solutions, LLC 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReferenceViewController.h"

@class ReferenceViewController;

@interface AbsNeutrophilCountViewController : UIViewController <UITextFieldDelegate>
{
	IBOutlet UILabel *calcTitle;
	IBOutlet UITextField *wbc;
	IBOutlet UITextField *segs;
	IBOutlet UITextField *bands;
	IBOutlet UITextField *anc;
	
	ReferenceViewController *modalViewController;
}

- (IBAction)calculateANC:(id)sender;

@end
