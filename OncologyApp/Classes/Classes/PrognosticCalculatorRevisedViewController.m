//
//  PrognosticCalculatorRevisedViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 1/26/13.
//
//

#import "PrognosticCalculatorRevisedViewController.h"

@interface PrognosticCalculatorRevisedViewController ()
- (void) configureView;
- (void) loadIPI;
- (void) loadRCC;
- (void) loadFLIPI;
- (void) loadIPSS;
- (void) loadIPSS_R;
- (void) loadIPSS_WHO;
- (void) computeIPI;
- (void) computeRCC;
- (void) computeFLIPI;
- (void) computeIPSS;
- (void) computeIPSS_R;
- (void) computeIPSS_WHO;
- (void) computeResult;
@end

NSMutableDictionary *ipiDict;
NSMutableDictionary *rccDict;
NSMutableDictionary *flipiDict;
NSMutableDictionary *ipssDict;
NSMutableDictionary *ipssRDict;
NSMutableDictionary *whoDict;
NSMutableDictionary *sectionsDict;
UIView *footerView = nil;
//UITableViewHeaderFooterView *footerView = nil;
//NSMutableArray *options;


@implementation PrognosticCalculatorRevisedViewController

@synthesize tv;

-(void) loadIPI
{
    int section = 0;
    NSMutableArray *sectionOptions = [[NSMutableArray alloc] init];
    sectionsDict = [[NSMutableDictionary alloc] init];
    if ([self.type isEqual: @"IPI"])
    {
        [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"0", @"selected",
                                   @"0", @"points",
                                   @"<= 60", @"option", nil]];
        [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"0", @"selected",
                                   @"1", @"points",
                                   @"> 60", @"option", nil]];
        
        [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 [NSString stringWithFormat:@"%d", section],
                                 @"section",
                                 @"Age", @"title",
                                 sectionOptions, @"options",
                                 nil] forKey:[NSString stringWithFormat:@"%d", section]];
        section++;
        [sectionOptions release];

        sectionOptions = [[NSMutableArray alloc] init];
    }
    
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"Yes", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"No", @"option", nil]];
    
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             [NSString stringWithFormat:@"%d", section],
                             @"section",
                             @"Performance Status (ECOG) >= 2", @"title",
                             sectionOptions, @"options",
                             nil] forKey:[NSString stringWithFormat:@"%d", section]];
    section++;
    [sectionOptions release];
    
    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"Yes", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"No", @"option", nil]];
    
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             [NSString stringWithFormat:@"%d", section],
                             @"section",
                             @"LDH Above Normal", @"title",
                             sectionOptions, @"options",
                             nil] forKey:[NSString stringWithFormat:@"%d", section]];
    section++;
    [sectionOptions release];

    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"Yes", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"No", @"option", nil]];
    
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             [NSString stringWithFormat:@"%d", section],
                             @"section",
                             @"Extranodal Sites > 1", @"title",
                             sectionOptions, @"options",
                             nil] forKey:[NSString stringWithFormat:@"%d", section]];
    section++;
    [sectionOptions release];

    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"Yes", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"No", @"option", nil]];
    
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             [NSString stringWithFormat:@"%d", section],
                             @"section",
                             @"Stage III or IV", @"title",
                             sectionOptions, @"options",
                             nil] forKey:[NSString stringWithFormat:@"%d", section]];
    section++;
    [sectionOptions release];
    
    ipiDict = [[NSMutableDictionary alloc] init];
    if ([self.type isEqual: @"IPI"])
    {
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
    }
    else
    {
        [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            @"0", @"score",
                            @"Low Risk", @"riskgroup",
                            @"56%", @"fiveyrs",
                            @"91%", @"crrate",
                            nil] forKey:@"0"];
        [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            @"1", @"score",
                            @"Low-intermediate Risk", @"riskgroup",
                            @"44%", @"fiveyrs",
                            @"71%", @"crrate",
                            nil] forKey:@"1"];
        [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            @"2", @"score",
                            @"High-intermediate Risk", @"riskgroup",
                            @"37%", @"fiveyrs",
                            @"56%", @"crrate",
                            nil] forKey:@"2"];
        [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            @"3", @"score",
                            @"High Risk", @"riskgroup",
                            @"21%", @"fiveyrs",
                            @"36%", @"crrate",
                            nil] forKey:@"3"];
        [ipiDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            @"4", @"score",
                            @"High Risk", @"riskgroup",
                            @"21%", @"fiveyrs",
                            @"36%", @"crrate",
                            nil] forKey:@"4"];
        
    }
}


- (void) computeIPI
{
    int score = 0;
    
    for (int i=0; i<[sectionsDict count]; i++) {
        NSDictionary *sd = [sectionsDict objectForKey:[NSString stringWithFormat:@"%d", i]];
        NSMutableArray *options = [sd objectForKey:@"options"];
        
        for (int j=0; j<[options count]; j++) {
            NSMutableDictionary *d = [options objectAtIndex:j];
            if ([[d objectForKey:@"selected"] isEqual: @"1"]) {
                score += [[d objectForKey:@"points"] intValue];
            }
        }
        
    }
    
    
    NSDictionary *dict = [ipiDict valueForKey:[[NSString stringWithFormat:@"%d", score] stringByReplacingOccurrencesOfString:@"." withString:@""]];
    
    self.detailViewController = [[[GenericGroupedTableViewController alloc] init] autorelease];
    if ([self.type isEqual: @"IPI"])
    {
        self.detailViewController.keys = [NSMutableArray arrayWithObjects:@"score", @"riskgroup", @"fouryrpfs", @"fouryros", nil];
    }
    else
    {
        self.detailViewController.keys = [NSMutableArray arrayWithObjects:@"score", @"riskgroup", @"fiveyrs", @"crrate", nil];
        
    }
    self.detailViewController.dict = dict;
    self.detailViewController.title = self.title;
    
}

-(void) loadRCC
{
    int section = 0;
    NSMutableArray *sectionOptions = [[NSMutableArray alloc] init];
    sectionsDict = [[NSMutableDictionary alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"< 80%", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @">= 80%", @"option", nil]];
    
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             [NSString stringWithFormat:@"%d", section],
                             @"section",
                             @"KPS", @"title",
                             sectionOptions, @"options",
                             nil] forKey:[NSString stringWithFormat:@"%d", section]];
    section++;
    [sectionOptions release];
    
    sectionOptions = [[NSMutableArray alloc] init];
    
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"Yes", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"No", @"option", nil]];
    
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             [NSString stringWithFormat:@"%d", section],
                             @"section",
                             @"LDH Level > 1.5 times the Upper Limit", @"title",
                             sectionOptions, @"options",
                             nil] forKey:[NSString stringWithFormat:@"%d", section]];
    section++;
    [sectionOptions release];
    
    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"Yes", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"No", @"option", nil]];
    
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             [NSString stringWithFormat:@"%d", section],
                             @"section",
                             @"Corrected Serum Calcium > 10 mg/dL", @"title",
                             sectionOptions, @"options",
                             nil] forKey:[NSString stringWithFormat:@"%d", section]];
    section++;
    [sectionOptions release];
    
    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"Yes", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"No", @"option", nil]];
    
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             [NSString stringWithFormat:@"%d", section],
                             @"section",
                             @"Hemoglobin < Lower Limit", @"title",
                             sectionOptions, @"options",
                             nil] forKey:[NSString stringWithFormat:@"%d", section]];
    section++;
    [sectionOptions release];
    
    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"Yes", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"No", @"option", nil]];
    
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             [NSString stringWithFormat:@"%d", section],
                             @"section",
                             @"Absence of Nephrectomy", @"title",
                             sectionOptions, @"options",
                             nil] forKey:[NSString stringWithFormat:@"%d", section]];
    section++;
    [sectionOptions release];
    
    rccDict = [[NSMutableDictionary alloc] init];
    [rccDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"0", @"score",
                        @"72%", @"oneyrsurvival",
                        nil] forKey:@"0"];
    [rccDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"1", @"score",
                        @"42%", @"oneyrsurvival",
                        nil] forKey:@"1"];
    [rccDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"2", @"score",
                        @"42%", @"oneyrsurvival",
                        nil] forKey:@"2"];
    [rccDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"3", @"score",
                        @"17%", @"oneyrsurvival",
                        nil] forKey:@"3"];
    [rccDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"4", @"score",
                        @"17%", @"oneyrsurvival",
                        nil] forKey:@"4"];
    [rccDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"5", @"score",
                        @"17%", @"oneyrsurvival",
                        nil] forKey:@"5"];
}

- (void) computeRCC
{
    int score = 0;
    
    for (int i=0; i<[sectionsDict count]; i++) {
        NSDictionary *sd = [sectionsDict objectForKey:[NSString stringWithFormat:@"%d", i]];
        NSMutableArray *options = [sd objectForKey:@"options"];
        
        for (int j=0; j<[options count]; j++) {
            NSMutableDictionary *d = [options objectAtIndex:j];
            if ([[d objectForKey:@"selected"] isEqual: @"1"]) {
                score += [[d objectForKey:@"points"] intValue];
            }
        }
        
    }
    
    
    NSDictionary *dict = [rccDict valueForKey:[[NSString stringWithFormat:@"%d", score] stringByReplacingOccurrencesOfString:@"." withString:@""]];
    
    self.detailViewController = [[[GenericGroupedTableViewController alloc] init] autorelease];
    self.detailViewController.keys = [NSMutableArray arrayWithObjects:@"score",  @"oneyrsurvival",  nil];
    self.detailViewController.dict = dict;
    self.detailViewController.title = self.title;
    
}
-(void) loadFLIPI
{
    NSMutableArray *sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"> 60", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"<= 60", @"option", nil]];
    
    sectionsDict = [[NSMutableDictionary alloc] init];
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             @"0", @"section",
                             @"Age", @"title",
                             sectionOptions, @"options",
                             nil] forKey:@"0"];
    [sectionOptions release];
    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"Yes", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"No", @"option", nil]];
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             @"1", @"section",
                             @"Serum LDH Above Normal", @"title",
                             sectionOptions, @"options",
                             nil] forKey:@"1"];
    
    [sectionOptions release];
    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"Yes", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"No", @"option", nil]];
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             @"2", @"section",
                             @"Hemoglobin Level < 12.0 g/dL", @"title",
                             sectionOptions, @"options",
                             nil] forKey:@"2"];
    [sectionOptions release];
    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"Yes", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"No", @"option", nil]];
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             @"3", @"section",
                             @"Ann Arbor Stage III or IV", @"title",
                             sectionOptions, @"options",
                             nil] forKey:@"3"];
    [sectionOptions release];
    
    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"Yes", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"No", @"option", nil]];
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             @"4", @"section",
                             @"Nodal Areas Involved > 4", @"title",
                             sectionOptions, @"options",
                             nil] forKey:@"4"];
    [sectionOptions release];

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
}

- (void) computeFLIPI
{
    int score = 0;
    
    for (int i=0; i<[sectionsDict count]; i++) {
        NSDictionary *sd = [sectionsDict objectForKey:[NSString stringWithFormat:@"%d", i]];
        NSMutableArray *options = [sd objectForKey:@"options"];
        
        for (int j=0; j<[options count]; j++) {
            NSMutableDictionary *d = [options objectAtIndex:j];
            if ([[d objectForKey:@"selected"] isEqual: @"1"]) {
                score += [[d objectForKey:@"points"] intValue];
            }
        }
    }
    
    NSDictionary *dict = [flipiDict valueForKey:[[NSString stringWithFormat:@"%d", score] stringByReplacingOccurrencesOfString:@"." withString:@""]];
    
    self.detailViewController = [[[GenericGroupedTableViewController alloc] init] autorelease];
    self.detailViewController.keys = [NSMutableArray arrayWithObjects:@"score", @"riskgroup", @"fiveyrs", @"tenyrs", nil];
    self.detailViewController.dict = dict;
    self.detailViewController.title = self.title;
    
}


-(void) loadIPSS
{
    NSMutableArray *sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                            @"0", @"selected",
                            @"0", @"points",
                            @"< 5", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0.5", @"points",
                               @"5-10", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1.5", @"points",
                               @"11-20", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"2.0", @"points",
                               @"21-30", @"option", nil]];
    
    sectionsDict = [[NSMutableDictionary alloc] init];
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                         @"0", @"section",
                         @"Bone Marrow Blast (%)", @"title",
                         sectionOptions, @"options",
                         nil] forKey:@"0"];
    [sectionOptions release];
    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"Good", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0.5", @"points",
                               @"Intermediate", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1.0", @"points",
                               @"Poor", @"option", nil]];    
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             @"1", @"section",
                             @"Karyotype", @"title",
                             sectionOptions, @"options",
                             nil] forKey:@"1"];

    [sectionOptions release];
    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"0", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"1", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0.5", @"points",
                               @"2", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0.5", @"points",
                               @"3", @"option", nil]];
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             @"2", @"section",
                             @"Cytopenias", @"title",
                             sectionOptions, @"options",
                             nil] forKey:@"2"];
    
    [sectionOptions release];
    
    ipssDict = [[NSMutableDictionary alloc] init];
    [ipssDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         @"0", @"score",
                         @"Low", @"riskgroup",
                         @"5.7 years", @"survival",
                         nil] forKey:@"00"];
    [ipssDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         @"0.5", @"score",
                         @"Intermediate-1", @"riskgroup",
                         @"3.5 years", @"survival",
                         nil] forKey:@"05"];
    [ipssDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         @"1.0", @"score",
                         @"Intermediate-1", @"riskgroup",
                         @"3.5 years", @"survival",
                         nil] forKey:@"10"];
    [ipssDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         @"1.5", @"score",
                         @"Intermediate-2", @"riskgroup",
                         @"1.2 years", @"survival",
                         nil] forKey:@"15"];
    [ipssDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         @"2.0", @"score",
                         @"Intermediate-2", @"riskgroup",
                         @"1.2 years", @"survival",
                         nil] forKey:@"20"];
    [ipssDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         @"2.5", @"score",
                         @"High", @"riskgroup",
                         @"0.4 years", @"survival",
                         nil] forKey:@"25"];
    [ipssDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         @"3.0", @"score",
                         @"High", @"riskgroup",
                         @"0.4 years", @"survival",
                         nil] forKey:@"30"];
    [ipssDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         @"3.5", @"score",
                         @"High", @"riskgroup",
                         @"0.4 years", @"survival",
                         nil] forKey:@"35"];
}

- (void) computeIPSS
{
    float score = 0.0;
    
    for (int i=0; i<[sectionsDict count]; i++) {
        NSDictionary *sd = [sectionsDict objectForKey:[NSString stringWithFormat:@"%d", i]];
        NSMutableArray *options = [sd objectForKey:@"options"];
        
        for (int j=0; j<[options count]; j++) {
            NSMutableDictionary *d = [options objectAtIndex:j];
            if ([[d objectForKey:@"selected"] isEqual: @"1"]) {
                score += [[d objectForKey:@"points"] floatValue];
            }
        }
        
    }
    
    
    NSDictionary *dict = [ipssDict valueForKey:[[NSString stringWithFormat:@"%01.1f", score] stringByReplacingOccurrencesOfString:@"." withString:@""]];
    
    self.detailViewController = [[[GenericGroupedTableViewController alloc] init] autorelease];
    self.detailViewController.keys = [NSMutableArray arrayWithObjects:@"score", @"riskgroup", @"survival", nil];
    self.detailViewController.dict = dict;
    self.detailViewController.title = self.title;
    
}

-(void) loadIPSS_R
{
    NSMutableArray *sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"<= 2", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"<2 to <5", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"2", @"points",
                               @"5 to 10", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"3", @"points",
                               @"> 10", @"option", nil]];
    
    sectionsDict = [[NSMutableDictionary alloc] init];
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             @"0", @"section",
                             @"Bone Marrow Blast (%)", @"title",
                             sectionOptions, @"options",
                             nil] forKey:@"0"];
    [sectionOptions release];
    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"Very Good", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"Good", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"2", @"points",
                               @"Intermediate", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"3", @"points",
                               @"Poor", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"4", @"points",
                               @"Very Poor", @"option", nil]];
    
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             @"1", @"section",
                             @"Karyotype", @"title",
                             sectionOptions, @"options",
                             nil] forKey:@"1"];
    
    [sectionOptions release];
    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @">= 10", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"8 to < 10", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1.5", @"points",
                               @"< 8", @"option", nil]];
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             @"0", @"selected",
                             @"2", @"section",
                             @"Hemoglobin (g/dL)", @"title",
                             sectionOptions, @"options",
                             nil] forKey:@"2"];
    
    [sectionOptions release];
    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @">= 100,000", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"< 50,000", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0.5", @"points",
                               @"50,000 to 100,000", @"option", nil]];
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             @"3", @"section",
                             @"Platelets (cells/microL) ", @"title",
                             sectionOptions, @"options",
                             nil] forKey:@"3"];
    
    [sectionOptions release];
    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @">= 800", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0.5", @"points",
                               @"< 800", @"option", nil]];
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             @"0", @"selected",
                             @"4", @"section",
                             @"Absolute neutrophil count (cells/microL) ", @"title",
                             sectionOptions, @"options",
                             nil] forKey:@"4"];
    
    [sectionOptions release];
    
    ipssRDict = [[NSMutableDictionary alloc] init];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"0", @"score",
                          @"Very Low Risk", @"riskgroup",
                          @"8.8 years", @"mediansurvival",
                          @"> 14.5 years", @"amlsurvival",
                          nil] forKey:@"00"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"0.5", @"score",
                          @"Very Low Risk", @"riskgroup",
                          @"8.8 years", @"mediansurvival",
                          @"> 14.5 years", @"amlsurvival",
                          nil] forKey:@"05"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"1.0", @"score",
                          @"Very Low Risk", @"riskgroup",
                          @"8.8 years", @"mediansurvival",
                          @"> 14.5 years", @"amlsurvival",
                          nil] forKey:@"10"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"1.5", @"score",
                          @"Low Risk", @"riskgroup",
                          @"5.3 years", @"mediansurvival",
                          @"10.8 years", @"amlsurvival",
                          nil] forKey:@"15"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"2.0", @"score",
                          @"Low Risk", @"riskgroup",
                          @"5.3 years", @"mediansurvival",
                          @"10.8 years", @"amlsurvival",
                          nil] forKey:@"20"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"2.5", @"score",
                          @"Low Risk", @"riskgroup",
                          @"5.3 years", @"mediansurvival",
                          @"10.8 years", @"amlsurvival",
                          nil] forKey:@"25"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"3.0", @"score",
                          @"Low Risk", @"riskgroup",
                          @"5.3 years", @"mediansurvival",
                          @"10.8 years", @"amlsurvival",
                          nil] forKey:@"30"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"3.5", @"score",
                          @"Intermediate Risk", @"riskgroup",
                          @"3.0 years", @"mediansurvival",
                          @"3.2 years", @"amlsurvival",
                          nil] forKey:@"35"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"4.0", @"score",
                          @"Intermediate Risk", @"riskgroup",
                          @"3.0 years", @"mediansurvival",
                          @"3.2 years", @"amlsurvival",
                          nil] forKey:@"40"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"4.5", @"score",
                          @"Intermediate Risk", @"riskgroup",
                          @"3.0 years", @"mediansurvival",
                          @"3.2 years", @"amlsurvival",
                          nil] forKey:@"45"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"5.0", @"score",
                          @"High Risk", @"riskgroup",
                          @"1.6 years", @"mediansurvival",
                          @"1.4 years", @"amlsurvival",
                          nil] forKey:@"50"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"5.5", @"score",
                          @"High Risk", @"riskgroup",
                          @"1.6 years", @"mediansurvival",
                          @"1.4 years", @"amlsurvival",
                          nil] forKey:@"55"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"6.0", @"score",
                          @"High Risk", @"riskgroup",
                          @"1.6 years", @"mediansurvival",
                          @"1.4 years", @"amlsurvival",
                          nil] forKey:@"60"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"6.5", @"score",
                          @"Very High Risk", @"riskgroup",
                          @"0.8 years", @"mediansurvival",
                          @"0.7 years", @"amlsurvival",
                          nil] forKey:@"65"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"7.0", @"score",
                          @"Very High Risk", @"riskgroup",
                          @"0.8 years", @"mediansurvival",
                          @"0.7 years", @"amlsurvival",
                          nil] forKey:@"70"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"7.5", @"score",
                          @"Very High Risk", @"riskgroup",
                          @"0.8 years", @"mediansurvival",
                          @"0.7 years", @"amlsurvival",
                          nil] forKey:@"75"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"8.0", @"score",
                          @"Very High Risk", @"riskgroup",
                          @"0.8 years", @"mediansurvival",
                          @"0.7 years", @"amlsurvival",
                          nil] forKey:@"80"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"8.5", @"score",
                          @"Very High Risk", @"riskgroup",
                          @"0.8 years", @"mediansurvival",
                          @"0.7 years", @"amlsurvival",
                          nil] forKey:@"85"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"9.0", @"score",
                          @"Very High Risk", @"riskgroup",
                          @"0.8 years", @"mediansurvival",
                          @"0.7 years", @"amlsurvival",
                          nil] forKey:@"90"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"9.5", @"score",
                          @"Very High Risk", @"riskgroup",
                          @"0.8 years", @"mediansurvival",
                          @"0.7 years", @"amlsurvival",
                          nil] forKey:@"95"];
    [ipssRDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                          @"10.0", @"score",
                          @"Very High Risk", @"riskgroup",
                          @"0.8 years", @"mediansurvival",
                          @"0.7 years", @"amlsurvival",
                          nil] forKey:@"100"];
    
    
}

- (void) computeIPSS_R
{
    float score = 0.0;
    
    for (int i=0; i<[sectionsDict count]; i++) {
        NSDictionary *sd = [sectionsDict objectForKey:[NSString stringWithFormat:@"%d", i]];
        NSMutableArray *options = [sd objectForKey:@"options"];
        
        for (int j=0; j<[options count]; j++) {
            NSMutableDictionary *d = [options objectAtIndex:j];
            if ([[d objectForKey:@"selected"] isEqual: @"1"]) {
                score += [[d objectForKey:@"points"] floatValue];
            }
        }
        
    }
    
    
    NSDictionary *dict = [ipssRDict valueForKey:[[NSString stringWithFormat:@"%01.1f", score] stringByReplacingOccurrencesOfString:@"." withString:@""]];
    
    self.detailViewController = [[[GenericGroupedTableViewController alloc] init] autorelease];
    self.detailViewController.keys = [NSMutableArray arrayWithObjects:@"score", @"riskgroup", @"mediansurvival", @"amlsurvival", nil];
    self.detailViewController.dict = dict;
    self.detailViewController.title = self.title;
    
}

-(void) loadIPSS_WHO
{
    NSMutableArray *sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"Refractory anemia, refractory anemia with ring sideroblasts, or MDS with isolated 5q", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"Refractory cytopenia with multilineage dysplasia, refractory cytopenia with multilineage dysplasia with ring sideroblasts", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"2", @"points",
                               @"Refractory anemia with excess blasts-1", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"3", @"points",
                               @"Refractory anemia with excess blasts-2", @"option", nil]];
    
    sectionsDict = [[NSMutableDictionary alloc] init];
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             @"0", @"section",
                             @"WHO classification", @"title",
                             sectionOptions, @"options",
                             nil] forKey:@"0"];
    [sectionOptions release];
    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"Good", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"Intermediate", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"2", @"points",
                               @"Poor", @"option", nil]];
    
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             @"1", @"section",
                             @"Cytogenetics", @"title",
                             sectionOptions, @"options",
                             nil] forKey:@"1"];
    
    [sectionOptions release];
    sectionOptions = [[NSMutableArray alloc] init];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"0", @"points",
                               @"None", @"option", nil]];
    [sectionOptions addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               @"0", @"selected",
                               @"1", @"points",
                               @"Regular", @"option", nil]];
    [sectionsDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                             @"0", @"selected",
                             @"2", @"section",
                             @"Red cell transfusion need", @"title",
                             sectionOptions, @"options",
                             nil] forKey:@"2"];
    
    [sectionOptions release];
    
    whoDict = [[NSMutableDictionary alloc] init];
    [whoDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         @"0", @"score",
                         @"Very Low Risk", @"riskgroup",
                         @"141 months", @"mediansurvival",
                         @"141 months", @"amlsurvival",
                         nil] forKey:@"00"];
    [whoDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"1", @"score",
                        @"Low Risk", @"riskgroup",
                        @"6 months", @"mediansurvival",
                        @"66 months", @"amlsurvival",
                        nil] forKey:@"10"];
    [whoDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"2", @"score",
                        @"Intermediate Risk", @"riskgroup",
                        @"48 months", @"mediansurvival",
                        @"48 months", @"amlsurvival",
                        nil] forKey:@"20"];
    [whoDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"3", @"score",
                        @"High Risk", @"riskgroup",
                        @"26 months", @"mediansurvival",
                        @"26 months", @"amlsurvival",
                        nil] forKey:@"30"];
    [whoDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"4", @"score",
                        @"High Risk", @"riskgroup",
                        @"26 months", @"mediansurvival",
                        @"26 months", @"amlsurvival",
                        nil] forKey:@"40"];
    [whoDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"5", @"score",
                        @"High Risk", @"riskgroup",
                        @"9 months", @"mediansurvival",
                        @"9 months", @"amlsurvival",
                        nil] forKey:@"50"];
    [whoDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        @"6", @"score",
                        @"High Risk", @"riskgroup",
                        @"9 months", @"mediansurvival",
                        @"9 months", @"amlsurvival",
                        nil] forKey:@"60"];
    
}

- (void) computeIPSS_WHO
{
    float score = 0.0;
    
    for (int i=0; i<[sectionsDict count]; i++) {
        NSDictionary *sd = [sectionsDict objectForKey:[NSString stringWithFormat:@"%d", i]];
        NSMutableArray *options = [sd objectForKey:@"options"];
        
        for (int j=0; j<[options count]; j++) {
            NSMutableDictionary *d = [options objectAtIndex:j];
            if ([[d objectForKey:@"selected"] isEqual: @"1"]) {
                score += [[d objectForKey:@"points"] floatValue];
            }
        }
        
    }
    
    
    NSDictionary *dict = [whoDict valueForKey:[[NSString stringWithFormat:@"%01.1f", score] stringByReplacingOccurrencesOfString:@"." withString:@""]];
    
    self.detailViewController = [[[GenericGroupedTableViewController alloc] init] autorelease];
    self.detailViewController.keys = [NSMutableArray arrayWithObjects:@"score", @"riskgroup", @"mediansurvival", @"amlsurvival", nil];
    self.detailViewController.dict = dict;
    self.detailViewController.title = self.title;    
}

- (void) computeResult
{
    
}


//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    return [sectionsDict count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [NSString stringWithFormat:@"%ld", (long)section];
    NSDictionary *d = [sectionsDict objectForKey:key];
    return [d objectForKey:@"title"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    int sectionsCount =(int) ([sectionsDict count] - 1);
    if (section == sectionsCount){
        return 60.0;
    }
    else
    {
        return 2.0;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    int sectionsCount = (int)([sectionsDict count] - 1);
    
    if (footerView == nil){
        //allocate the view if it doesn't exist yet
        footerView  = [[UIView alloc] init];
        
        //create the button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        //the button should be as big as a table view cell
        [button setFrame:CGRectMake(10, 3, 300, 44)];
        
        //set title, font size and font color
        [button setTitle:@"Result" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [button setBackgroundColor:[UIColor lightTextColor]];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        //set action of the button
        [button addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
        
        //add the button to the view
        [footerView addSubview:button];
        
    }

    //return the view for the footer
    if (section == sectionsCount)
    {
        return footerView;
    }
    else
    {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSDictionary *d = [sectionsDict objectForKey:[NSString stringWithFormat:@"%ld", (long)section]];
    NSMutableArray *options = [d objectForKey:@"options"];

    return [options count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier] autorelease];
    }
    
    NSDictionary *d = [sectionsDict objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.section]];
    NSMutableArray *options = [d objectForKey:@"options"];
    NSDictionary *dict = [options objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"option"];
    [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
    cell.textLabel.numberOfLines = 0;
    if ([[dict objectForKey:@"selected"] isEqual: @"1"])
    {
        //cell.accessoryType = UITableViewCellAccessoryCheckmark;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check.png"]];
        cell.accessoryView = imageView;
        [imageView release];
    }
    else
    {
        cell.accessoryView = nil;
        //cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *d = [sectionsDict objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.section]];
    NSMutableArray *options = [d objectForKey:@"options"];
    NSDictionary *dict = [options objectAtIndex:indexPath.row];
    NSString *str = [dict objectForKey:@"option"];
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:17.0] constrainedToSize:CGSizeMake(260.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    if ((size.height == 0) || (size.height <= 44.0))
        return 44.0 + 5.0;
    else
        return size.height + 25.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSMutableDictionary *dict;
    NSMutableDictionary *d = [sectionsDict objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.section]];
    NSMutableArray *options = [d objectForKey:@"options"];
    for (int i=0; i<[options count]; i++)
    {
        cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
        //cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = nil;
        dict = [options objectAtIndex:i];
        [dict setValue:@"0" forKey:@"selected"];
    }
    dict = [options objectAtIndex:indexPath.row];
    [dict setValue:@"1" forKey:@"selected"];

    cell = [tableView cellForRowAtIndexPath:indexPath];
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check.png"]];
    cell.accessoryView = imageView;
    [imageView release];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) configureView
{
    //	UIBarButtonItem *computeButton = [[[UIBarButtonItem alloc]
    //								   initWithTitle:@"Compute Result"
    //								   style:UIBarButtonItemStyleBordered
    //								   target:self
    //								   action:@selector(compute:)] autorelease];
    //	self.navigationItem.rightBarButtonItem = computeButton;
    
    if (self.detailViewController != nil)
    {
        [self.detailViewController release];
        self.detailViewController = nil;
    }
    
    if (footerView != nil)
    {
        [footerView release];
        footerView = nil;
    }
    
    if ([self.type isEqual: @"FLIPI"])
    {
        [self loadFLIPI];
    }
    else if ([self.type isEqual: @"IPSS"])
    {
        [self loadIPSS];
    }
    else if ([self.type isEqual: @"IPSS-R"])
    {
        [self loadIPSS_R];
    }
    else if (([self.type isEqual: @"IPI"]) || ([self.type isEqual: @"AAIPI"]))
    {
        [self loadIPI];
    }
    else if ([self.type isEqual: @"RCC"])
    {
        [self loadRCC];
    }
    else if ([self.type isEqual: @"WHO"])
    {
        [self loadIPSS_WHO];
    }
    
}

- (IBAction)compute:(id)sender
{
    if ([self.type isEqual: @"FLIPI"])
    {
        [self computeFLIPI];
    }
    else if ([self.type isEqual: @"IPSS"])
    {
        [self computeIPSS];
    }
    else if ([self.type isEqual: @"IPSS-R"])
    {
        [self computeIPSS_R];
    }
    else if (([self.type isEqual: @"IPI"]) || ([self.type isEqual: @"AAIPI"]))
    {
        [self computeIPI];
    }
    else if ([self.type isEqual: @"RCC"])
    {
        [self computeRCC];
    }    
    else if ([self.type isEqual: @"WHO"])
    {
        [self computeIPSS_WHO];
    }
    [[self navigationController] pushViewController:self.detailViewController animated:YES ];
    
    //[self.detailViewController release];
}

- (void)dealloc {
//    [ipiDict dealloc];
//    [ipssRDict dealloc];
//    [whoDict dealloc];
//    [sectionsDict dealloc];
//    [footerView dealloc];
    //[ipssRDict release];
    //[whoDict release];
    //[sectionsDict release];
    //[footerView release];
    [super dealloc];
}

@end
