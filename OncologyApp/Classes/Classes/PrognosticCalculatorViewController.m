//
//  PrognosticCalculatorViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 1/16/13.
//
//

#import "PrognosticCalculatorViewController.h"
#import "QuartzCore/QuartzCore.h"

@interface PrognosticCalculatorViewController ()
- (void) setBorderLabel:(UILabel *)label;
- (void) configureView;
- (void) computeResult;
- (void) loadIPI;
- (void) computeIPI;
- (void) loadAIPI;
- (void) computeAIPI;
- (void) loadFLIPI;
- (void) computeFLIPI;
- (void) loadIPSS;
- (void) computeIPSS;
- (void) loadrenalCell;
- (void) computerenalCell;
@end

NSMutableDictionary *ipiDict;
NSMutableDictionary *aipiDict;
NSMutableDictionary *flipiDict;
NSMutableDictionary *ipssDict;
NSMutableDictionary *renalCellDict;

@implementation PrognosticCalculatorViewController

- (void) setBorderLabel:(UILabel *)label
{
    label.layer.borderColor = [UIColor brownColor].CGColor;
    label.layer.borderWidth = 1.0;
    label.layer.cornerRadius = 6.0;
}

- (void) configureView
{
    if (self.mynibName == @"PrognosticIndexViewController")
    {
        [self loadIPI];
    }
    else if (self.mynibName == @"AgeAdjPrognosticIndexViewController")
    {
        [self loadAIPI];
    }
    else if (self.mynibName == @"PrognosticFLIPIViewController")
    {
        [self loadFLIPI];
    }
    else if (self.mynibName == @"PrognosticIPSSViewController")
    {
        [self loadIPSS];
    }
    else if (self.mynibName == @"PrognosticRenalCellViewController")
    {
        [self loadrenalCell];
    }
    
    
}

- (void)dealloc {
	[ipiDict release];
    [aipiDict release];
    [flipiDict release];
	[super dealloc];
}

- (void) loadIPI
{
    
    ipiDict = [[NSMutableDictionary alloc] init];
    [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"0", @"score",
                              @"Very Good", @"riskgroup",
                              @"94%", @"fouryrpfs",
                              @"94%", @"fouryros",
                              nil] forKey:@"0"];
    [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"1", @"score",
                        @"Good", @"riskgroup",
                        @"80%", @"fouryrpfs",
                        @"79%", @"fouryros",
                        nil] forKey:@"1"];
    [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"2", @"score",
                        @"Good", @"riskgroup",
                        @"80%", @"fouryrpfs",
                        @"79%", @"fouryros",
                        nil] forKey:@"2"];
    [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"3", @"score",
                        @"Poor", @"riskgroup",
                        @"53%", @"fouryrpfs",
                        @"55%", @"fouryros",
                        nil] forKey:@"3"];
    [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"4", @"score",
                        @"Poor", @"riskgroup",
                        @"53%", @"fouryrpfs",
                        @"55%", @"fouryros",
                        nil] forKey:@"4"];
    [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"5", @"score",
                        @"Poor", @"riskgroup",
                        @"53%", @"fouryrpfs",
                        @"55%", @"fouryros",
                        nil] forKey:@"5"];

//    [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
//                        @"0", @"score",
//                        @"Low Risk", @"riskgroup",
//                        @"73%", @"fiveyrs",
//                        @"87%", @"crrate",
//                        nil] forKey:@"0"];
//    
//    [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
//                        @"1", @"score",
//                        @"Low Risk", @"riskgroup",
//                        @"73%", @"fiveyrs",
//                        @"87%", @"crrate",
//                        nil] forKey:@"1"];
//    [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
//                        @"2", @"score",
//                        @"Low-intermediate Risk", @"riskgroup",
//                        @"51%", @"fiveyrs",
//                        @"67%", @"crrate",
//                        nil] forKey:@"2"];
//    [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
//                        @"3", @"score",
//                        @"High-intermediate Risk", @"riskgroup",
//                        @"43%", @"fiveyrs",
//                        @"55%", @"crrate",
//                        nil] forKey:@"3"];
//    [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
//                        @"4", @"score",
//                        @"High Risk", @"riskgroup",
//                        @"26%", @"fiveyrs",
//                        @"44%", @"crrate",
//                        nil] forKey:@"4"];
//    [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
//                        @"5", @"score",
//                        @"High Risk", @"riskgroup",
//                        @"26%", @"fiveyrs",
//                        @"44%", @"crrate",
//                        nil] forKey:@"5"];

    self.age.selectedSegmentIndex = 0;
    [self setBorderLabel:self.ageLabel];
    self.perf.selectedSegmentIndex = 1;
    [self setBorderLabel:self.perfLabel];
    self.ldh.selectedSegmentIndex = 1;
    [self setBorderLabel:self.ldhLabel];
    self.extranodal.selectedSegmentIndex = 1;
    [self setBorderLabel:self.extranodalLabel];
    self.stage.selectedSegmentIndex = 1;
    [self setBorderLabel:self.stageLabel];
}

- (void) computeIPI
{
    int score = 0;
    
    if (self.age.selectedSegmentIndex == 1)
        score++;
    if (self.perf.selectedSegmentIndex == 0)
        score++;
    if (self.ldh.selectedSegmentIndex == 0)
        score++;
    if (self.extranodal.selectedSegmentIndex == 0)
        score++;
    if (self.stage.selectedSegmentIndex == 0)
        score++;
    
    NSDictionary *dict = [ipiDict valueForKey:[NSString stringWithFormat:@"%d", score]];
    
    self.detailViewController = [[GenericGroupedTableViewController alloc] init];
    self.detailViewController.keys = [NSMutableArray arrayWithObjects:@"score", @"riskgroup", @"fouryrpfs", @"fouryros", nil];
    self.detailViewController.dict = dict;
    self.detailViewController.title = @"International Progostic Index";
    
}

- (void) loadAIPI
{
    
    aipiDict = [[NSMutableDictionary alloc] init];
    [aipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"0", @"score",
                        @"Low Risk", @"riskgroup",
                        @"56%", @"fiveyrs",
                        @"91%", @"crrate",
                        nil] forKey:@"0"];
    
    [aipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"1", @"score",
                        @"Low-intermediate Risk", @"riskgroup",
                        @"44%", @"fiveyrs",
                        @"71%", @"crrate",
                        nil] forKey:@"1"];
    [aipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"2", @"score",
                        @"High-intermediate Risk", @"riskgroup",
                        @"37%", @"fiveyrs",
                        @"56%", @"crrate",
                        nil] forKey:@"2"];
    [aipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"3", @"score",
                        @"High Risk", @"riskgroup",
                        @"21%", @"fiveyrs",
                        @"36%", @"crrate",
                        nil] forKey:@"3"];
    [aipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"4", @"score",
                        @"High Risk", @"riskgroup",
                        @"21%", @"fiveyrs",
                        @"36%", @"crrate",
                        nil] forKey:@"4"];
    
    self.perf.selectedSegmentIndex = 1;
    [self setBorderLabel:self.perfLabel];
    self.ldh.selectedSegmentIndex = 1;
    [self setBorderLabel:self.ldhLabel];
    self.extranodal.selectedSegmentIndex = 1;
    [self setBorderLabel:self.extranodalLabel];
    self.stage.selectedSegmentIndex = 1;
    [self setBorderLabel:self.stageLabel];
}

- (void) computeAIPI
{
    int score = 0;
    
    if (self.perf.selectedSegmentIndex == 0)
        score++;
    if (self.ldh.selectedSegmentIndex == 0)
        score++;
    if (self.extranodal.selectedSegmentIndex == 0)
        score++;
    if (self.stage.selectedSegmentIndex == 0)
        score++;
    
    NSDictionary *dict = [aipiDict valueForKey:[NSString stringWithFormat:@"%d", score]];
    
    self.detailViewController = [[GenericGroupedTableViewController alloc] init];
    self.detailViewController.keys = [NSMutableArray arrayWithObjects:@"score", @"riskgroup", @"fiveyrs", @"crrate", nil];
    self.detailViewController.dict = dict;
    self.detailViewController.title = @"Age Adj. International Progostic Index";
    
}

- (void) loadFLIPI
{
    
    flipiDict = [[NSMutableDictionary alloc] init];
    [flipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"0", @"score",
                        @"Low Risk", @"riskgroup",
                        @"91%", @"fiveyrs",
                        @"71%", @"tenyrs",
                        nil] forKey:@"0"];
    
    [flipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"1", @"score",
                        @"Low Risk", @"riskgroup",
                        @"91%", @"fiveyrs",
                        @"71%", @"tenyrs",
                        nil] forKey:@"1"];
    [flipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"2", @"score",
                        @"Intermediate Risk", @"riskgroup",
                        @"78%", @"fiveyrs",
                        @"51%", @"tenyrs",
                        nil] forKey:@"2"];
    [flipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"3", @"score",
                        @"High Risk", @"riskgroup",
                        @"52%", @"fiveyrs",
                        @"36%", @"tenyrs",
                        nil] forKey:@"3"];
    [flipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"4", @"score",
                          @"High Risk", @"riskgroup",
                          @"52%", @"fiveyrs",
                          @"36%", @"tenyrs",
                          nil] forKey:@"4"];
    [flipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"5", @"score",
                          @"High Risk", @"riskgroup",
                          @"52%", @"fiveyrs",
                          @"36%", @"tenyrs",
                          nil] forKey:@"5"];
    
    self.age.selectedSegmentIndex = 0;
    [self setBorderLabel:self.ageLabel];
    self.ldh.selectedSegmentIndex = 1;
    [self setBorderLabel:self.ldhLabel];
    self.hemoglobin.selectedSegmentIndex = 1;
    [self setBorderLabel:self.hemoglobinLabel];
    self.extranodal.selectedSegmentIndex = 1;
    [self setBorderLabel:self.extranodalLabel];
    self.stage.selectedSegmentIndex = 1;
    [self setBorderLabel:self.stageLabel];
}

- (void) computeFLIPI
{
    int score = 0;
    
    if (self.age.selectedSegmentIndex == 1)
        score++;
    if (self.hemoglobin.selectedSegmentIndex == 0)
        score++;
    if (self.ldh.selectedSegmentIndex == 0)
        score++;
    if (self.extranodal.selectedSegmentIndex == 0)
        score++;
    if (self.stage.selectedSegmentIndex == 0)
        score++;
    
    NSDictionary *dict = [flipiDict valueForKey:[NSString stringWithFormat:@"%d", score]];
    
    self.detailViewController = [[GenericGroupedTableViewController alloc] init];
    self.detailViewController.keys = [NSMutableArray arrayWithObjects:@"score", @"riskgroup", @"fiveyrs", @"tenyrs", nil];
    self.detailViewController.dict = dict;
    self.detailViewController.title = @"FLIPI";
    
}

- (void) loadIPSS
{
    
    ipssDict = [[NSMutableDictionary alloc] init];
    [ipssDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"0", @"score",
                        @"Low Risk", @"riskgroup",
                        @"5.7 years", @"survival",
                        nil] forKey:@"00"];
    
    [ipssDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"0.5", @"score",
                          @"Intermediate-1 Risk", @"riskgroup",
                          @"3.5 years", @"survival",
                          nil] forKey:@"05"];
    [ipssDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"1.0", @"score",
                          @"Intermediate-1 Risk", @"riskgroup",
                          @"3.5 years", @"survival",
                          nil] forKey:@"10"];
    [ipssDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"1.5", @"score",
                          @"Intermediate-2 Risk", @"riskgroup",
                          @"1.2 years", @"survival",
                          nil] forKey:@"15"];
    [ipssDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"2.0", @"score",
                          @"Intermediate-2 Risk", @"riskgroup",
                          @"1.2 years", @"survival",
                          nil] forKey:@"20"];
    [ipssDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"2.5", @"score",
                          @"High Risk", @"riskgroup",
                          @"0.4 years", @"survival",
                          nil] forKey:@"25"];
    [ipssDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"3.0", @"score",
                          @"High Risk", @"riskgroup",
                          @"0.4 years", @"survival",
                          nil] forKey:@"30"];
    [ipssDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"3.5", @"score",
                          @"High Risk", @"riskgroup",
                          @"0.4 years", @"survival",
                          nil] forKey:@"35"];
    
    self.bonemarrow.selectedSegmentIndex = 0;
    self.karyotype.selectedSegmentIndex = 0;
    self.cytopenias.selectedSegmentIndex = 0;
}

- (void) computeIPSS
{
    float score = 0.0;
    
    if (self.bonemarrow.selectedSegmentIndex == 1)
        score = score + 0.5;
    else if (self.bonemarrow.selectedSegmentIndex == 2)
        score = score + 1.5;
    else if (self.bonemarrow.selectedSegmentIndex == 3)
        score = score + 2.0;

    if (self.karyotype.selectedSegmentIndex == 1)
        score = score + 0.5;
    else if (self.bonemarrow.selectedSegmentIndex == 2)
        score = score + 1.0;
    
    if ((self.cytopenias.selectedSegmentIndex == 2) || (self.cytopenias.selectedSegmentIndex == 3))
        score = score + 0.5;

    NSDictionary *dict = [ipssDict valueForKey:[[NSString stringWithFormat:@"%01.1f", score] stringByReplacingOccurrencesOfString:@"." withString:@""]];
    
    self.detailViewController = [[GenericGroupedTableViewController alloc] init];
    self.detailViewController.keys = [NSMutableArray arrayWithObjects:@"score", @"riskgroup", @"survival", nil];
    self.detailViewController.dict = dict;
    self.detailViewController.title = @"IPSS";
    
}

- (void) loadrenalCell
{
    
    renalCellDict = [[NSMutableDictionary alloc] init];
    [renalCellDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         @"0", @"score",
                         @"72%", @"oneyrsurvival",
                         nil] forKey:@"0"];
    [renalCellDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"1", @"score",
                              @"42%", @"oneyrsurvival",
                              nil] forKey:@"1"];
    [renalCellDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"2", @"score",
                              @"42%", @"oneyrsurvival",
                              nil] forKey:@"2"];
    [renalCellDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"3", @"score",
                              @"17%", @"oneyrsurvival",
                              nil] forKey:@"3"];
    [renalCellDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"4", @"score",
                              @"17%", @"oneyrsurvival",
                              nil] forKey:@"4"];
    [renalCellDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"5", @"score",
                              @"17%", @"oneyrsurvival",
                              nil] forKey:@"5"];
    
    self.kps.selectedSegmentIndex = 0;
    [self setBorderLabel:self.kpsLabel];
    self.serum.selectedSegmentIndex = 1;
    [self setBorderLabel:self.serumLabel];
    self.ldh.selectedSegmentIndex = 1;
    [self setBorderLabel:self.ldhLabel];
    self.hemoglobin.selectedSegmentIndex = 1;
    [self setBorderLabel:self.hemoglobinLabel];
    self.nephrectomy.selectedSegmentIndex = 1;
    [self setBorderLabel:self.nephrectomyLabel];
}

- (void) computerenalCell
{
    int score = 0;
    
    if (self.kps.selectedSegmentIndex == 1)
        score++;
    if (self.ldh.selectedSegmentIndex == 0)
        score++;
    if (self.serum.selectedSegmentIndex == 0)
        score++;
    if (self.hemoglobin.selectedSegmentIndex == 0)
        score++;
    if (self.nephrectomy.selectedSegmentIndex == 0)
        score++;
    
    NSDictionary *dict = [renalCellDict valueForKey:[NSString stringWithFormat:@"%d", score]];
    
    self.detailViewController = [[GenericGroupedTableViewController alloc] init];
    self.detailViewController.keys = [NSMutableArray arrayWithObjects:@"score", @"oneyrsurvival", nil];
    self.detailViewController.dict = dict;
    self.detailViewController.title = @"Advanced Renal Cell Carcinoma Prognosis";
    
}



- (void) computeResult
{
    if (self.mynibName == @"PrognosticIndexViewController")
    {
        [self computeIPI];
    }
    else if (self.mynibName == @"AgeAdjPrognosticIndexViewController")
    {
        [self computeAIPI];
    }
    else if (self.mynibName == @"PrognosticFLIPIViewController")
    {
        [self computeFLIPI];
    }
    else if (self.mynibName == @"PrognosticIPSSViewController")
    {
        [self computeIPSS];
    }
    else if (self.mynibName == @"PrognosticRenalCellViewController")
    {
        [self computerenalCell];
    }
    
    [[self navigationController] pushViewController:self.detailViewController animated:YES];
	//[[self navigationController] presentViewController:self.detailViewController animated:YES completion:nil];
}

- (IBAction)compute:(id)sender
{
    [self computeResult];
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:self.mynibName bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
