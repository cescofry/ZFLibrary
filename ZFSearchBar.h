//
//  ZFSearchBar.h
//  iTarantula
//
//  Created by Francesco on 09/01/2012.
//  Copyright (c) 2012 Ziofritz.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZFSearchBardelegate;
@interface ZFSearchBar : UISearchBar <UISearchBarDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, assign) __unsafe_unretained id<ZFSearchBardelegate> zfDelegate;

- (void)setDelegate:(id<ZFSearchBardelegate>)delegate;

@end

@protocol ZFSearchBardelegate <NSObject>
@optional
- (BOOL)searchBarShouldClear:(ZFSearchBar *)searchBar;
- (void)searchBarBeginEditing:(ZFSearchBar *)searchBar;

@end
