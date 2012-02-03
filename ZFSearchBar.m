//
//  ZFSearchBar.m
//  iTarantula
//
//  Created by Francesco on 09/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ZFSearchBar.h"

@implementation ZFSearchBar

@synthesize textField = _textField;
@synthesize backgroundView = _backgroundView;
@synthesize zfDelegate = _zfDelegate;


- (void)setDelegate:(id<ZFSearchBardelegate>)delegate {
    self.zfDelegate = delegate;
    [super setDelegate:(id<UISearchBarDelegate>)delegate];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundView = [self.subviews objectAtIndex:0];
        self.textField = [self.subviews objectAtIndex:1];
        
        [self.textField setReturnKeyType:UIReturnKeyDone];
              
    }
    return self;
}


// tapped [x] button
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (self.zfDelegate && [self.zfDelegate respondsToSelector:@selector(searchBarShouldClear:)]) {
        return [self.zfDelegate searchBarShouldClear:self];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.zfDelegate && [self.zfDelegate respondsToSelector:@selector(searchBarBeginEditing:)]) {
        [self.zfDelegate searchBarBeginEditing:self];
    }    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self setShowsCancelButton:NO animated:YES];
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *finalString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self setShowsCancelButton:(finalString.length == 0) animated:YES];
    return YES;
}

@end
