//
//  ZFSemaforeButton.h
//  iTarantula
//
//  Created by Francesco on 23/01/2012.
//  Copyright (c) 2012 Ziofritz.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ZFSemaforeButtonTypeRed,
    ZFSemaforeButtonTypeGreen
} ZFSemaforeButtonType;

@protocol ZFSemaforeButtonDelegate;
@interface ZFSemaforeButton : UIButton

@property (nonatomic, assign) __unsafe_unretained id<ZFSemaforeButtonDelegate> delegate;

+ (ZFSemaforeButton *)greenButtonWithFrame:(CGRect)frame withTitle:(NSString *)title andDelegate:(id<ZFSemaforeButtonDelegate>) delegate;
+ (ZFSemaforeButton *)redButtonWithFrame:(CGRect)frame withTitle:(NSString *)title andDelegate:(id<ZFSemaforeButtonDelegate>) delegate;

- (void)addTarget:(id)target action:(SEL)action;

@end

@protocol ZFSemaforeButtonDelegate <NSObject>
@optional
- (void)didTapSemaforeButton:(ZFSemaforeButton *)button;

@end
