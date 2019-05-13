//
//  GenericGroupedTableViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 1/21/13.
//
//

#import "GenericGroupedTableViewController.h"

@interface GenericGroupedTableViewController ()
- (void) configureView;
@end

NSMutableDictionary *headingMap;

@implementation GenericGroupedTableViewController

- (void) configureView
{
    headingMap = [[NSMutableDictionary alloc] init];
    [headingMap setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"Score", @"description",
                        nil] forKey:@"score"];
    [headingMap setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                           @"Risk Group", @"description",
                           nil] forKey:@"riskgroup"];
    [headingMap setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                           @"5-Yr OS", @"description",
                           nil] forKey:@"fiveyrs"];
    [headingMap setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                           @"CR Rate", @"description",
                           nil] forKey:@"crrate"];
    [headingMap setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                           @"10-Yr OS", @"description",
                           nil] forKey:@"tenyrs"];
    [headingMap setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                           @"Survival", @"description",
                           nil] forKey:@"survival"];
    [headingMap setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                           @"1 Year Survival", @"description",
                           nil] forKey:@"oneyrsurvival"];
    [headingMap setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                           @"4 Year PFS", @"description",
                           nil] forKey:@"fouryrpfs"];
    [headingMap setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                           @"4 Year OS", @"description",
                           nil] forKey:@"fouryros"];
    [headingMap setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                           @"Median overall survival", @"description",
                           nil] forKey:@"mediansurvival"];
    [headingMap setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                           @"Median time to 25 percent AML evolution", @"description",
                           nil] forKey:@"amlsurvival"];
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dict count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.keys objectAtIndex:section];
    NSDictionary *d = [headingMap objectForKey:key];
    
    return [d objectForKey:@"description"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier] autorelease];
    }

    NSString *key = [self.keys objectAtIndex:indexPath.section];
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
//    NSString *key = [[self.dict allKeys] objectAtIndex:indexPath.row];
    cell.textLabel.text = [self.dict objectForKey:key];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
