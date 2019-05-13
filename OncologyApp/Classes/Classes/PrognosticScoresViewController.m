//
//  PrognosticScoresViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 1/21/13.
//
//

#import "OncologyAppAppDelegate.h"
#import "PrognosticScoresViewController.h"
#import "StagingTNMCell.h"

@interface PrognosticScoresViewController ()
- (void)configureView;
- (void)displayDetail: (NSIndexPath *)indexPath;

@end

NSMutableArray *karnofskyDict;
NSMutableArray *ecogDict;
NSMutableArray *responseCriteria;
NSMutableArray *selectedDict;


@implementation PrognosticScoresViewController

NSString *cellName = @"StagingTNMCell";

- (void)configureView
{
    karnofskyDict = [[NSMutableArray alloc] init];
    [karnofskyDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"100", @"code",
                               @"Normal, no complaints, no evidence of disease", @"description", nil]];
    [karnofskyDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"90", @"code",
                              @"Able to carry on normal activity, minor signs or symptoms of disease", @"description", nil]];
    [karnofskyDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"80", @"code",
                              @"Normal activity with effort, some signs or symptoms of disease", @"description", nil]];
    [karnofskyDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"70", @"code",
                              @"Cares for self, unable to carry on normal activity or to do active work", @"description", nil]];
    [karnofskyDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"60", @"code",
                              @"Requires occasional assistance, but is able to care for most needs", @"description", nil]];
    [karnofskyDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"50", @"code",
                              @"Requires considerable assistance and frequent medical care", @"description", nil]];
    [karnofskyDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"40", @"code",
                              @"Disabled, requires special care and assistance", @"description", nil]];
    [karnofskyDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"30", @"code",
                              @"Severely disabled, hospitalization is indicated although death is not imminent", @"description", nil]];
    [karnofskyDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"20", @"code",
                              @"Hospitalization is necessarym very sick, active supportive treatment necessary", @"description", nil]];
    [karnofskyDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"10", @"code",
                              @"Moribund, fatal processes progressing rapidly", @"description", nil]];
    [karnofskyDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"0", @"code",
                              @"Dead", @"description", nil]];

    ecogDict = [[NSMutableArray alloc] init];
    [ecogDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"0", @"code",
                              @"Fully active; no performance restrictions", @"description", nil]];
    [ecogDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         @"1", @"code",
                         @"Strenuous physical activity restricted; fully ambulatory and able to carry out light work", @"description", nil]];
    [ecogDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         @"2", @"code",
                         @"Capable of all selfcare but unable to carry out any work activities. Up and about > 50% of waking hours", @"description", nil]];
    [ecogDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         @"3", @"code",
                         @"Capable of only limited selfcare; confined to bed or chair > 50% of waking hours", @"description", nil]];
    [ecogDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         @"4", @"code",
                         @"Completely disabled; cannot carry out any selfcare; totally confined to bed or chair", @"description", nil]];
    
    responseCriteria = [[NSMutableArray alloc] init];
    [responseCriteria addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         @"Complete Response (CR)", @"code",
                         @"Disappearance of all target lesions", @"description", nil]];
    [responseCriteria addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                 @"Partial Response (PR)", @"code",
                                 @"At least a 30% decrease in the sum of the LD of target lesions, taking as reference the baseline sum LD", @"description", nil]];
    [responseCriteria addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                 @"Stable Disease (SD)", @"code",
                                 @"Neither sufficient shrinkage to qualify for PR nor sufficient increase to qualify for PD, taking as reference the smallest sum LD since the treatment started", @"description", nil]];
    [responseCriteria addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                 @"Progressive Disease (PD)", @"code",
                                 @"At least a 20% increase in the sum of the LD of target lesions, taking as reference the smallest sum LD recorded since the treatment started or the appearance of one or more new lesions", @"description", nil]];
    [responseCriteria addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                 @"Complete Response (CR)", @"code",
                                 @"Disappearance of all non-target lesions and normalization of tumor marker level", @"description", nil]];
    [responseCriteria addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                 @"Incomplete Response/Stable Disease (SD)", @"code",
                                 @"Persistence of one or more non-target lesion(s) or/and maintenance of tumor marker level above the normal limits", @"description", nil]];
    [responseCriteria addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                 @"Progressive Disease (PD)", @"code",
                                 @"Appearance of one or more new lesions and/or unequivocal progression of existing non-target lesions", @"description", nil]];

    if ([self.scaleName isEqual: @"Karnofsky"])
    {
        selectedDict = karnofskyDict;
    }
    else if ([self.scaleName isEqual: @"ECOG"])
    {
        selectedDict = ecogDict;
    }
    else if ([self.scaleName isEqual: @"RC"])
    {
        selectedDict = responseCriteria;
    }
    else
    {
        OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
        selectedDict = [appDelegate loadECOGTCOptions:self.subGroupId];
    }
}

- (void)viewDidLoad
{
    self.clearsSelectionOnViewWillAppear = NO;
    cellLoader = [[UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]] retain];

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
    return [selectedDict count];
    //return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StagingTNMCell *cell = (StagingTNMCell *)[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        NSArray *topLevelItems = [cellLoader instantiateWithOwner:self options:nil];
        cell = (StagingTNMCell *)[topLevelItems objectAtIndex:0];
    }
    
    cell.displayCode = FALSE;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.dataDictionary = [selectedDict objectAtIndex:indexPath.row];

    return cell;
}

#pragma mark - Table view delegate

- (void)displayDetail: (NSIndexPath *)indexPath
{
    
    NSDictionary *dict = [selectedDict objectAtIndex:indexPath.row];
    NSString *score = [dict objectForKey:@"code"];
    
    self.detailViewController = [[PrognosticScoresDetailViewController alloc] init];
    self.detailViewController.titleText = self.detailTitle;
    
    if ([self.scaleName isEqual: @"RC"])
    {
        self.detailViewController.scoreText3 = score;
    }
    else
    {
        self.detailViewController.scoreText = score;
    }
    self.detailViewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    
	[[self navigationController] presentViewController:self.detailViewController animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //[self displayDetail:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [selectedDict objectAtIndex:indexPath.row];
    NSString *score = [dict objectForKey:@"code"];
    
    self.detailViewController = [[PrognosticScoresDetailViewController alloc] init];
    self.detailViewController.titleText = self.detailTitle;

    if ([self.scaleName isEqual: @"RC"])
    {
        self.detailViewController.scoreText3 = score;
    }
    else
    {
        self.detailViewController.scoreText = score;        
    }
    self.detailViewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    
	[[self navigationController] presentViewController:self.detailViewController animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [selectedDict objectAtIndex:indexPath.row];
    NSString *str = [dict objectForKey:@"description"];
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(232.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    if ((size.height == 0) || (size.height <= 34.0))
        return 34.0 + 5.0;
    else
        return size.height + 5.0;
}

- (void)dealloc {
	//[karnofskyDict release];
	//[ecogDict release];
	//[selectedDict release];
    [cellLoader release];
	[super dealloc];
}


@end
