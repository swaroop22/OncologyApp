//
//  RegimenReferenceViewController.m
//  OncologyApp
//
//  Created by Niranjan Kode on 10/27/12.
//
//

#import "RegimenReferenceViewController.h"

@interface RegimenReferenceViewController ()

@end


@implementation RegimenReferenceViewController

@synthesize webView;

NSURL *pubmedURL = nil;

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
    
    pubmedURL = self.url;
    
    NSURL *urlRequest = self.url;
    NSError *err = nil;
    
    NSString *html = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
    
    if ([html rangeOfString:@"We're sorry"].location != NSNotFound) {
        urlRequest = [NSURL URLWithString:[self.url.absoluteString stringByReplacingOccurrencesOfString:@"/m/" withString:@"/"]];
        html = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
        NSXMLParser* parser = [[NSXMLParser alloc] initWithData: [html dataUsingEncoding:NSUTF8StringEncoding]];
        [parser setDelegate:self];
        [parser parse];
        [parser release];
    }
    
    
    // Do any additional setup after loading the view from its nib.
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:pubmedURL];
    [self.webView loadRequest:requestObj];
    
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"meta"]) {
        NSString *name = [attributeDict objectForKey:@"name"];
        if ([name isEqual: @"ncbi_term"]) {
            NSString *uid = [attributeDict objectForKey:@"content"];
            NSUInteger index = [self.url.absoluteString rangeOfString:@"term="].location;
            NSString *url = [self.url.absoluteString substringToIndex:index];
            url = [[url stringByAppendingString:@"term="] stringByAppendingString:uid];
            pubmedURL = [NSURL URLWithString:url];
            
            NSLog(@"found metaElement");
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName{
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)closePopupWindow:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
