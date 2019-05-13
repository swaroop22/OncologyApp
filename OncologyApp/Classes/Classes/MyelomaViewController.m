//
//  MyelomaViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 1/12/13.
//
//

#import "MyelomaViewController.h"

@interface MyelomaViewController ()
- (void)configureView;
- (void)updateResult;
@end

@implementation MyelomaViewController

@synthesize stageLabel, b2m, serum;

- (void)configureView
{
    self.stageLabel.text = @"";
}

- (void) updateResult
{
    self.stageLabel.text = @"";
    
    float bm = [self.b2m.text floatValue];
    float sa = [self.serum.text floatValue];
    
    if ((bm < 3.5) && (sa >= 3.5))
    {
        self.stageLabel.text = @"Stage I";
    }
    else if (bm >= 5.5)
    {
        self.stageLabel.text = @"Stage III";
    }
    else
    {
        self.stageLabel.text = @"Stage II";        
    }
}


- (void)awakeFromNib
{
	self.title = @"Myeloma";
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

- (IBAction)b2mChanged:(id)sender {
    [self updateResult];
}

- (IBAction)serumChanged:(id)sender {
    [self updateResult];
}

@end



