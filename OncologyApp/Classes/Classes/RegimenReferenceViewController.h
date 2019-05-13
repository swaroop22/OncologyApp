//
//  RegimenReferenceViewController.h
//  OncologyApp
//
//  Created by Niranjan Kode on 10/27/12.
//
//

#import <UIKit/UIKit.h>

@interface RegimenReferenceViewController : UIViewController <UISplitViewControllerDelegate, NSXMLParserDelegate> 
{
    IBOutlet UIWebView	*webView;
    //IBOutlet UIBarItem *closeButton;
}

@property (assign, nonatomic) NSURL *url;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
//@property (strong, nonatomic) IBOutlet UIBarItem *closeButton;

- (IBAction)closePopupWindow:(id)sender;

@end
