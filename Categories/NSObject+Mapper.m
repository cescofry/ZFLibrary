//
//  NSObject+Mapper.m
//  Pods
//
//  Created by Francesco Frison on 26/05/2014.
//
//

#import "NSObject+Mapper.h"
#import <objc/runtime.h>

@implementation ZFRMap

+ (instancetype)mapForClass:(Class)aClass convertKey:(NSString *)convertKey valueToString:(ValueToStringBlock)valueToString andStringToValue:(StringToValueBlock)stringToValue
{
    ZFRMap *map = [ZFRMap new];
    map.convertClass = aClass;
    map.valueToString = [valueToString copy];
    map.stringToValue = [stringToValue copy];
    map.convertKey = convertKey;
    
    return map;
}

@end

#pragma mark - Mapper -

@implementation NSObject (Mapper)

+ (NSArray *)classVarKeys
{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableArray *keys = [NSMutableArray array];
    
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [keys addObject:name];
    }
    
    free(properties);
    
    return [keys copy];
    
}

+ (ZFRMap *)mapForKey:(NSString *)key
{
    key = [key stringByReplacingOccurrencesOfString:@"__" withString:@""];
    NSString *classKey = NSStringFromClass([self class]);
    NSMutableDictionary *maps = _mapper[classKey];

    return maps[key];
}

static NSMutableDictionary *_mapper;

+ (void)addMap:(ZFRMap *)map
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mapper = [NSMutableDictionary dictionary];
    });
    

    NSString *convertClassKey = NSStringFromClass(map.convertClass);
    if (!map || [self mapForKey:convertClassKey]) return;
    
    NSString *classKey = NSStringFromClass([self class]);
    NSMutableDictionary *maps = _mapper[classKey];
    if (!maps) {
        maps = [NSMutableDictionary dictionary];
    }
    maps[convertClassKey] = map;

    _mapper[classKey] = maps;
}

- (NSString *)stringValueForKey:(NSString *)key
{
    
    id value = [self valueForKey:key];
    NSString *convertClassKey = NSStringFromClass([value class]);
    ZFRMap *map = [[self class] mapForKey:convertClassKey];
    
    if (map && map.valueToString) {
        return map.valueToString(value);
    }
    
    return value;
}

- (NSString *)classTypeForKey:(NSString *)key
{
    objc_property_t property = class_getProperty([self class], [key UTF8String]);
    
    if (!property) {
        // doesn't exist for object
        return nil;
    }
    const char * propAttr = property_getAttributes(property);
    NSString *propString = [NSString stringWithUTF8String:propAttr];
    
    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:@"@\"(\\w*)\"" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSTextCheckingResult *match = [regEx firstMatchInString:propString options:0 range:NSMakeRange(0, propString.length)];
    if (match) {
        NSRange range = [match rangeAtIndex:1];
        return [propString substringWithRange:range];
    }
    return nil;
    
}

- (id)valueForStringForKey:(NSString *)key
{
    id value = [self valueForKey:key];
    NSString *mapKey = [self classTypeForKey:key];
    if (!mapKey) return value;
    
    ZFRMap *map = [[self class] mapForKey:mapKey];
    if (map && map.stringToValue) {
        return map.stringToValue(value);
    }
    
    return value;
}


@end
