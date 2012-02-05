//
//  ZFWebBrowserController.h
//  iTarantula
//
//  Created by cescofry on 25/01/2012.
//  Copyright (c) 2012 Ziofritz.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFWebBrowserController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong)  UIBarButtonItem *backBtn;
@property (nonatomic, strong)  UIBarButtonItem *nextBtn;
@property (nonatomic, strong)  UIActivityIndicatorView *loading;

- (void)loadURL:(NSURL *)url;
- (void)loadHTML:(NSString *)html;

@end
