//
//  LymphomaListViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 1/12/13.
//
//

#import "LymphomaListViewController.h"
#import "Util.h"
#import "StagingTNMCell.h"

@interface LymphomaListViewController ()
- (void)configureView;
@end

@implementation LymphomaListViewController

NSString *lymphomaListCell = @"StagingTNMCell";

- (void)configureView {
    self.lymphomaList = [[NSMutableArray alloc] init];
    [self.lymphomaList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            @"Stage I", @"code",
                            @"Single LN region", @"description", nil]];
    [self.lymphomaList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                  @"Stage II", @"code",
                                  @"2 LN regions same side of diaphragm", @"description", nil]];
    [self.lymphomaList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                  @"Stage III", @"code",
                                  @"LN involvement on both sides of diaphragm", @"description", nil]];
    [self.lymphomaList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                  @"Stage IV", @"code",
                                  @"Disseminated involvement of one or more extralymphatic organs (eg. lung, liver, bone marrow)", @"description", nil]];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.view.opaque = YES;
        self.view.backgroundColor = [Util colorWithHexString:@"0xFFFFCC"];
        //[UIColor colorWithRed:255.0 green:255.0 blue:153.0 alpha:1.0];
        cellLoader = [[UINib nibWithNibName:lymphomaListCell bundle:[NSBundle mainBundle]] retain];
        [self configureView];
    }
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.lymphomaList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StagingTNMCell *cell = (StagingTNMCell *)[tableView dequeueReusableCellWithIdentifier:lymphomaListCell];
    if (cell == nil) {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:self options:nil];
        cell = (StagingTNMCell *)[topLevelItems objectAtIndex:0];
    }
    
    cell.displayCode = FALSE;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.dataDictionary = [self.lymphomaList objectAtIndex:indexPath.row];
    
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
    NSDictionary *dict = [self.lymphomaList objectAtIndex:indexPath.row];
    self.lymphomaDetailViewController = [[LymphomaDetailViewController alloc] init];
    self.lymphomaDetailViewController.title = @"Lymphoma Detail";
    self.lymphomaDetailViewController.stage = [dict objectForKey:@"code"];
    //self.stagingTViewController.listID = [dict objectForKey:@"code"];
    [[self navigationController] pushViewController:self.lymphomaDetailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.lymphomaList objectAtIndex:indexPath.row];
    NSString *str = [dict objectForKey:@"description"];
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(232.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    if ((size.height == 0) || (size.height <= 34.0))
        return 34.0 + 5.0;
    else
        return size.height + 5.0;
}

@end
