//
//  CcrCalculatorViewController.m
//  Medgets
//
//  Created by Niranjan Kode on 8/31/08.
//  Copyright Gentech Solutions, LLC 2008. All rights reserved.
//

#import "CcrCalculatorViewController.h"


@implementation CcrCalculatorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
		self.title = @"CCr Estimated";
	}
	return self;
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

/*
 If you need to do additional setup after loading the view, override viewDidLoad.
 */
- (void)viewDidLoad {

	//calcTitle.font = [UIFont boldSystemFontOfSize:20.0];
	age.font = [UIFont systemFontOfSize:18.0];
	LBMlbs.font = [UIFont systemFontOfSize:18.0];
	serumCrmgdL.font = [UIFont systemFontOfSize:18.0];
	LBMkgs.font = [UIFont systemFontOfSize:18.0];
	//serumCrmicromolL.font = [UIFont systemFontOfSize:14.0];
	ccrMen.font = [UIFont systemFontOfSize:16.0];
	ccrWomen.font = [UIFont systemFontOfSize:16.0];

	age.delegate = self;
	LBMlbs.delegate = self;
	serumCrmgdL.delegate = self;
	LBMkgs.delegate = self;
	serumCrmicromolL.delegate = self;

	modalViewController = [[ReferenceViewController alloc] initWithNibName:@"CcrCalculatorReference" bundle:nil];
	
	// add references button as the nav bar's custom right view
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc]
								   initWithTitle:@"References"
								   style:UIBarButtonItemStyleBordered
								   target:self
								   action:@selector(displayReferences:)] autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)displayReferences:(id)sender
{
	// present references windows as a modal child or overlay view
	[[self navigationController] presentViewController:modalViewController animated:YES completion:nil];
}

- (IBAction)convertToLbs:(id)sender
{
	if ([LBMkgs.text length] == 0)
	{
		LBMlbs.text = @"";
	}
	else
	{
		LBMlbs.text =  [NSString stringWithFormat:@"%3.2f", (LBMkgs.text.floatValue * 2.20462262)];
	}
	[self subcalculateCCR];
}

- (IBAction)convertToKgs:(id)sender
{
	if ([LBMlbs.text length] == 0)
	{
		LBMkgs.text = @"";
	}
	else
	{
		LBMkgs.text =  [NSString stringWithFormat:@"%3.2f", (LBMlbs.text.floatValue / 2.20462262)];
	}
	[self subcalculateCCR];
}

- (IBAction)convertTomgdL:(id)sender
{
	if ([serumCrmicromolL.text length] == 0)
	{
		serumCrmgdL.text = @"";
	}
	else
	{
		serumCrmgdL.text =  [NSString stringWithFormat:@"%3.2f", (serumCrmicromolL.text.floatValue / 88)];
	}
	[self subcalculateCCR];
}

- (IBAction)convertTomicromolL:(id)sender
{
	if ([serumCrmgdL.text length] == 0)
	{
		serumCrmicromolL.text = @"";
	}
	else
	{
		serumCrmicromolL.text =  [NSString stringWithFormat:@"%3.2f", (serumCrmgdL.text.floatValue * 88)];
	}
	[self subcalculateCCR];
}

- (IBAction)calculateCCR:(id)sender
{
	[self subcalculateCCR];
}

- (void) subcalculateCCR
{
	Float32 fccrMen;
	Float32 fccrWomen;
	NSString *sccrMen;
	NSString *sccrWomen;
	
	if (([age.text length] == 0) || ([LBMkgs.text length] == 0) || ([serumCrmgdL.text length] == 0))
	{
		sccrMen = @"";
		sccrWomen = @"";
	}
	else
	{
		fccrMen = ((140 - age.text.floatValue) * LBMkgs.text.floatValue) / (serumCrmgdL.text.floatValue * 72);
		fccrWomen = 0.85 * fccrMen;
		
		sccrMen = [NSString stringWithFormat:@"%3.2f mL/min", fccrMen];
		sccrWomen = [NSString stringWithFormat:@"%3.2f mL/min", fccrWomen];
	}
	
	ccrMen.text = sccrMen;
	ccrWomen.text = sccrWomen;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[super dealloc];
}


@end
