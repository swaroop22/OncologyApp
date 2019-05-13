//
//  AbsNeutrophilCountViewController.m
//  Medgets
//
//  Created by Niranjan Kode on 8/31/08.
//  Copyright Gentech Solutions, LLC 2008. All rights reserved.
//

#import "AbsNeutrophilCountViewController.h"


@implementation AbsNeutrophilCountViewController

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
	wbc.font = [UIFont systemFontOfSize:18.0];
	segs.font = [UIFont systemFontOfSize:18.0];
	bands.font = [UIFont systemFontOfSize:18.0];
	anc.font = [UIFont systemFontOfSize:18.0];
	
	wbc.delegate = self;
	segs.delegate = self;
	bands.delegate = self;

	modalViewController = [[ReferenceViewController alloc] initWithNibName:@"AbsNeutrophilCountReference" bundle:nil];
	
	// add references button as the nav bar's custom right view
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc]
								   initWithTitle:@"References"
								   style:UIBarButtonItemStyleBordered
								   target:self
								   action:@selector(displayReferences:)] autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
}

- (IBAction)calculateANC:(id)sender
{
	if (([wbc.text length] == 0) || ([segs.text length] == 0) || ([bands.text length] == 0))
	{
		anc.text = @"";
	}
	else
	{
		Float32 fanc = wbc.text.floatValue * ((segs.text.floatValue/100) + (bands.text.floatValue/100));
		anc.text = [NSString stringWithFormat:@"%4.0f", fanc];
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
