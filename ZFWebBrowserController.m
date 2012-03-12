//
//  ZFWebBrowserController.m
//  iTarantula
//
//  Created by cescofry on 25/01/2012.
//  Copyright (c) 2012 Ziofritz.com. All rights reserved.
//

#import "ZFWebBrowserController.h"
#import "ZFUnicodeImage.h"

@implementation ZFWebBrowserController

@synthesize webView = _webView;
@synthesize toolBar = _toolbar;
@synthesize backBtn = _backBtn;
@synthesize nextBtn = _nextBtn;
@synthesize loading = _loading;


#pragma mark actions

- (void)backAction {
    [self.webView goBack];
}

- (void)nextAction {
    [self.webView goForward];
}

- (void)refreshAction {
    
}

- (void)checkIcons {
    [self.backBtn setEnabled:([self.webView canGoBack])];
    [self.nextBtn setEnabled:([self.webView canGoForward])];
    if ([self.webView isLoading])[self.loading startAnimating];
    else [self.loading stopAnimating];
    //[self.loading setHidden:(![self.webView isLoading])];
}

- (void)loadURL:(NSURL *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


- (void)loadHTML:(NSString *)html {
    [self.webView loadHTMLString:html baseURL:nil];
}



#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.webView setDelegate:self];
    [self.view addSubview:self.webView];
    [self.webView setBackgroundColor:[UIColor darkGrayColor]];
    
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, (self.view.bounds.size.height - 44 - 100), 320, 44)];
    self.toolBar.barStyle=UIBarStyleBlackOpaque;
    [self.toolBar sizeToFit];   
    NSMutableArray *barItems = [[NSMutableArray alloc] init]; 
    
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backBtn setImage:[ZFUnicodeImage imageOfSize:CGSizeMake(44, 44) fromUnicode:ZFUnicodeImageTypeUndo withFont:nil andColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    _backBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [barItems addObject:self.backBtn];

    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [nextBtn setImage:[ZFUnicodeImage imageOfSize:CGSizeMake(44, 44) fromUnicode:ZFUnicodeImageTypeRedo withFont:nil andColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    _nextBtn = [[UIBarButtonItem alloc] initWithCustomView:nextBtn];
    [barItems addObject:self.nextBtn];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [barItems addObject:flexSpace];
    
    _loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    UIBarButtonItem *loadingBtn = [[UIBarButtonItem alloc] initWithCustomView:self.loading];
    [barItems addObject:loadingBtn];
    
    [self.toolBar setItems:barItems animated:YES];       
    [self.view addSubview:self.toolBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.toolBar setFrame:CGRectMake(0, (self.view.bounds.size.height - 44), 320, 44)];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark UIWebView delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self checkIcons];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self checkIcons];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
    [alert show];
}


@end
