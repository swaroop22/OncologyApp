//
//  SubCancerListViewController1.m
//  OncologyApp
//
//  Created by Niranjan Kode on 9/27/12.
//
//

#import "SubCancerListViewController1.h"
#import "OncologyAppAppDelegate.h"
#import "CancerListCell.h"

@interface SubCancerListViewController1 ()

@end

@implementation SubCancerListViewController1

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
    [appDelegate getSubCancerTypes1ByCancerTypeID:self.patientTypeId];
    self.cancerList = appDelegate.subCancerTypeList1;
    
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
    int code = [[dict objectForKey:@"code"] intValue];
    OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate getSubCancerTypes2BySubCancerTypeID1:code];
    if ([appDelegate.subCancerTypeList2 count] > 1) {
        self.subCancerListViewController2 = [[SubCancerListViewController2 alloc] init];
        self.subCancerListViewController2.title = @"Sub Types";
        self.subCancerListViewController2.patientTypeId = code;
        [[self navigationController] pushViewController:self.subCancerListViewController2 animated:YES];
    }
    else {
        dict = [appDelegate.subCancerTypeList2 objectAtIndex:0];
        self.regimenListViewController = [[RegimenListViewController alloc] init];
        self.regimenListViewController.title = @"Regimens";
        self.regimenListViewController.listID = [dict objectForKey:@"code"];
        [[self navigationController] pushViewController:self.regimenListViewController animated:YES];            
    }
    
    
}


@end
