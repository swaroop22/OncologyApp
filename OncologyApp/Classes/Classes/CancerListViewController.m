//
//  CancerListViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 9/27/12.
//
//

#import "CancerListViewController.h"
#import "OncologyAppAppDelegate.h"
#import "CancerListCell.h"

@interface CancerListViewController ()

@end

@implementation CancerListViewController

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
    [appDelegate getCancerTypesByPatientTypeID:self.patientTypeId];
    self.cancerList = appDelegate.cancerTypeList;
    
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
    [appDelegate getSubCancerTypes1ByCancerTypeID:code];
    if ([appDelegate.subCancerTypeList1 count] > 1) {
        self.subCancerListViewController1 = [[SubCancerListViewController1 alloc] init];
        self.subCancerListViewController1.title = @"Sub Types";
        self.subCancerListViewController1.patientTypeId = code;
        [[self navigationController] pushViewController:self.subCancerListViewController1 animated:YES];
    }
    else {
        dict = [appDelegate.subCancerTypeList1 objectAtIndex:0];
        code = [[dict objectForKey:@"code"] intValue];
        [appDelegate getSubCancerTypes2BySubCancerTypeID1:code];
        if ([appDelegate.subCancerTypeList2 count] > 1) {
        }
        else {
            dict = [appDelegate.subCancerTypeList2 objectAtIndex:0];
            self.regimenListViewController = [[RegimenListViewController alloc] init];
            self.regimenListViewController.title = @"Regimens";
            self.regimenListViewController.listID = [dict objectForKey:@"code"];
            [[self navigationController] pushViewController:self.regimenListViewController animated:YES];            
        }
    }
    
    
}


@end
