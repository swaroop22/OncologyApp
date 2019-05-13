//
//  RootViewController.h
//  OncologyApp
//
//  Created by Satheesh Kathula on 10/14/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegimenVC.h"
#import "MainViewController.h"
#import "Classes/CancerListViewController.h"
#import "Classes/StagingListViewController.h"
#import "Classes/LymphomaListViewController.h"
#import "Classes/MyelomaViewController.h"
#import "Classes/PrognosticCalculatorViewController.h"
#import "Classes/PrognosticScoresViewController.h"
#import "Classes/PrognosticCalculatorRevisedViewController.h"
#import "Classes/ECOGTCSubGroupsViewController.h"
#import "Gen2BrandViewController.h"

#import "AbsNeutrophilCountViewController.h"
#import "Classes/BSACalculatorViewController.h"
#import "BMIViewController.h"
#import "CcrCalculatorViewController.h"
#import "CPCalculatorViewController.h"
#import "TemperatureViewController.h"

@interface RootViewController : UIViewController //<UITableViewDelegate>
{
	NSArray							*listContent;
	IBOutlet UITableView	*myTableView;
	//IBOutlet RegimenVC		*regimenVC;
    //IBOutlet CancerListViewController *cancerListViewController;
	//IBOutlet MainViewController *calculatorVC;
    
    NSMutableArray *regimenDict;
    NSMutableArray *stagingDict;
    NSMutableArray *calculatorDict;
    NSMutableArray *progCalculatorDict;
    NSMutableArray *responseCriteriaDict;
    NSMutableArray *sectionsToggle;
    NSMutableArray *gen2BrandDict;
    
}

@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, retain) RegimenVC *regimenVC;
@property (nonatomic, retain) UITableView *myTableView;
@property (strong, nonatomic) CancerListViewController *cancerListViewController;
@property (strong, nonatomic) StagingListViewController *stagingListViewController;
@property (strong, nonatomic) LymphomaListViewController *lymphomaListViewController;
@property (strong, nonatomic) MyelomaViewController *myelomaViewController;


@property (strong, nonatomic) AbsNeutrophilCountViewController *absViewController;
@property (strong, nonatomic) BSACalculatorViewController *bsaViewController;
@property (strong, nonatomic) BMIViewController *bmiViewController;
@property (strong, nonatomic) CcrCalculatorViewController *ccrViewController;
@property (strong, nonatomic) TemperatureViewController *tempViewController;
@property (strong, nonatomic) PrognosticCalculatorViewController *progViewController;
@property (strong, nonatomic) PrognosticCalculatorRevisedViewController *progRevViewController;
@property (strong, nonatomic) PrognosticScoresViewController *progScoresViewController;
@property (strong, nonatomic) CPCalculatorViewController *cpCalcViewController;
@property (strong, nonatomic) Gen2BrandViewController *gen2brandVC;


@end
