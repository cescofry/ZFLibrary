//
//  ZFActivityView.m
//  Solgar
//
//  Created by cescofry Freezone on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ZFActivityView.h"
#import "UIView+Layout.h"
#import <QuartzCore/QuartzCore.h>

@implementation ZFActivityView

static UIActivityIndicatorView *_activityIndicator;

- (id)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style
{
    self = [super initWithFrame:CGRectMake(0, 0, 120, 100)];
    if (self) {
        // Initialization code

        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
        [self addSubview:_activityIndicator];
        [_activityIndicator setCenter:self.center];
        [_activityIndicator positionAtY:14];
        
        UILabel *loading = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 120, 30)];
        [loading setText:@"Loading"];
        [loading setTextColor:[UIColor whiteColor]];
        [loading setFont:[UIFont boldSystemFontOfSize:20]];
        [loading setBackgroundColor:[UIColor clearColor]];
        [loading setTextAlignment:UITextAlignmentCenter];
        [self addSubview:loading];
        
        
        self.layer.borderWidth = 0;
        self.layer.cornerRadius = 15.0;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(5, 5);
        self.layer.shadowRadius = 10;
        
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
        [self setAlpha:0];
    }
    return self;
}

- (void)show {
    if (self.alpha == 1) return;
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
        [self setAlpha:1];
    } completion:^(BOOL finished) {
        [_activityIndicator startAnimating];
    }];

}


- (void)hide {
    if (self.alpha == 0) return;
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [_activityIndicator stopAnimating];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
