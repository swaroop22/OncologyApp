//
//  RegimenDetailViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 9/27/12.
//
//

#import "RegimenDetailViewController.h"
#import "OncologyAppAppDelegate.h"
#import "Util.h"

@interface RegimenDetailViewController ()
- (void)configureView;
@end

@implementation RegimenDetailViewController

@synthesize webView;

- (void)configureView
{
    OncologyAppAppDelegate *appDelegate = (OncologyAppAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.regimenDetail = [appDelegate getRegimenDetailByID:self.regimenID];
    NSString *css = [appDelegate getCSS];
    NSString *html = [self buildHtml:css];
    [self.webView loadHTMLString:html baseURL:nil];
}

- (void)awakeFromNib
{
	self.title = @"Regimen Detail";
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        RegimenReferenceViewController *refVC = [[RegimenReferenceViewController alloc] init];
        refVC.url = [request URL];
        [[self navigationController] presentViewController:refVC animated:YES completion:nil];
        [refVC release];
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webview
{
    NSString *js = @"function toggle() { var element = document.getElementById('dm');  var divElement = document.getElementById('dmDiv');  if (divElement.style.display == '') { element.innerHTML = 'Dosage Modification(s)&#9660;'; divElement.style.display = 'none'; } else {element.innerHTML = 'Dosage Modification(s)&#9650;'; divElement.style.display = ''; }}";
    //NSString *js = @"alert('in window');";
    [webview stringByEvaluatingJavaScriptFromString:js];
    //[super webViewDidFinishLoad:webview];
}

//- (void)webViewDidFinishLoad:(UIWebView *)webview{
//    NSString *js = @"var element = document.getElementById('headerbar');  element.style.dislay = 'none';";
//    [webview stringByEvaluatingJavaScriptFromString:js];
//    [super webViewDidFinishLoad:webview];
//}
//#pragma mark - Split view
//
//- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
//{
//    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
//    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
//    self.masterPopoverController = popoverController;
//}
//
//- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
//{
//    // Called when the view is shown again in the split view, invalidating the button and popover controller.
//    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
//    self.masterPopoverController = nil;
//}
//
- (NSString *)buildHtml: (NSString*)css {
    NSString *html = nil;
    
    //    NSString* html = [NSString stringWithFormat:@"<html><head><style>%@</style><head><body><h2>Heading 1</h2><div><ul><li>Argentina : England</li></ul></div><h2>Heading 2</h2><div><ul><li>India : England</li></ul></div></body></html>", css ];

    NSMutableArray *refs = [Util getReferences:self.regimenDetail.reference];
    
    NSString *references = @"";
    for(NSString* r in refs) {
//        references = [references stringByAppendingFormat:@"<li><a href=\"http://www.ncbi.nlm.nih.gov/pubmed?ncbi_mmode=std&term=%@\">%@</a></li>",
//                        [r stringByReplacingOccurrencesOfString:@";" withString:@" "], r];
        references = [references stringByAppendingFormat:@"<li><a href=\"http://www.ncbi.nlm.nih.gov/m/pubmed?term=%@\">%@</a></li>",
                      [r stringByReplacingOccurrencesOfString:@";" withString:@" "], r];
    }
    
    
    if ([self.regimenDetail.brandName length] == 0) {
        html = [NSString stringWithFormat:@"<html><style>%@</style><body><h2>Regimen</h2><div><ul><li>%@</li></ul></div><h2>Schedule</h2><div><ul><li>%@</li></ul></div><h2>Emetogenic Potential</h2><div><ul><li>%@</li></ul></div><h2 id='dm' onclick='toggle();'>Dosage Modification(s)&#9660;</h2><div id='dmDiv' style='display:none'><ul><li>%@</li></ul></div><h2>Reference</h2><div><ul><li>%@</li></ul></div><div><ul>%@</ul></div></body></html>",
                css,
                self.regimenDetail.name,
                self.regimenDetail.schedule,
                self.regimenDetail.emetogenicPotential,
                self.regimenDetail.dosageModification,
                [self.regimenDetail.reference stringByReplacingOccurrencesOfString:@"$" withString:@""],
                references];
        
    }
    else {
        html = [NSString stringWithFormat:@"<html><style>%@</style><body><h2>Regimen</h2><div><ul><li>%@</li></ul></div><h2>Schedule</h2><div><ul><li>%@</li></ul></div><h2>Emetogenic Potential</h2><div><ul><li>%@</li></ul></div><h2>Brand Name(s)</h2><div><ul><li>%@</li></ul></div><h2 id='dm' onclick='toggle();'>Dosage Modification(s)&#9660;</h2><div id='dmDiv' style='display:none'><ul><li>%@</li></ul></div><h2>Reference</h2><div><ul><li>%@</li></ul></div><div><ul>%@</ul></div></body></html>",
                css,
                self.regimenDetail.name,
                self.regimenDetail.schedule,
                self.regimenDetail.emetogenicPotential,
                self.regimenDetail.brandName,
                self.regimenDetail.dosageModification,
                [self.regimenDetail.reference stringByReplacingOccurrencesOfString:@"$" withString:@""],
                references];
        
    }
    

    return html;
}
@end
