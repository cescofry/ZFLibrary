//
//  NSArray+Tools.h
//  FTLibrary
//
//  Created by Ondrej Rafaj on 14/02/2011.
//  Copyright 2011 Fuerte International. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (Tools)

- (NSArray *)reversedArray;

+ (id)arrayByOrderingSet:(NSSet *)set byKey:(NSString *)key ascending:(BOOL)ascending;

@end
