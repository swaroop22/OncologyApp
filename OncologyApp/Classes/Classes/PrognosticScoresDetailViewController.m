//
//  PrognosticScoresDetailViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 1/21/13.
//
//

#import "PrognosticScoresDetailViewController.h"

@interface PrognosticScoresDetailViewController ()

@end

@implementation PrognosticScoresDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = self.titleText;
    self.scoreLabel.text = self.scoreText;
    self.scoreLabel2.text = self.scoreText2;
    self.scoreLabel3.text = self.scoreText3;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissAction:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
