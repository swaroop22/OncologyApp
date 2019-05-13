//
//  RootViewController.m
//  OncologyApp
//
//  Created by Satheesh Kathula on 10/14/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "RootViewController.h"
#import "OncologyAppAppDelegate.h"
#import "RegimenVC.h"
#import "MainViewController.h"
#import "Util.h"
#import "Classes/PrognosticCalculatorRevisedViewController.h"


@implementation RootViewController
@synthesize listContent, regimenVC, myTableView;

OncologyAppAppDelegate *appDelegate;
static NSString *MyIdentifier = @"MyIdentifier";

- (void)viewDidLoad {
    
    appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];

    sectionsToggle = [[NSMutableArray alloc] init];
    [sectionsToggle addObject:@"1"];
    [sectionsToggle addObject:@"0"];
    [sectionsToggle addObject:@"0"];
    [sectionsToggle addObject:@"0"];
    [sectionsToggle addObject:@"0"];
    [sectionsToggle addObject:@"0"];
    
    regimenDict = [[NSMutableArray alloc] init];
    [regimenDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                      @"10", @"code",
                      @"Adults - Chemo Regimens", @"description", nil]];
    [regimenDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            @"11", @"code",
                            @"Pediatric - Chemo Regimens", @"description", nil]];

    
    stagingDict = [[NSMutableArray alloc] init];
    [stagingDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            @"20", @"code",
                            @"TNM", @"description", nil]];
    [stagingDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            @"21", @"code",
                            @"Lymphoma", @"description", nil]];
    [stagingDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            @"22", @"code",
                            @"Myeloma", @"description", nil]];
    
    progCalculatorDict = [[NSMutableArray alloc] init];
    [progCalculatorDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                   @"40", @"code",
                                   @"IPI", @"type",
                                   @"R-IPI", @"description", nil]];
    [progCalculatorDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                   @"41", @"code",
                                   @"AAIPI", @"type",
                                   @"Age Adjusted IPI", @"description", nil]];
    [progCalculatorDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                   @"42", @"code",
                                   @"FLIPI", @"type",
                                   @"FLIPI", @"description", nil]];
    [progCalculatorDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                   @"43", @"code",
                                   @"IPSS", @"type",
                                   @"MDS IPSS", @"description", nil]];
    [progCalculatorDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                   @"44", @"code",
                                   @"IPSS-R", @"type",
                                   @"MDS Revised IPSS", @"description", nil]];
    [progCalculatorDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                   @"45", @"code",
                                   @"WHO", @"type",
                                   @"MDS WHO IPSS", @"description", nil]];
    [progCalculatorDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                   @"46", @"code",
                                   @"RCC", @"type",
                                   @"RCC - MSKCC Prognostic Scale", @"description", nil]];
    [progCalculatorDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                   @"50", @"code",
                                   @"Karnofsky Performance", @"description", nil]];
    [progCalculatorDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                   @"51", @"code",
                                   @"ECOG Performance", @"description", nil]];
    
    calculatorDict = [[NSMutableArray alloc] init];
    [calculatorDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            @"30", @"code",
                            @"Absolute Neutrophil #", @"description", nil]];
    [calculatorDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"31", @"code",
                               @"BSA Calculator", @"description", nil]];
    [calculatorDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"32", @"code",
                               @"BMI Calculator", @"description", nil]];
    [calculatorDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"33", @"code",
                               @"Creatinine Clearance Estimated", @"description", nil]];
    [calculatorDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"34", @"code",
                               @"Carboplatin Dosing", @"description", nil]];
    [calculatorDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"35", @"code",
                               @"Temperature Converter", @"description", nil]];
    

    responseCriteriaDict = [[NSMutableArray alloc] init];
    [responseCriteriaDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                   @"60", @"code",
                                   @"RECIST Criteria", @"description", nil]];

    gen2BrandDict = [[NSMutableArray alloc] init];
    [gen2BrandDict addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                     @"70", @"code",
                                     @"Generic - Brand Name", @"description", nil]];

    self.title = @"OncAmigo";
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    bool isOpen = ([[sectionsToggle objectAtIndex:section] isEqual: @"1"]);
    switch (section) {
        case 0:
            rows = [regimenDict count];
            break;
            
        case 1:
            rows = [progCalculatorDict count];
            break;

        case 2:
            rows = [calculatorDict count];
            break;
            
        case 3:
        {
            rows = [appDelegate.ECOGTCGroup count];
            break;
        }
        case 4:
            rows = [responseCriteriaDict count];
            break;
        case 5:
            rows = [gen2BrandDict count];
            break;
        default:
            break;
    }
    if (isOpen)
    {
        return rows;
    }
    else
    {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 39.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 39)];
    
    UILabel *lblSection = [UILabel new];
    [lblSection setFrame:CGRectMake(0, 0, tableView.frame.size.width, 38)];
    [lblSection setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [lblSection setBackgroundColor:[UIColor clearColor]];
    [lblSection setTextColor:[UIColor whiteColor]];
    //lblSection.alpha = 0.5;
    
    NSMutableString *title = [[NSMutableString alloc] init];
    bool isOpen = ([[sectionsToggle objectAtIndex:section] isEqual: @"1"]);
    if (isOpen)
    {
        [title appendString:@" \u25B3 "];
        //title = [@" \u25B3 " stringByAppendingString:title];
    }
    else
    {
        [title appendString:@" \u25B7 "];
        //title = [@" \u25B7 " stringByAppendingString:title];
    }
    
    switch (section) {
        case 0:
            [title appendString:@" Chemotherapy Regimens"];
            //title = @" Chemotherapy Regimens";
            break;
        case 1:
            [title appendString:@" Prognostic Calculators"];
            //title = @" Prognostic Calculators";
            break;
            
        case 2:
            [title appendString:@" Formulas"];
            //title = @" Formulas";
            break;
            
        case 3:
            [title appendString:@" Chemotherapy Toxicity Grading Scale"];
            //title = @" Chemotherapy Toxicity Grading Scale";
            break;
            
        case 4:
            [title appendString:@" Response Criteria"];
            //title = @" Response Criteria";
            break;
            
        case 5:
            [title appendString:@" Generic - Brand Name"];
            //title = @" Response Criteria";
            break;

        default:
            break;
    }
    
    [lblSection setText:title];
    [title release];
    
    
    UIButton *btnCollapse = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCollapse setFrame:CGRectMake(0, 0, tableView.frame.size.width, 38)];
    [btnCollapse setBackgroundColor:[UIColor blackColor]];
    [btnCollapse addTarget:self action:@selector(toggleSection:) forControlEvents:UIControlEventTouchUpInside];
    btnCollapse.tag = section;
    
    
    [headerView addSubview:btnCollapse];
    [headerView addSubview:lblSection];
    
    return [headerView autorelease];
}


- (void)toggleSection:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSInteger section = btn.tag;
    if ([[sectionsToggle objectAtIndex:section] isEqual: @"1"])
    {
        [sectionsToggle replaceObjectAtIndex:section withObject:@"0"];
    }
    else
    {
        [sectionsToggle replaceObjectAtIndex:section withObject:@"1"];        
    }
    [myTableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }

    NSDictionary *dict = nil;
    switch (indexPath.section) {
        case 0:
            
            dict = [regimenDict objectAtIndex:indexPath.row];
            break;
            
        case 1:
            dict = [progCalculatorDict objectAtIndex:indexPath.row];
            break;

        case 2:
            dict = [calculatorDict objectAtIndex:indexPath.row];
            break;
            
        case 3:
            dict = [appDelegate.ECOGTCGroup objectAtIndex:indexPath.row];
            break;

        case 4:
            dict = [responseCriteriaDict objectAtIndex:indexPath.row];
            break;
        case 5:
            dict = [gen2BrandDict objectAtIndex:indexPath.row];
            break;

        default:
            break;
    }

    cell.textLabel.text = [dict objectForKey:@"description"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15]; //[UIFont fontWithName:@"Helvetica-Bold" size:14.0];
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //[dict release];
    
	return cell;
}


 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

     NSDictionary *dict = nil;
     switch (indexPath.section) {
         case 0:
             
             dict = [regimenDict objectAtIndex:indexPath.row];
             break;
             
//         case 1:
//             dict = [stagingDict objectAtIndex:indexPath.row];
//             break;
             
         case 1:
             dict = [progCalculatorDict objectAtIndex:indexPath.row];
             break;

         case 2:
             dict = [calculatorDict objectAtIndex:indexPath.row];
             break;
             
         case 3:
             dict = [appDelegate.ECOGTCGroup objectAtIndex:indexPath.row];
             break;

         case 4:
             dict = [responseCriteriaDict objectAtIndex:indexPath.row];
             break;
         case 5:
             dict = [gen2BrandDict objectAtIndex:indexPath.row];
             break;

         default:
             break;
     }
     int code = [[dict objectForKey:@"code"] intValue];
     NSString* description = [dict objectForKey:@"description"];
     
     switch (code) {
         case 10:
         case 11:
         {
             self.cancerListViewController = [[CancerListViewController alloc] init];
             self.cancerListViewController.title = description;
             NSDictionary *dict2 = nil;
             dict2 = [appDelegate.patientTypeList objectAtIndex:(code-10)];
             self.cancerListViewController.patientTypeId = [[dict2 objectForKey:@"code"] intValue];
             [[self navigationController] pushViewController:self.cancerListViewController animated:YES];
             break;
         }
         case 20:
             self.stagingListViewController = [[StagingListViewController alloc] init];
             self.stagingListViewController.title = description;
             [[self navigationController] pushViewController:self.stagingListViewController animated:YES];
             break;
         case 21:
             self.lymphomaListViewController = [[LymphomaListViewController alloc] init];
             self.lymphomaListViewController.title = description;
             [[self navigationController] pushViewController:self.lymphomaListViewController animated:YES];
             break;
         case 22:
             self.myelomaViewController = [[MyelomaViewController alloc] init];
             self.myelomaViewController.title = description;
             [[self navigationController] pushViewController:self.myelomaViewController animated:YES];
             break;
         case 30:
             self.absViewController = [[AbsNeutrophilCountViewController alloc] init];
             self.absViewController.title = description;
             [[self navigationController] pushViewController:self.absViewController animated:YES];
             break;
         case 31:
             self.bsaViewController = [[BSACalculatorViewController alloc] init];
             self.bsaViewController.title = description;
             [[self navigationController] pushViewController:self.bsaViewController animated:YES];
             break;
         case 32:
             self.bmiViewController = [[BMIViewController alloc] init];
             self.bmiViewController.title = description;
             [[self navigationController] pushViewController:self.bmiViewController animated:YES];
             break;
         case 33:
             self.ccrViewController = [[CcrCalculatorViewController alloc] init];
             self.ccrViewController.title = description;
             [[self navigationController] pushViewController:self.ccrViewController animated:YES];
             break;
         case 34:
             self.cpCalcViewController = [[CPCalculatorViewController alloc] initWithNibName:@"CPCalculatorViewController" bundle:nil];
             self.cpCalcViewController.title = description;
             [[self navigationController] pushViewController:self.cpCalcViewController animated:YES];
             break;
         case 35:
             self.tempViewController = [[TemperatureViewController alloc] init];
             self.tempViewController.title = description;
             [[self navigationController] pushViewController:self.tempViewController animated:YES];
             break;

         case 40:
         case 41:
         case 42:
         case 43:
         case 44:
         case 45:
         case 46:
         {
             NSString *mynibName = @"PrognosticRevisedViewController";
             PrognosticCalculatorRevisedViewController *pvc = [[PrognosticCalculatorRevisedViewController alloc] initWithNibName:mynibName bundle:nil];
             pvc.title = description;
             pvc.type = [dict objectForKey:@"type"];
             [[self navigationController] pushViewController:pvc animated:YES];
             [pvc release];
             [mynibName release];
             break;
         }
         case 50:
             self.progScoresViewController = [[PrognosticScoresViewController alloc] init];
             //self.progScoresViewController.nibName = @"PrognosticKarnofskyScaleViewController";
             self.progScoresViewController.title = description;
             self.progScoresViewController.scaleName = @"Karnofsky";
             self.progScoresViewController.detailTitle = @"Karnofsky Score";
             [[self navigationController] pushViewController:self.progScoresViewController animated:YES];
             [self.progScoresViewController release];
             break;

         case 51:
             self.progScoresViewController = [[PrognosticScoresViewController alloc] init];
             self.progScoresViewController.title = description;
             self.progScoresViewController.scaleName = @"ECOG";
             self.progScoresViewController.detailTitle = @"ECOG Performance Score";

             [[self navigationController] pushViewController:self.progScoresViewController animated:YES];
             [self.progScoresViewController release];
             break;

         case 60:
             self.progScoresViewController = [[PrognosticScoresViewController alloc] init];
             self.progScoresViewController.title = description;
             self.progScoresViewController.scaleName = @"RC";
             self.progScoresViewController.detailTitle = @"RECIST Criteria";
             
             [[self navigationController] pushViewController:self.progScoresViewController animated:YES];
             [self.progScoresViewController release];
             break;

         case 70:
             self.gen2brandVC = [[Gen2BrandViewController alloc] init];
             self.gen2brandVC.title = description;
             
             [[self navigationController] pushViewController:self.gen2brandVC animated:YES];
             [self.gen2brandVC release];
             break;

         default:
         {
             if ((code >= 100) && (code <= 330))
             {
                 // get subgroups
                 NSMutableArray* ECOGTCSubGroups = [appDelegate loadECOGTCSubGroup:code];
                 if ([ECOGTCSubGroups count] == 1)
                 {
                     // Display options
                     self.progScoresViewController = [[PrognosticScoresViewController alloc] init];
                     self.progScoresViewController.title = [[ECOGTCSubGroups objectAtIndex:0] objectForKey:@"description"];//description;
                     self.progScoresViewController.scaleName = @"ECOGTC";
                     self.progScoresViewController.subGroupId = [[[ECOGTCSubGroups objectAtIndex:0] objectForKey:@"SubGroupId"] intValue];
                     self.progScoresViewController.detailTitle = [[[ECOGTCSubGroups objectAtIndex:0] objectForKey:@"description"] stringByAppendingString:@" Grade"];
                     [[self navigationController] pushViewController:self.progScoresViewController animated:YES];
                     [self.progScoresViewController release];
                 }
                 else
                 {
                     // Display Sub Groups
                     ECOGTCSubGroupsViewController *ecogtcVC = [[ECOGTCSubGroupsViewController alloc] init];
                     ecogtcVC.title = description;
                     ecogtcVC.ECOGTCSubGroups = ECOGTCSubGroups;
                     [[self navigationController] pushViewController:ecogtcVC animated:YES];
                     //[ecogtcVC release];
                 }                 
             }
             break;
         }
     }
     [description release];
     [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [appDelegate displayDisclaimer];
    
	[super viewDidAppear:animated];

//    if ([appDelegate displayDisclaimer]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disclaimer"
//														message:@"this is a disclaimer information!"
//													   delegate:nil
//											  cancelButtonTitle:@"OK"
//											  otherButtonTitles: nil];
//		[alert show];
//		[alert release];
//    }
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (void)viewDidDisappear:(BOOL)animated {
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[listContent release];
	[myTableView release];
	[regimenVC release];
    //[imageDown release];
    //[imageUp release];
	[super dealloc];
}


@end

