//
//  ZFGoogleAnalytics.h
//  Solgar
//
//  Created by Francesco on 02/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GANTracker.h"

@interface ZFGoogleAnalytics : NSObject

@property (nonatomic, strong) GANTracker *tracker;
@property (nonatomic, assign, getter = isAnonimous) BOOL anonimous;
@property (nonatomic, strong) NSError *error;

- (id)initWithAccountID:(NSString *)accountID;

- (BOOL)setCustomerVariablesWithDictionary:(NSDictionary *)dictionary;
- (BOOL)trackPageViewWithName:(NSString *)pageName;
- (BOOL)trackEvent:(NSString *)event action:(NSString *)action label:(NSString *)label andValue:(NSInteger)integerValue;

@end
