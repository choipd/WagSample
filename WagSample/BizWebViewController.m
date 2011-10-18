//
//  BizWebViewController.m
//  ImIn
//
//  Created by Myungjin Choi on 11. 10. 11..
//  Copyright 2011년 KTH. All rights reserved.
//

#import "BizWebViewController.h"
#import "NSString+URLEncoding.h"

@implementation BizWebViewController
@synthesize titleString, urlString;
@synthesize right_jscall, left_jscall;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    wagw = [[WebAppGatewayProtocol alloc] init];
    wagw.delegate = self;
    wagw.whichVC = self;
    wagw.whichWebView = aWebView;
    
    left_jscall = nil;
    right_jscall = nil;

    aWebView.delegate = self;
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSURL* url = [NSURL URLWithString:self.urlString];
    if (url) {
        [aWebView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    
    aWebView.autoresizesSubviews = YES; 
    aWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
}
    
    

- (void)viewDidUnload
{
    urlTextField = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)goUrl:(id)sender {

    self.urlString = [urlTextField text];
    
    NSURL* url = [NSURL URLWithString:self.urlString];
    
    if (url) {
        [aWebView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

- (IBAction) closeVC {
	[aWebView stopLoading];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction) leftBtnClick
{
    if (left_jscall != nil) {
        [aWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@()", left_jscall]];        
    }
}

- (IBAction) rightBtnClick
{
    if (right_jscall != nil) {
        [aWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@()", right_jscall]];        
    }
}

#pragma mark - WebAppGatewayProtocol Delegate

- (BOOL) willProcessUiDescriptionWithData:(NSDictionary*) data {
    
    
    NSLog(@"willProcessUiDescriptionWithData");
    
    if ([data objectForKey:@"left_enable"]
        || [data objectForKey:@"title_text"]
        || [data objectForKey:@"left_jscall"]
        || [data objectForKey:@"right_enable"]
        || [data objectForKey:@"right_jscall"]
        ) {
        
        leftBtn.hidden = ![[data objectForKey:@"left_enable"] isEqualToString:@"y"];
        
        if (leftBtn.hidden == NO) {
            [leftBtn setTitle:[data objectForKey:@"left_text"] forState:UIControlStateNormal];
        }
        
        rightBtn.hidden = ![[data objectForKey:@"right_enable"] isEqualToString:@"y"];
        
        if (rightBtn.hidden == NO) {
            [rightBtn setTitle:[data objectForKey:@"right_text"] forState:UIControlStateNormal];
        }

        titleLabel.text = [data objectForKey:@"title_text"];
        
        self.left_jscall = [data objectForKey:@"left_jscall"];
        self.right_jscall = [data objectForKey:@"right_jscall"];
    }
    
    return YES;
}

- (BOOL) didProcessUiDescriptionWithData:(NSDictionary*) data {
    NSLog(@"didProcessUiDescriptionWithData");
    return YES;
}

- (BOOL) willProcessAppRequestWithData:(NSDictionary*) data {
    NSLog(@"willProcessAppRequestWithData");
    return YES;
}

- (BOOL) didProcessAppRequestWithData:(NSDictionary*) data {
    NSLog(@"didProcessAppRequestWithData");
    return YES;
}

#pragma mark -
#pragma mark webview delegate 
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
	NSURL *url = request.URL;
    return [wagw processWithUrl:url];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
}

@end

