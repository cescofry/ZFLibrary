//
//  Created by Francesco Frison on 4/16/14.
//  Copyright (c) 2014 Ziofritz. All rights reserved.
//

#import "UIColor+extension.h"

float _randomComponent()
{
    return (float)(arc_rand()%255) / 255;
}

@implementation UIColor(extension)


+ (UIColor *)randomColorWithAlpha:(float)alpha
{
    return     [UIColor colorWithRed:_randomComponent() green:_randomComponent() blue:_randomComponent() alpha:alpha];
}

+ (UIColor *)randomColor
{
    return [self randomColorWithAlpha:1.0];
}

+ (UIColor *)colorWithHEXString:(NSString *)HEX
{
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    
    return [[self class] colorWithR:((rgbValue & 0xFF0000) >> 16) G:((rgbValue & 0xFF00) >> 8) B:(rgbValue & 0xFF) A:1.0];
}

- (NSString *)HEXString
{
    NSArray *colorArray	= [self rgbaArray];
    int r = [colorArray[0] floatValue] * 255;
    int g = [colorArray[1] floatValue] * 255;
    int b = [colorArray[2] floatValue] * 255;
    NSString *red = [NSString stringWithFormat:@"%02x", r];
    NSString *green = [NSString stringWithFormat:@"%02x", g];
    NSString *blue = [NSString stringWithFormat:@"%02x", b];
    
    return [NSString stringWithFormat:@"#%@%@%@", red, green, blue];
}

@end