//
//  UIImage+Resize.m
//  iTarantula
//
//  Created by Francesco on 17/01/2012.
//  Copyright (c) 2012 Ziofritz.com. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (UIImage*)scaleWithMaxSize:(CGSize)maxSize quality:(CGInterpolationQuality)quality {
    
    CGRect        bnds = CGRectZero;
    UIImage*      copy = nil;
    CGContextRef  ctxt = nil;
    CGRect        orig = CGRectZero;
    CGFloat       rtio = 0.0;
    CGFloat       scal = 1.0;
	
    bnds.size = self.size;
    orig.size = self.size;
    rtio = orig.size.width / orig.size.height;
	
    if ((orig.size.width <= maxSize.width) && (orig.size.height <= maxSize.height)) {
        return self;
    }
	
    if (rtio > 1.0) {
        bnds.size.width  = maxSize.width;
        bnds.size.height = maxSize.height / rtio;
    }
    else {
        bnds.size.width  = maxSize.width * rtio;
        bnds.size.height = maxSize.height;
    }
	
    UIGraphicsBeginImageContext(bnds.size);
    ctxt = UIGraphicsGetCurrentContext();
	
    scal = bnds.size.width / orig.size.width;
    CGContextSetInterpolationQuality(ctxt, quality);
    CGContextScaleCTM(ctxt, scal, -scal);
    CGContextTranslateCTM(ctxt, 0.0, -orig.size.height);
    CGContextDrawImage(ctxt, orig, self.CGImage);
	
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return copy;
}

@end
