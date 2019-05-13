//
//  PrognosticScoresViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 1/21/13.
//
//

#import "OncologyAppAppDelegate.h"
#import "ECOGTCSubGroupsViewController.h"
#import "PrognosticScoresViewController.h"
#import "StagingTNMCell.h"

@interface ECOGTCSubGroupsViewController ()
- (void)configureView;

@end

NSMutableArray *selectedDict;


@implementation ECOGTCSubGroupsViewController

NSString *ecogtcCellName = @"StagingTNMCell";

- (void)configureView
{
}

- (void)viewDidLoad
{
    self.clearsSelectionOnViewWillAppear = NO;
    cellLoader = [[UINib nibWithNibName:ecogtcCellName bundle:[NSBundle mainBundle]] retain];

    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self configureView];
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
    return [self.ECOGTCSubGroups count];
    //return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StagingTNMCell *cell = (StagingTNMCell *)[tableView dequeueReusableCellWithIdentifier:ecogtcCellName];
    if (cell == nil) {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:self options:nil];
        cell = (StagingTNMCell *)[topLevelItems objectAtIndex:0];
    }
    
    cell.displayCode = FALSE;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.dataDictionary = [self.ECOGTCSubGroups objectAtIndex:indexPath.row];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.ECOGTCSubGroups objectAtIndex:indexPath.row];
    
    PrognosticScoresViewController *vc = [[PrognosticScoresViewController alloc] init];
    vc.title = [dict objectForKey:@"description"];
    vc.scaleName = @"ECOGTC";
    vc.subGroupId = [[dict objectForKey:@"SubGroupId"] intValue];
    vc.detailTitle = [vc.title stringByAppendingString:@" Grade"];
    [[self navigationController] pushViewController:vc animated:YES];
    [vc release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.ECOGTCSubGroups objectAtIndex:indexPath.row];
    NSString *str = [dict objectForKey:@"description"];
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(232.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    if ((size.height == 0) || (size.height <= 34.0))
        return 34.0 + 5.0;
    else
        return size.height + 5.0;
}

- (void)dealloc {
	//[self.ECOGTCSubGroups release];
    [cellLoader release];
	[super dealloc];
}


@end
