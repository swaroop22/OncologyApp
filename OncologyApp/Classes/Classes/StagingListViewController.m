//
//  StagingTViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 10/28/12.
//
//

#import "StagingListViewController.h"
#import "OncologyAppAppDelegate.h"
#import "StagingTNMCell.h"
#import "Util.h"

@interface StagingListViewController ()
- (void)configureView;
@end

@implementation StagingListViewController


NSString *tnmListCell = @"StagingTNMCell";


- (void)configureView {
    OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.tnmList = appDelegate.tnmList;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    self.clearsSelectionOnViewWillAppear = NO;
    self.view.opaque = YES;
    self.view.backgroundColor = [Util colorWithHexString:@"0xFFFFCC"];
    //[UIColor colorWithRed:255.0 green:255.0 blue:153.0 alpha:1.0];
    cellLoader = [[UINib nibWithNibName:tnmListCell bundle:[NSBundle mainBundle]] retain];
    [self configureView];
    
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSLog(@"process Name:  Process ID");
}

- (void)dealloc
{
    [self.tnmList release];
    [cellLoader release];
    [super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tnmList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StagingTNMCell *cell = (StagingTNMCell *)[tableView dequeueReusableCellWithIdentifier:tnmListCell];
    if (cell == nil) {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:self options:nil];
        cell = (StagingTNMCell *)[topLevelItems objectAtIndex:0];
    }
    
    cell.displayCode = FALSE;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.dataDictionary = [self.tnmList objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.tnmList objectAtIndex:indexPath.row];
    int listID = [[dict objectForKey:@"code"] intValue];
    OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.tnmListId = listID;
    [appDelegate loadTNMByID:listID];

    self.stagingTViewController = [[StagingTViewController alloc] init];
    self.stagingTViewController.title = @"Select T";
    //self.stagingTViewController.listID = [dict objectForKey:@"code"];
    [[self navigationController] pushViewController:self.stagingTViewController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.tnmList objectAtIndex:indexPath.row];
    NSString *str = [dict objectForKey:@"description"];
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(232.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    if ((size.height == 0) || (size.height <= 34.0))
        return 34.0 + 5.0;
    else
        return size.height + 5.0;
}

@end
