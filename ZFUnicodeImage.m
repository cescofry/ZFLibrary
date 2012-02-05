//
//  ZFUnicodeImage.m
//  iTarantula
//
//  Created by Francesco on 25/01/2012.
//  Copyright (c) 2012 Ziofritz.com. All rights reserved.
//

#import "ZFUnicodeImage.h"

@implementation ZFUnicodeImage


+ (UIImage *)imageOfSize:(CGSize)size fromUnicode:(NSString *)string withFont:(UIFont *)font andColor:(UIColor *)color {
    
    if (!font) font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    if (!color) color = [UIColor blackColor];
    
    UIGraphicsBeginImageContext(size);
    
    // Measure the string size.
    CGSize stringSize = [string sizeWithFont:font];
    
    // Work out what it should be scaled by to get the desired size.
    CGFloat xRatio = size.width / stringSize.width;
    CGFloat yRatio = size.height / stringSize.height;
    CGFloat ratio = MIN(xRatio, yRatio);
    
    // Work out the point size that'll give us the desired image size, and
    // create a UIFont that size.
    CGFloat oldFontSize = font.pointSize;
    CGFloat newFontSize = floor(oldFontSize * ratio);
    ratio = newFontSize / oldFontSize;
    font = [font fontWithSize:newFontSize];
    
    // What size is the string with this new font?
    stringSize = [string sizeWithFont:font];
    
    // Work out where the origin of the drawn string should be to get it in
    // the centre of the image.
    CGPoint textOrigin = CGPointMake((size.width - stringSize.width) / 2,
                                     (size.height - stringSize.height) / 2);
    
    //Set Color to context
    [color set];
    
    // Draw the string into out image!
    [string drawAtPoint:textOrigin withFont:font];
    
    // We're done!  Grab the image and return it!
    // (Don't forget to end the image context first though!)
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return retImage;
}


+ (UIImage *)imageOfSize:(CGSize)size fromUnicode:(NSString *)string {
    return [self imageOfSize:size fromUnicode:string withFont:nil andColor:nil];
}

@end
