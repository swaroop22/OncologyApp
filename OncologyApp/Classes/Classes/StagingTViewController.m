    //
//  StagingTViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 10/28/12.
//
//

#import "StagingTViewController.h"
#import "OncologyAppAppDelegate.h"
#import "StagingTNMCell.h"

@interface StagingTViewController ()
- (void)configureView;
@end

@implementation StagingTViewController

NSString *tnmTCell = @"StagingTNMCell";

- (void)configureView {
    OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.tnmT = appDelegate.tnmT;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    self.clearsSelectionOnViewWillAppear = NO;
    cellLoader = [[UINib nibWithNibName:tnmTCell bundle:[NSBundle mainBundle]] retain];
    [self configureView];
    
    return self;
}

- (void)dealloc
{
    [self.tnmT release];
    [cellLoader release];
    [super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tnmT count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StagingTNMCell *cell = (StagingTNMCell *)[tableView dequeueReusableCellWithIdentifier:tnmTCell];
    if (cell == nil) {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:self options:nil];
        cell = (StagingTNMCell *)[topLevelItems objectAtIndex:0];
    }
    
    cell.displayCode = TRUE;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.dataDictionary = [self.tnmT objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.stagingNViewController = [[StagingNViewController alloc] init];
    self.stagingNViewController.title = @"Select N";
    NSDictionary *dict = [self.tnmT objectAtIndex:indexPath.row];
    self.stagingNViewController.t_code = [dict objectForKey:@"code"];
    self.stagingNViewController.t_desc = [dict objectForKey:@"description"];
    [[self navigationController] pushViewController:self.stagingNViewController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.tnmT objectAtIndex:indexPath.row];
    NSString *str = [dict objectForKey:@"description"];
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(232.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    if ((size.height == 0) || (size.height <= 34.0))
        return 34.0 + 5.0;
    else
        return size.height + 5.0;
}

@end
