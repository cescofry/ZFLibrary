//
//  ZFMaskedImage.h
//  iTarantula
//
//  Created by cescofry on 29/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFMaskedImage : UIImage

+ (UIImage *)maskImage:(UIImage *)originalImage toPath:(UIBezierPath *)path;

@end
