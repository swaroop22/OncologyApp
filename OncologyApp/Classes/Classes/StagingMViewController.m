//
//  StagingMViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 10/28/12.
//
//

#import "StagingMViewController.h"
#import "OncologyAppAppDelegate.h"
#import "StagingTNMCell.h"

@interface StagingMViewController ()
- (void)configureView;
@end

@implementation StagingMViewController

NSString *tnmMCell = @"StagingTNMCell";

- (void)configureView {
    OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.tnmM = appDelegate.tnmM;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    self.clearsSelectionOnViewWillAppear = NO;
    cellLoader = [[UINib nibWithNibName:tnmMCell bundle:[NSBundle mainBundle]] retain];
    [self configureView];    
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"All"]) {
        self.stagingDetailViewController = [[StagingDetailViewController alloc] init];
        self.stagingDetailViewController.title = @"Staging Detail";
        self.stagingDetailViewController.t_code = self.t_code;
        self.stagingDetailViewController.n_desc = self.t_desc;
        self.stagingDetailViewController.n_code = self.n_code;
        self.stagingDetailViewController.t_desc = self.n_desc;

        NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *dict = [self.tnmM objectAtIndex:selectedPath.row];
        self.stagingDetailViewController.m_code = [dict objectForKey:@"code"];
        self.stagingDetailViewController.m_desc = [dict objectForKey:@"description"];
        [[self navigationController] pushViewController:self.stagingDetailViewController animated:YES];
    }
}

- (void)dealloc
{
    [self.tnmM release];
    [cellLoader release];
    [super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tnmM count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StagingTNMCell *cell = (StagingTNMCell *)[tableView dequeueReusableCellWithIdentifier:tnmMCell];
    if (cell == nil) {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:self options:nil];
        cell = (StagingTNMCell *)[topLevelItems objectAtIndex:0];
    }
    
    cell.displayCode = TRUE;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.dataDictionary = [self.tnmM objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];

    if (appDelegate.tnmListId == 90) {
        
        self.stagingSViewController = [[StagingSViewController alloc] init];
        self.stagingSViewController.title = @"Select S";
        self.stagingSViewController.t_code = self.t_code;
        self.stagingSViewController.n_desc = self.t_desc;
        self.stagingSViewController.n_code = self.n_code;
        NSDictionary *dict = [self.tnmM objectAtIndex:indexPath.row];
        self.stagingSViewController.m_code = [dict objectForKey:@"code"];
        self.stagingSViewController.m_desc = [dict objectForKey:@"description"];
        [[self navigationController] pushViewController:self.stagingSViewController animated:YES];
    }
    else {
        
        self.stagingDetailViewController = [[StagingDetailViewController alloc] init];
        self.stagingDetailViewController.title = @"Staging Detail";
        self.stagingDetailViewController.t_code = self.t_code;
        self.stagingDetailViewController.n_desc = self.t_desc;
        self.stagingDetailViewController.n_code = self.n_code;
        self.stagingDetailViewController.t_desc = self.n_desc;
        NSDictionary *dict = [self.tnmM objectAtIndex:indexPath.row];
        self.stagingDetailViewController.m_code = [dict objectForKey:@"code"];
        self.stagingDetailViewController.m_desc = [dict objectForKey:@"description"];
        [[self navigationController] pushViewController:self.stagingDetailViewController animated:YES];
    }
//    [self performSegueWithIdentifier:@"All" sender:self];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.tnmM objectAtIndex:indexPath.row];
    NSString *str = [dict objectForKey:@"description"];
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(232.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    if ((size.height == 0) || (size.height <= 34.0))
        return 34.0;
    else
        return size.height + 5.0;
}


@end
