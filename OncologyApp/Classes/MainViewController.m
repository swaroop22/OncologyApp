//
// File:	   MainViewController.m
//  Medgets
//
//  Created by Niranjan Kode on 8/31/08.
//  Copyright Gentech Solutions, LLC 2008. All rights reserved.
// SKU Number : GSMEDGETSV1
//

#import "MainViewController.h"

#import "BSACalculatorViewController.h"

#import "MyCustomCell2.h"
#import "Constants.h"	// contains the dictionary keys

enum PageIndices
{
	kPageOneIndex	= 0,
	kPageTwoIndex	= 1,
	kPageThreeIndex = 2,
	kPageFourIndex	= 3,
	kPageFiveIndex	= 4,
	kPageSixIndex = 5,
	kPageSevenIndex = 6,
	kPageEightIndex = 7,
	kPageNineIndex = 8,
	kPageTenIndex = 9,
	kPageElevenIndex = 10,
	kPageTwelveIndex = 11,
	kPage13Index = 12,
	kPage14Index = 13
	//,
	//kPage15Index = 14
};

@implementation MainViewController

static NSString *CellClassName = @"MyCustomCell2";

@synthesize menuList, myTableView;

- (void)awakeFromNib
{
	// make the title of this page the same as the title of this app
	self.title = @"Oncology Calcs";		//[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
		
	self.menuList = [[NSMutableArray alloc] init];
	
	// We will lazily create our view controllers as the user requests them (at a later time),
	// but for now we will encase each title an explanation text into a NSDictionary and add it to a mutable array.
	// This dictionary will be used by our table view data source to populate the text in each cell.
	//
	// When it comes time to create the corresponding view controller we will replace each NSDictionary.
	//
	// If you want to add more pages, simply call "addObject" on "menuList"
	// with an additional NSDictionary.  Note we use NSLocalizedString to load a localized version of its title.
	//
	//
	[menuList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
						 NSLocalizedString(@"BSA Calculator", @""), kTitleKey,
						 NSLocalizedString(@"", @""), kExplainKey,
						 nil]];
	
	
    cellLoader = [[UINib nibWithNibName:CellClassName bundle:[NSBundle mainBundle]] retain];
	
	[myTableView reloadData];

}

- (void)dealloc
{
    [myTableView release];
	[menuList release];

    [cellLoader release];
	[super dealloc];
}


#pragma mark UIViewController delegates

- (void)viewWillAppear:(BOOL)animated
{
	NSIndexPath *tableSelection = [myTableView indexPathForSelectedRow];
	[myTableView deselectRowAtIndexPath:tableSelection animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
	// do something here as our view re-appears
}


#pragma mark UITableView delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Note: I set the cell's Identifier property in Interface Builder to DemoTableViewCell.
    MyCustomCell2 *cell = (MyCustomCell2 *)[tableView dequeueReusableCellWithIdentifier:CellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:self options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.dataDictionary = [self.menuList objectAtIndex:indexPath.row];
    return cell;
}


//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
//{
//	return UITableViewCellAccessoryDisclosureIndicator;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	//UIViewController *targetViewController = [[menuList objectAtIndex: indexPath.row] objectForKey:kViewControllerKey];
//	UIViewController *targetViewController = nil;
//	if (targetViewController == nil)
//	{
//		// the view controller has not been created yet, create it and set it to our menuList array
//		
//		// create a new dictionary with the new view controller
//		//
//		NSMutableDictionary *newItemDict = [NSMutableDictionary dictionaryWithCapacity:3];
//		[newItemDict addEntriesFromDictionary: [menuList objectAtIndex: indexPath.row]];	// copy the title and explain strings
//		
//		// which view controller do we create?
//		switch (indexPath.row)
//		{
//			case kPageOneIndex:
//			{
//				targetViewController = [[BSACalculatorViewController alloc] initWithNibName:@"BSACalculatorViewController" bundle:nil];
//				break;
//			}				
//		}
//
//		// add the new view controller to the dictionary and then to the 'menuList' array
//		[newItemDict setObject:targetViewController forKey:kViewControllerKey];
//		[menuList replaceObjectAtIndex:	indexPath.row withObject: newItemDict];
//		[targetViewController release];
//		
//		// load the view controll back in to push it
//		targetViewController = [[menuList objectAtIndex: indexPath.row] objectForKey:kViewControllerKey];
//	}
//	
//	// present the rest of the pages normally
//	[[self navigationController] pushViewController:targetViewController animated:YES];
//}
//
//
//#pragma mark UITableView datasource methods
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//	return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//	return [menuList count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	MyCustomCell *cell = (MyCustomCell*)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
//	if (cell == nil)
//	{
//		cell = [[[MyCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier] autorelease];
//	}
//
//	// get the view controller's info dictionary based on the indexPath's row
//	cell.dataDictionary = [menuList objectAtIndex:indexPath.row];
//	return cell;
//}

@end

