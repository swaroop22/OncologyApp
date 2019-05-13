//
//  MyelomaViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 1/12/13.
//
//


#import <UIKit/UIKit.h>

@interface MyelomaViewController : UIViewController
{
}

@property (strong, nonatomic) IBOutlet UILabel *stageLabel;
@property (strong, nonatomic) IBOutlet UITextField *b2m;
@property (strong, nonatomic) IBOutlet UITextField *serum;

- (IBAction)b2mChanged:(id)sender;
- (IBAction)serumChanged:(id)sender;

@end
