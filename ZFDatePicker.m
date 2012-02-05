//
//  ZFDatePicker.m
//  iTarantula
//
//  Created by Francesco on 17/01/2012.
//  Copyright (c) 2012 Ziofritz.com. All rights reserved.
//

#import "ZFDatePicker.h"

@implementation ZFDatePicker

@synthesize delegate = _delegate;
@synthesize isHiding = _isHiding;
static CGRect _origFrame;


- (void)pinToBottom {
    if (!self.isHiding) return;
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerWillAppear:)]) {
        [self.delegate datePickerWillAppear:self];
    }
    
    __block CGRect frame = _origFrame;
    frame.origin.y = (self.superview)? self.superview.frame.size.height + 10 : 999;
    [self setFrame:frame];
    [self.superview bringSubviewToFront:self];
    
    [UIView animateWithDuration:0.4 animations:^{
        frame.origin.y = self.superview.frame.size.height - frame.size.height;
        [self setFrame:frame];
    }];
    self.isHiding = NO;
}

- (void)duckAway {
    if (self.isHiding) return;
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerWillDisappear:)]) {
        [self.delegate datePickerWillDisappear:self];
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = self.superview.frame.size.height + 10;
        [self setFrame:frame];
    } completion:^(BOOL finished) {
        //[self removeFromSuperview];
    }];
    self.isHiding = YES;
}


- (void)didTapDone:(id)sender {
    [self duckAway];
}


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        
        
        UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        pickerToolbar.barStyle=UIBarStyleBlackOpaque;
        [pickerToolbar sizeToFit];   
        NSMutableArray *barItems = [[NSMutableArray alloc] init]; 
        
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [barItems addObject:flexSpace];
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didTapDone:)];
        [barItems addObject:btn];
        
        [pickerToolbar setItems:barItems animated:YES];       
        [self addSubview:pickerToolbar];
        
        _origFrame = self.frame;
        CGRect frame = _origFrame;
        frame.origin.y = (self.superview)? self.superview.frame.size.height + 10 : 999;
        [self setFrame:frame];
        self.isHiding = YES;
    }
    return self;
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
