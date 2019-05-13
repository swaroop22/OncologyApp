//
//  RegimenListViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 9/27/12.
//
//

#import "RegimenListViewController.h"
#import "CancerListCell.h"
#import "OncologyAppAppDelegate.h"

@interface RegimenListViewController ()

@end

@implementation RegimenListViewController

@synthesize regimenList, regimenListTableView;

static NSString *CellClassName = @"CancerListCell";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    cellLoader = [[UINib nibWithNibName:CellClassName bundle:[NSBundle mainBundle]] retain];
    
    return self;
}

- (void)dealloc
{
    [regimenList release];
    [cellLoader release];
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate getRegimensBySubCancerTypeID2:[self.listID integerValue]];
    
    self.regimenList = appDelegate.regimenList;

    //self.regimenDetailViewController = (RegimenDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.regimenList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CancerListCell *cell = (CancerListCell *)[tableView dequeueReusableCellWithIdentifier:CellClassName];
    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:self options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.dataDictionary = [self.regimenList objectAtIndex:indexPath.row];
    
    // Note: I set the cell's Identifier property in Interface Builder to DemoTableViewCell.
    return cell;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.regimenList objectAtIndex:indexPath.row];
    self.regimenDetailViewController = [[RegimenDetailViewController alloc] init];
    self.regimenDetailViewController.title = @"Regimen Detail";
    self.regimenDetailViewController.regimenID = [[dict objectForKey:@"code"] integerValue];
    [[self navigationController] pushViewController:self.regimenDetailViewController animated:YES];    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        //[[segue destinationViewController] setDetailItem:object];
    }
}

@end
