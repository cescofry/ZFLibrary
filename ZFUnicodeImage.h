//
//  ZFUnicodeImage.h
//  iTarantula
//
//  Created by Francesco on 25/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZFUnicodeImageTypeApple @"\uF8FF"
#define ZFUnicodeImageTypeUndo @"\u21A9"
#define ZFUnicodeImageTypeRedo @"\u21AA"


@interface ZFUnicodeImage : UIImage

+ (UIImage *)imageOfSize:(CGSize)size fromUnicode:(NSString *)string;
+ (UIImage *)imageOfSize:(CGSize)size fromUnicode:(NSString *)string withFont:(UIFont *)font andColor:(UIColor *)color;

@end
