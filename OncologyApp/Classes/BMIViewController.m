//
//  BMIViewController.m
//  Medgets
//
//  Created by Niranjan Kode on 8/31/08.
//  Copyright Gentech Solutions, LLC 2008. All rights reserved.
//

#import "BMIViewController.h"


@implementation BMIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
		//self.title = @"BMI (Quetelet's index)";
	}
	return self;
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
 - (void)loadView {
 }
 */


// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
	calcTitle.font = [UIFont boldSystemFontOfSize:20.0];
	height.font = [UIFont systemFontOfSize:18.0];
	weight.font = [UIFont systemFontOfSize:18.0];
	result.font = [UIFont systemFontOfSize:18.0];
	
	height.delegate = self;
	weight.delegate = self;
	
	htSeg.selectedSegmentIndex = 0;
	wtSeg.selectedSegmentIndex = 0;

	modalViewController = [[ReferenceViewController alloc] initWithNibName:@"BMIReference" bundle:nil];
	
	// add references button as the nav bar's custom right view
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc]
								   initWithTitle:@"References"
								   style:UIBarButtonItemStyleBordered
								   target:self
								   action:@selector(displayReferences:)] autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
}


- (void)displayReferences:(id)sender
{
	// present references windows as a modal child or overlay view
	[[self navigationController] presentViewController:modalViewController animated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

- (IBAction)calculateBMI:(id)sender
{
	
	NSString *resultString;
	
    if (([height.text length] == 0) || ([weight.text length] == 0)) 
	{    // Nothing was typed
		resultString = @"";
    }
	else
	{
		Float32 fweight = weight.text.floatValue;
		Float32 fheight = height.text.floatValue;
		
		if (htSeg.selectedSegmentIndex == 0)
		{
			fheight = fheight * 0.0254; 
		}
		else
		{
			fheight = fheight * 0.01; 
		}
		
		if (wtSeg.selectedSegmentIndex == 0)
		{
			fweight = fweight * 0.45359237;
		}
		Float32 fresult = fweight/(fheight*fheight); //* (fheight * fweight/3600);
		resultString = [NSString stringWithFormat:@"%3.3f", fresult];
	}
	result.text = resultString;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}
- (void)dealloc {
	[super dealloc];
}


@end
