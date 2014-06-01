//
//  NSObject+Mapper.h
//  Pods
//
//  Created by Francesco Frison on 26/05/2014.
//
//

#import <Foundation/Foundation.h>

typedef NSString* (^ValueToStringBlock)(id value);
typedef id (^StringToValueBlock)(NSString *string);

@interface ZFRMap : NSObject

@property (nonatomic, copy) ValueToStringBlock valueToString;
@property (nonatomic, copy) StringToValueBlock stringToValue;
@property (nonatomic, copy) NSString *convertKey;
@property (nonatomic, assign) Class convertClass;

+ (instancetype)mapForClass:(Class)aClass convertKey:(NSString *)convertKey valueToString:(ValueToStringBlock)valueToString andStringToValue:(StringToValueBlock)stringToValue;

@end

@interface NSObject (Mapper)

+ (NSArray *)classVarKeys;
+ (void)addMap:(ZFRMap *)map;

- (NSString *)stringValueForKey:(NSString *)key;
- (id)valueForStringForKey:(NSString *)key;

@end
