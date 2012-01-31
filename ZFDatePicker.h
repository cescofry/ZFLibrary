//
//  ZFDatePicker.h
//  iTarantula
//
//  Created by Francesco on 17/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZFDatePickerDelegate;
@interface ZFDatePicker : UIDatePicker 

@property (nonatomic, assign) __unsafe_unretained id<ZFDatePickerDelegate> delegate;
@property (nonatomic, assign) BOOL isHiding;

- (void)pinToBottom;
- (void)duckAway;

@end

@protocol ZFDatePickerDelegate <NSObject>

- (void)datePickerWillAppear:(ZFDatePicker *)picker;
- (void)datePickerWillDisappear:(ZFDatePicker *)picker;

@end
