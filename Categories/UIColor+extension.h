//
//  Created by Francesco Frison on 4/16/14.
//  Copyright (c) 2014 Ziofritz. All rights reserved.
//

@interface UIColor(extension)

+ (UIColor *)randomColor;
+ (UIColor *)colorWithHEXString:(NSString *)HEX;
- (NSString *)HEXString;

@end
