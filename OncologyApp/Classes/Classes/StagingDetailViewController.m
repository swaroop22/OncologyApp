//
//  StagingDetailViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 10/28/12.
//
//

#import "StagingDetailViewController.h"
#import "OncologyAppAppDelegate.h"
#import "StagingTNMCell.h"

@interface StagingDetailViewController ()
- (void)configureView;
@end

@implementation StagingDetailViewController

#define SETTING_HEADER_FONT_SIZE 16.0
#define SETTING_HEADER_HEIGHT 40.0
#define SETTING_HEADER_ROW_WIDTH 320.0

//NSString *tnmMCell = @"StagingTNMCell";

- (void)configureView {
    OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.stage = [appDelegate getStagingByTNM:self.t_code n_code:self.n_code m_code:self.m_code];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (void) viewDidLoad
{
    //[super viewDidUnload];
    //self.view.backgroundColor = [UIColor colorWithRed:255 green:245 blue:204 alpha:1];
    [self configureView];
    
}

- (void)dealloc
{
    [super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = nil;
    switch (section) {
        case 0:
            title = @"Selected T";
            break;
            
        case 1:
            title = @"Selected N";
            break;
            
        case 2:
            title = @"Selected M";
            break;
            
        case 3:
            title = @"Stage";
            break;
            
        case 4:
            title = @"Note";
            break;
            
        default:
            break;
    }
    
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        // Create a new cell. CGRectZero allows the cell to determine the appropriate size.
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"MyIdentifier"] autorelease];
        //cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"MyIdentifier"] autorelease];
    }
	NSString *cellText;
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.textColor = [UIColor blackColor];
    switch (indexPath.section) {
        case 0:
            cellText = [NSString stringWithFormat:@"%@: %@", self.t_code, self.t_desc];
            break;
            
        case 1:
            cellText = [NSString stringWithFormat:@"%@: %@", self.n_code, self.n_desc];
            break;
            
        case 2:
            cellText = [NSString stringWithFormat:@"%@: %@", self.m_code, self.m_desc];
            break;
            
        case 3:
            //OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
            cellText = self.stage;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
            cell.textLabel.textColor = [UIColor redColor];
            break;

        case 4:
            cellText = @"Note: cTNM is the clinical classification, pTNM is the pathologic classification.\n* A tumor may penetrate the muscularis propria with extension into the gastrocolic or gastrohepatic ligaments, or into the greater or lesser omentum, without perforation of the visceral peritoneum covering these structures. In this case, the tumor is classified T3. If there is perforation of the visceral peritoneum covering the gastric ligaments or the omentum, the tumor should be classified T4.\n●The adjacent structures of the stomach include the spleen, transverse colon, liver, diaphragm, pancreqa, abdominal wall, adrenal gland, kidney, small intestine, and retroperitoneum.\n∆ Intramural extension to the duodenum or esophagus is classified by the depth of the greatest invasion in any of these sites, including the stomach.\n◊A designation of pNO should be used if all examined lymph nodes are negative, regardless of the total number removed and examined, Used with the permission of the American Joint Committee on Cancer (AJCC), Chicago, Illinois. The original source for this material is the AJCC Cancer Staging Manual, Seventh Edition (2010) published by Springer New York, Inc.";
            cellText = @"";
            break;

        default:
            break;
    }
    
    cell.textLabel.numberOfLines = 0;
    //cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    [cell.textLabel sizeToFit];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = cellText;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellText = nil;
    switch (indexPath.section) {
        case 0:
            cellText = [NSString stringWithFormat:@"%@:%@", self.t_code, self.t_desc];
            break;
            
        case 1:
            cellText = [NSString stringWithFormat:@"%@:%@", self.n_code, self.n_desc];
            break;
            
        case 2:
            cellText = [NSString stringWithFormat:@"%@:%@", self.m_code, self.m_desc];
            break;
            
        case 3:
            cellText = self.stage;
            break;
            
        case 4:
            cellText = @"cTNM is the clinical classification, pTNM is the pathologic classification.\n\n* A tumor may penetrate the muscularis propria with extension into the gastrocolic or gastrohepatic ligaments, or into the greater or lesser omentum, without perforation of the visceral peritoneum covering these structures. In this case, the tumor is classified T3. If there is perforation of the visceral peritoneum covering the gastric ligaments or the omentum, the tumor should be classified T4.\n\n●The adjacent structures of the stomach include the spleen, transverse colon, liver, diaphragm, pancreqa, abdominal wall, adrenal gland, kidney, small intestine, and retroperitoneum.\n\n∆ Intramural extension to the duodenum or esophagus is classified by the depth of the greatest invasion in any of these sites, including the stomach.\n\n◊A designation of pNO should be used if all examined lymph nodes are negative, regardless of the total number removed and examined, Used with the permission of the American Joint Committee on Cancer (AJCC), Chicago, Illinois. The original source for this material is the AJCC Cancer Staging Manual, Seventh Edition (2010) published by Springer New York, Inc.";
            cellText = @"";
            break;
            
        default:
            break;
    }
    
    CGSize size = [cellText sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(320.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    if ((size.height == 0) || (size.height <= 34.0))
        return 34.0;
    else
        return size.height + 5.0;
}


@end
