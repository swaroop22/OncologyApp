//
//  SubCancerListViewController1.m
//  OncologyApp
//
//  Created by Niranjan Kode on 9/27/12.
//
//

#import "SubCancerListViewController2.h"
#import "OncologyAppAppDelegate.h"
#import "CancerListCell.h"

@interface SubCancerListViewController2 ()

@end

@implementation SubCancerListViewController2

@synthesize cancerList, cancerListTableView;

static NSString *CellClassName = @"CancerListCell";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    cellLoader = [[UINib nibWithNibName:CellClassName bundle:[NSBundle mainBundle]] retain];

    return self;
}

- (void)viewDidLoad
{
	OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate getSubCancerTypes2BySubCancerTypeID1:self.patientTypeId];
    self.cancerList = appDelegate.subCancerTypeList2;
    
    [super viewDidLoad];
}

- (void)dealloc
{
    [cancerList release];
    [cellLoader release];
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cancerList count];
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
    cell.dataDictionary = [self.cancerList objectAtIndex:indexPath.row];

    // Note: I set the cell's Identifier property in Interface Builder to DemoTableViewCell.
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.cancerList objectAtIndex:indexPath.row];
    self.regimenListViewController = [[RegimenListViewController alloc] init];
    self.regimenListViewController.title = @"Regimens";
    self.regimenListViewController.listID = [dict objectForKey:@"code"];
    [[self navigationController] pushViewController:self.regimenListViewController animated:YES];
}


@end
