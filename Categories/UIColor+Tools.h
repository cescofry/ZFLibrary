//
//  UIColor+Tools.h
//  IGFrameworkProject
//
//  Created by Francesco Frison on 7.6.10.
//  Copyright 2010 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIColor (Tools)

+ (UIColor *)colorWithRealRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

- (UIColor *)colorWithRealRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;


+ (UIColor *)randomColor;

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;


+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
- (NSString *)hexString;


+ (UIColor *)alphaPatternImageColorWithSguareSide:(CGFloat)side withColor1:(UIColor *)color1 andColor2:(UIColor *)color2;

+ (UIColor *)alphaPatternImageColorWithSguareSide:(CGFloat)side;

+ (UIColor *)alphaPatternImageColor;

- (UIColor *)complementaryColor;


@end
