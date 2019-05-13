//
//  RegimenDetailVC.m
//  OncologyApp
//
//  Created by Satheesh Kathula on 10/18/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "RegimenDetailVC.h"
#import "RegimenCell.h"
#import "RegimenMedicationCell.h"
#import "OncologyAppAppDelegate.h"
#import "Constants.h"


@implementation RegimenDetailVC


@synthesize myTableView, vcRegimenID, regimenDetail, medications;

- (void)awakeFromNib
{	
	self.title = @"Detail";
}


- (void)viewDidLoad {
    //OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
	//regimenDetail = [appDelegate getRegimenDetailByID:self.vcRegimenID];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger n = (section == 1) ? [medications count] : 1;
    //OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
	//[appDelegate getRegimenDetail:self.vcRegimenID];
    return n;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1)
		return 100.0;
	else
		return tableView.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.section == 1)
	{
		//RegimenMedicationCell *cell = (RegimenMedicationCell*)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
		//if (cell == nil)
		//{
		//	cell = [[[RegimenMedicationCell alloc] initWithFrame:CGRectZero reuseIdentifier:kCellIdentifier] autorelease];
		//}
		
		RegimenMedicationCell *cell = [[[RegimenMedicationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier] autorelease];
		NSDictionary *dict = [medications objectAtIndex: indexPath.row];
		[cell setMLabel:[dict objectForKey:@"medication"]];
		[cell setDLabel:[dict objectForKey:@"dosage"]];
		//[cell setDLabel:@"Dosage Information Dosage Information Dosage Information Dosage Information Dosage Information Dosage Information Dosage Information 7"];
		return cell;
	}
	else
	{
		//RegimenCell *cell = (RegimenCell*)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
		//if (cell == nil)
		//{
		//	cell = [[[RegimenCell alloc] initWithFrame:CGRectZero reuseIdentifier:kCellIdentifier] autorelease];
		//}
		
		RegimenCell *cell = [[[RegimenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
		switch (indexPath.section) {
			case 0: [cell setLabel:regimenDetail.title];break;
			case 2: [cell setLabel:regimenDetail.cycle];break;
			case 3: [cell setLabel:regimenDetail.reference];
		}
		
		return cell;
	}
		
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // Return the displayed title for the specified section.
    switch (section) {
        case 0: return @"Regimen";
		case 1: return @"Treatment";
		case 2: return @"Cycle";
		case 3: return @"Reference";
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
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
	[myTableView release];
	[regimenDetail release];
	[medications release];
}

@end
