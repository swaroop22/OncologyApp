//
// File:	   ReferenceViewController.m
//  Medgets
//
//  Created by Niranjan Kode on 8/31/08.
//  Copyright Gentech Solutions, LLC 2008. All rights reserved.
//

#import "ReferenceViewController.h"
#import "Constants.h"

@implementation ReferenceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

// fetch objects from our bundle based on keys in our Info.plist
- (id)infoValueForKey:(NSString*)key
{
	if ([[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:key])
		return [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:key];
	return [[[NSBundle mainBundle] infoDictionary] objectForKey:key];
}

// Automatically invoked after -loadView
// This is the preferred override point for doing additional setup after -initWithNibName:bundle:
//
- (void)viewDidLoad
{
	self.view.backgroundColor = [UIColor whiteColor];	// use the table view background color
	
	aboutText.font =  [UIFont systemFontOfSize:13.0];
	aboutText.text = @"Medgets is a calculator that consists of some of the commonly used medical formulas by health care professionals (physicians, physician extenders, medical students, residents, fellows, nurses, etc.). The program is designed by a practicing physician and we are confident that you will find it more user- friendly than others.  We welcome your suggestions for improvements.\n\nMedgets has the following calculators:\n Absolute Neutrophil #, Anion Gap, BMI Calculator, BSA Calculator, Ca Correction in Hypoalbuminemia, Creatinine Clearance Estimated, FENa, Mean Arterial Pressure, MELD Score, QT Interval Correction, Temperature Converter, Urinary Protein Excretion.";
	
}

- (IBAction)dismissAction:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
	// do something here as our view re-appears
}

@end
