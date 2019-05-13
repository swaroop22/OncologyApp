//
//  PrognosticScoresDetailViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 1/21/13.
//
//

#import <UIKit/UIKit.h>

@interface PrognosticScoresDetailViewController : UIViewController

@property (strong, nonatomic) NSString *titleText;
@property (strong, nonatomic) NSString *scoreText;
@property (strong, nonatomic) NSString *scoreText2;
@property (strong, nonatomic) NSString *scoreText3;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel2;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel3;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;

- (IBAction)dismissAction:(id)sender;


@end
