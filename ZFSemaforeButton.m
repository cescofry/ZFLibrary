//
//  ZFSemaforeButton.m
//  iTarantula
//
//  Created by Francesco on 23/01/2012.
//  Copyright (c) 2012 Ziofritz.com. All rights reserved.
//

#import "ZFSemaforeButton.h"

@implementation ZFSemaforeButton

@synthesize delegate = _delegate;

#pragma mark actions

- (void)didTapButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapSemaforeButton:)]) {
        [self.delegate didTapSemaforeButton:self];
    }
}

#pragma mark init

+ (id)buttonWithType:(UIButtonType)buttonType {
    UIButton *btn = [super buttonWithType:buttonType];
    return btn;
}

+ (ZFSemaforeButton *)buttonWithFrame:(CGRect)frame withTitle:(NSString *)title ofType:(ZFSemaforeButtonType)type {
    ZFSemaforeButton *btn = (ZFSemaforeButton *)[self buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    
    NSString *colorName;
    switch (type) {
        case ZFSemaforeButtonTypeRed:
            colorName = @"red";
            break;
        case ZFSemaforeButtonTypeGreen:
            colorName = @"green";
            break;            
        default:
            break;
    }
    
    UIImage *bkg = [[UIImage imageNamed:[NSString stringWithFormat:@"button_%@.png", colorName]] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
    [btn setBackgroundImage:bkg forState:UIControlStateNormal];
    [btn addTarget:btn action:@selector(didTapButton:)];
    return btn;
}

+ (ZFSemaforeButton *)greenButtonWithFrame:(CGRect)frame withTitle:(NSString *)title andDelegate:(id<ZFSemaforeButtonDelegate>) delegate{
    ZFSemaforeButton *btn = [self buttonWithFrame:frame withTitle:title ofType:ZFSemaforeButtonTypeGreen];
    [btn setDelegate:delegate];
    return btn;
    
}

+ (ZFSemaforeButton *)redButtonWithFrame:(CGRect)frame withTitle:(NSString *)title andDelegate:(id<ZFSemaforeButtonDelegate>) delegate{
    ZFSemaforeButton *btn =  [self buttonWithFrame:frame withTitle:title ofType:ZFSemaforeButtonTypeRed];
    [btn setDelegate:delegate];
    return btn;

}

- (void)addTarget:(id)target action:(SEL)action{
    if (self.delegate) [NSException raise:@"Incorrect Implmeentation" format:@"This instance of ZFButton will respond to delegates for hooking actions"];
    else [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
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
