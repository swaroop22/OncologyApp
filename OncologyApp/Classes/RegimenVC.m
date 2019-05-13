//
//  RegimentVC.m
//  OncologyApp
//
//  Created by Satheesh Kathula on 10/15/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "RegimenVC.h"
#import "OncologyAppAppDelegate.h"
#import "RegimenCell.h"
#import "Constants.h"
#import "RegimenDetailVC.h"

@implementation RegimenVC

@synthesize myTableView, vcLevel, vcParentID;

- (void)awakeFromNib
{	
	self.title = @"Cancer Regimens";
}


- (void)viewDidLoad {
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
	//if (self.vcParentID == 0)
	//	[appDelegate initializeDatabase];
	//else
	//	[appDelegate filterByCategory:self.vcParentID];
    return appDelegate.regimens.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	return 80.0;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
	Regimen *regimen = (Regimen *)[appDelegate.regimens objectAtIndex:indexPath.row];

	RegimenCell *cell = (RegimenCell*)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell = [[[RegimenCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:kCellIdentifier] autorelease];
    }

	
	cell.level = self.vcLevel;
	//cell.parentID = 0;
	[cell setLabel:regimen.title];
		
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// Navigation logic
	OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
	Regimen *regimen = (Regimen *)[appDelegate.regimens objectAtIndex:indexPath.row];
	if (regimen.childIndicator == 1)
	{
		//[appDelegate filterByCategory:regimen.categoryID];
	
		//[self.myTableView reloadData];
		//[self.myTableView deselectRowAtIndexPath:indexPath animated:NO];
		//[[self navigationController] popViewControllerAnimated:YES];

		//UIBarButtonItem *bbItem = [[UIBarButtonItem alloc] initWithTitle:@"Level 1" style:UIBarButtonItemStylePlain target:nil action:nil];
		//self.navigationItem.backBarButtonItem = bbItem;

		if (self.vcLevel == 1)
		{
			RegimenVC *vc = [[RegimenVC alloc] initWithNibName:@"RegimenVC" bundle:nil];	
			vc.vcParentID = regimen.categoryID;
			vc.vcLevel = 2;
			vc.title = [NSString stringWithFormat:@"Level %d", vc.vcLevel] ;
			[[self navigationController] pushViewController:vc animated:YES];
		}
		else if (self.vcLevel == 2)
		{
			RegimenDetailVC *vc = [[RegimenDetailVC alloc] initWithNibName:@"RegimenDetail" bundle:nil];
			vc.vcRegimenID = regimen.categoryID;

			OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
			vc.regimenDetail = [appDelegate getRegimenDetailByID:vc.vcRegimenID];	
			vc.medications = [appDelegate getRegimenMedicationsByID:vc.vcRegimenID];
			
			[[self navigationController] pushViewController:vc animated:YES];
		}
	}
}


/*
 Override if you support editing the list
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }	
 if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }	
 }
 */


/*
 Override if you support conditional editing of the list
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 Override if you support rearranging the list
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 Override if you support conditional rearranging of the list
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */ 


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
	if (self.vcParentID == 0)
		[appDelegate initializeDatabase];
	else
		[appDelegate filterByCategory:self.vcParentID];	
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (void)viewDidDisappear:(BOOL)animated {
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
