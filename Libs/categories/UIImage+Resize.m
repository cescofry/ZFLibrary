//
//  UIImage+Resize.m
//  iTarantula
//
//  Created by Francesco on 17/01/2012.
//  Copyright (c) 2012 Ziofritz.com. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};


- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees {   
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

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

- (UIImage *)imageFromImagePickerAtRect:(CGRect)rect {
    UIImageOrientation originalOrientation = self.imageOrientation;
 
    UIImage *sizedImg = [self imageAtRect:rect];
    
    if (originalOrientation == UIImageOrientationRight) {
           sizedImg = [sizedImg imageRotatedByDegrees:90];
       } 
    else if (originalOrientation == UIImageOrientationLeft) {
           sizedImg = [sizedImg imageRotatedByDegrees:-90];
       } 
    else if (originalOrientation == UIImageOrientationUp) {
           sizedImg = [sizedImg imageRotatedByDegrees:0];
       }
    else if (originalOrientation == UIImageOrientationDown) {
           sizedImg = [sizedImg imageRotatedByDegrees:180];
       }
    
    return sizedImg;
}

-(UIImage *)imageAtRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage* subImage = [UIImage imageWithCGImage: imageRef];
    CGImageRelease(imageRef);
    
    return subImage;
}

@end
