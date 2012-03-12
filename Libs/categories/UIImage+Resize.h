//
//  UIImage+Resize.h
//  iTarantula
//
//  Created by Francesco on 17/01/2012.
//  Copyright (c) 2012 Ziofritz.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

- (UIImage*)scaleWithMaxSize:(CGSize)maxSize quality:(CGInterpolationQuality)quality;

@end
