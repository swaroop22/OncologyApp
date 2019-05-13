//
//  StagingNViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 10/28/12.
//
//

#import "StagingNViewController.h"
#import "OncologyAppAppDelegate.h"
#import "StagingTNMCell.h"

@interface StagingNViewController ()
- (void)configureView;
@end

@implementation StagingNViewController

NSString *tnmNCell = @"StagingTNMCell";

- (void)configureView {
    OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.tnmN = appDelegate.tnmN;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    self.clearsSelectionOnViewWillAppear = NO;
    cellLoader = [[UINib nibWithNibName:tnmNCell bundle:[NSBundle mainBundle]] retain];
    [self configureView];
    
    return self;
}

- (void)dealloc
{
    [self.tnmN release];
    [cellLoader release];
    [super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tnmN count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StagingTNMCell *cell = (StagingTNMCell *)[tableView dequeueReusableCellWithIdentifier:tnmNCell];
    if (cell == nil) {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:self options:nil];
        cell = (StagingTNMCell *)[topLevelItems objectAtIndex:0];
    }
    
    cell.displayCode = TRUE;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.dataDictionary = [self.tnmN objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.stagingMViewController = [[StagingMViewController alloc] init];
    self.stagingMViewController.title = @"Select M";
    self.stagingMViewController.t_code = self.t_code;
    self.stagingMViewController.t_desc = self.t_desc;
    NSDictionary *dict = [self.tnmN objectAtIndex:indexPath.row];
    self.stagingMViewController.n_code = [dict objectForKey:@"code"];
    self.stagingMViewController.n_desc = [dict objectForKey:@"description"];
    [[self navigationController] pushViewController:self.stagingMViewController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.tnmN objectAtIndex:indexPath.row];
    NSString *str = [dict objectForKey:@"description"];
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(232.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    if ((size.height == 0) || (size.height <= 34.0))
        return 34.0;
    else
        return size.height + 5.0;
}


@end
