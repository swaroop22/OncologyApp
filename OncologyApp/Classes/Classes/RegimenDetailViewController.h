//
//  RegimenDetailViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 9/27/12.
//
//

#import <UIKit/UIKit.h>
#import "RegimenDetail.h"
#import "RegimenReferenceViewController.h"

@interface RegimenDetailViewController : UIViewController <UISplitViewControllerDelegate>
{
    IBOutlet UIWebView	*webView;
}

@property (assign, nonatomic) NSInteger regimenID;
@property (assign, nonatomic) RegimenDetail *regimenDetail;

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UILabel *myLabel;

@end
