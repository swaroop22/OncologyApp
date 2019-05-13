//
//  LymphomaDetailViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 9/27/12.
//
//

#import "LymphomaDetailViewController.h"
#import "OncologyAppAppDelegate.h"
#import "Util.h"

@interface LymphomaDetailViewController ()
- (void)configureView;
- (void)updateResult;
- (void)convertTemp;
- (void)tempUpdated;
@end

float tC, tF;
int wl;
int sweatIndex;

@implementation LymphomaDetailViewController

@synthesize stageLabel, sweat, temperature;

- (void)configureView
{
    tC = 0;
    tF = 0;
    sweatIndex = 1;
    wl = 0;
    self.sweat.selectedSegmentIndex = sweatIndex;
    self.stageLabel.text = [self.stage stringByAppendingString: @" - A"];
}

- (void) convertTemp
{

}
- (void) updateResult
{
    self.stageLabel.text = [self.stage stringByAppendingString: @" - A"];
    if ((tC > 38.0) || (wl > 10) || (sweatIndex == 0))
    {
        self.stageLabel.text = [self.stage stringByAppendingString: @" - B"];
    }
}

- (void)tempUpdated
{
    switch (self.tempFormat.selectedSegmentIndex) {
        case 0:
            tC = [self.temperature.text floatValue];
            tF = (tC * 1.8) + 32.0;
            break;
        case 1:
            tF = [self.temperature.text floatValue];
            tC = (tF -32.0)/1.8;
            break;
        default:
            break;
    }
    [self updateResult];    
}

- (void)awakeFromNib
{
	self.title = @"Lymphoma Detail";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)sweatIndexChanged {
    sweatIndex = (int)self.sweat.selectedSegmentIndex;
    [self updateResult];
}

- (IBAction)tempChanged:(id)sender {
    [self tempUpdated];
}

- (IBAction)weigthLossChanged:(id)sender {
    wl = [self.weightLoss.text intValue];
    [self updateResult];
}

- (IBAction)tempFormatIndexChanged {
    if (self.tempFormat.selectedSegmentIndex == 0) {
        tF = [self.temperature.text floatValue];
        tC = (tF -32.0)/1.8;
        self.temperature.text = [NSString stringWithFormat:@"%3.1f", tC];
    }
    else if (self.tempFormat.selectedSegmentIndex == 1) {
        tC = [self.temperature.text floatValue];
        tF = (tC * 1.8) + 32.0;
        self.temperature.text = [NSString stringWithFormat:@"%3.1f", tF];
    }
    [self updateResult];
}

@end


