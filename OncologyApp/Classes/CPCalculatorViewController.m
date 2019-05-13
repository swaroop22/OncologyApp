//
//  CPCalculatorViewController.m
//  Medgets
//
//  Created by Niranjan Kode on 8/31/08.
//  Copyright Gentech Solutions, LLC 2008. All rights reserved.
//

#import "CPCalculatorViewController.h"
#import "PrognosticScoresDetailViewController.h"


@implementation CPCalculatorViewController

Float32 fccrMen;
Float32 fccrWomen;

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

/*
 If you need to do additional setup after loading the view, override viewDidLoad.
 */
- (void)viewDidLoad {

    self.title = @"Carboplatin Dose";

	age.font = [UIFont systemFontOfSize:18.0];
	LBMlbs.font = [UIFont systemFontOfSize:18.0];
	serumCrmgdL.font = [UIFont systemFontOfSize:18.0];
	LBMkgs.font = [UIFont systemFontOfSize:18.0];
	targetAUC.font = [UIFont systemFontOfSize:18.0];
	//serumCrmicromolL.font = [UIFont systemFontOfSize:14.0];
//	ccrMen.font = [UIFont systemFontOfSize:16.0];
//	ccrWomen.font = [UIFont systemFontOfSize:16.0];

	age.delegate = self;
	LBMlbs.delegate = self;
	serumCrmgdL.delegate = self;
	LBMkgs.delegate = self;
	serumCrmicromolL.delegate = self;
	targetAUC.delegate = self;

	modalViewController = [[ReferenceViewController alloc] initWithNibName:@"CPCalculatorReference" bundle:nil];
	
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
		LBMlbs.text =  [NSString stringWithFormat:@"%3.1f", (LBMkgs.text.floatValue * 2.20462262)];
	}
	[self calculateDosing];
}

- (IBAction)convertToKgs:(id)sender
{
	if ([LBMlbs.text length] == 0)
	{
		LBMkgs.text = @"";
	}
	else
	{
		LBMkgs.text =  [NSString stringWithFormat:@"%3.1f", (LBMlbs.text.floatValue / 2.20462262)];
	}
	[self calculateDosing];
}

//- (IBAction)convertTomgdL:(id)sender
//{
//	if ([serumCrmicromolL.text length] == 0)
//	{
//		serumCrmgdL.text = @"";
//	}
//	else
//	{
//		serumCrmgdL.text =  [NSString stringWithFormat:@"%3.2f", (serumCrmicromolL.text.floatValue / 88)];
//	}
//	[self calculateDosing];
//}

//- (IBAction)convertTomicromolL:(id)sender
//{
//	if ([serumCrmgdL.text length] == 0)
//	{
//		serumCrmicromolL.text = @"";
//	}
//	else
//	{
//		serumCrmicromolL.text =  [NSString stringWithFormat:@"%3.2f", (serumCrmgdL.text.floatValue * 88)];
//	}
//	[self calculateDosing];
//}

- (IBAction)calculateCCR:(id)sender
{
	[self calculateDosing];
}

//- (void) subcalculateCCR
//{
////	NSString *sccrMen;
////	NSString *sccrWomen;
//	
//	if (([age.text length] == 0) || ([LBMkgs.text length] == 0) || ([serumCrmgdL.text length] == 0))
//	{
////		sccrMen = @"";
////		sccrWomen = @"";
//	}
//	else
//	{
//		fccrMen = ((140 - age.text.floatValue) * LBMkgs.text.floatValue) / (serumCrmgdL.text.floatValue * 72);
//		fccrWomen = 0.85 * fccrMen;
//		
////		sccrMen = [NSString stringWithFormat:@"%3.2f mL/min", fccrMen];
////		sccrWomen = [NSString stringWithFormat:@"%3.2f mL/min", fccrWomen];
//	}
//	
////	ccrMen.text = sccrMen;
////	ccrWomen.text = sccrWomen;
//}

- (void) calculateDosing
{
	if (([age.text length] == 0) || ([LBMkgs.text length] == 0) || ([serumCrmgdL.text length] == 0) || ([targetAUC.text length] == 0))
	{
        totalDoseMen.text = @"Men: ";
        totalDoseWomen.text = @"Women: ";
	}
	else
	{
		fccrMen = ((140 - age.text.floatValue) * LBMkgs.text.floatValue) / (serumCrmgdL.text.floatValue * 72);
		fccrWomen = 0.85 * fccrMen;
        
        totalDoseMen.text = [NSString stringWithFormat:@"Men: %d", (int)((fccrMen + 25.0) * (targetAUC.text.floatValue))];
        totalDoseWomen.text = [NSString stringWithFormat:@"Women: %d", (int)((fccrWomen + 25.0) * ( targetAUC.text.floatValue))];
		
        //		sccrMen = [NSString stringWithFormat:@"%3.2f mL/min", fccrMen];
        //		sccrWomen = [NSString stringWithFormat:@"%3.2f mL/min", fccrWomen];
        
        PrognosticScoresDetailViewController *detailViewController = [[PrognosticScoresDetailViewController alloc] init];
        detailViewController.titleText = @"Total Dose (mg)";
        
        detailViewController.scoreText2 = [NSString stringWithFormat:@"Men: %d", (int)((fccrMen + 25.0) * (targetAUC.text.floatValue))];;
        detailViewController.scoreText = [NSString stringWithFormat:@"Women: %d", (int)((fccrWomen + 25.0) * ( targetAUC.text.floatValue))];;
        detailViewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        
        [[self navigationController] presentViewController:detailViewController animated:YES completion:nil];
        [detailViewController release];
	}
	
    //	ccrMen.text = sccrMen;
    //	ccrWomen.text = sccrWomen;
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
