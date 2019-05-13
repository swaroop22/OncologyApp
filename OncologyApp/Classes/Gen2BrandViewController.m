//
//  Gen2BrandViewController.m
//  OncAmigo
//
//  Created by Niranjan Kode on 2/6/16.
//
//

#import "Gen2BrandViewController.h"
#import "OncologyAppAppDelegate.h"


@interface Gen2BrandViewController ()

@end

@implementation Gen2BrandViewController

static NSString *CellClassName = @"Gen2BrandTableViewCell";

OncologyAppAppDelegate *appDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    cellLoader = [[UINib nibWithNibName:CellClassName bundle:[NSBundle mainBundle]] retain];
    
    return self;
}

- (void)dealloc
{
    [cellLoader release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableData = appDelegate.gen2brandArray;
    self.searchResult = [NSMutableArray arrayWithCapacity:[self.tableData count]];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResult count];
    }
    else {
        return [self.tableData count];
    }
}

- (CGFloat) tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //static NSString *MyIdentifier = @"MyIdentifier";
    
    Gen2BrandTableViewCell *cell = (Gen2BrandTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellClassName];

    if (!cell)
    {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:self options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }

//    //Gen2BrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
//    if (cell == nil) {
//        cell = [[[Gen2BrandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                       reuseIdentifier:CellClassName] autorelease];
//    }
    NSDictionary *dict = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        dict = [self.searchResult objectAtIndex:indexPath.row];
    }
    else {
        dict = [self.tableData objectAtIndex:indexPath.row];
    }
    cell.genericLabel.text = [dict objectForKey:@"generic"];
    cell.brandLabel.text = [dict objectForKey:@"brand_name"];
    
    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.searchResult removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"(generic contains[c] %@) OR (brand_name contains[c] %@)", searchText, searchText];
    
    self.searchResult = [NSMutableArray arrayWithArray: [self.tableData filteredArrayUsingPredicate:resultPredicate]];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}
@end
