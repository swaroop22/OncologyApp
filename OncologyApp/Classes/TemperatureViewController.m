//
//  TemperatureViewController.m
//  Medgets
//
//  Created by Niranjan Kode on 8/31/08.
//  Copyright Gentech Solutions, LLC 2008. All rights reserved.
//

#import "TemperatureViewController.h"


@implementation TemperatureViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
		//self.title = @"Absolute Neutrophil #";
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
	calcTitle.font = [UIFont boldSystemFontOfSize:20.0];
	f.font = [UIFont systemFontOfSize:18.0];
	c.font = [UIFont systemFontOfSize:18.0];
	k.font = [UIFont systemFontOfSize:18.0];
	
	f.delegate = self;
	c.delegate = self;
	k.delegate = self;

	modalViewController = [[ReferenceViewController alloc] initWithNibName:@"TemperatureReference" bundle:nil];
	
	// add references button as the nav bar's custom right view
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc]
								   initWithTitle:@"References"
								   style:UIBarButtonItemStyleBordered
								   target:self
								   action:@selector(displayReferences:)] autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
}

- (IBAction)convertFromF:(id)sender
{
	if ([f.text length] > 0)
	{
		Float32 fC = (f.text.floatValue-32) *	5/9;
		c.text = [NSString stringWithFormat:@"%4.2f", fC];

		Float32 fK = fC + 273.15;
		k.text = [NSString stringWithFormat:@"%4.2f", fK];
	}
}

- (IBAction)convertFromC:(id)sender
{
	if ([c.text length] > 0)
	{
		Float32 fF = (c.text.floatValue*9/5) + 32;
		f.text = [NSString stringWithFormat:@"%4.2f", fF];
		
		Float32 fK = c.text.floatValue + 273.15;
		k.text = [NSString stringWithFormat:@"%4.2f", fK];
	}
}

- (IBAction)convertFromK:(id)sender
{
	if ([k.text length] > 0)
	{
		Float32 fF = ((k.text.floatValue-273.15) *	9/5) + 32;
		f.text = [NSString stringWithFormat:@"%4.2f", fF];
		
		Float32 fC = k.text.floatValue-273.15;
		c.text = [NSString stringWithFormat:@"%4.2f", fC];
	}
}

- (void)displayReferences:(id)sender
{
	// present references windows as a modal child or overlay view
	[[self navigationController] presentViewController:modalViewController animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[super dealloc];
}


@end
