//
//  ZFGoogleAnalytics.m
//  Solgar
//
//  Created by Francesco on 02/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ZFGoogleAnalytics.h"


@implementation ZFGoogleAnalytics

@synthesize tracker = _tracker;
@synthesize anonimous = _anonimous;
@synthesize error = _error;

- (void)setAnonimous:(BOOL)anonimous {
    _anonimous = anonimous;
    [self.tracker setAnonymizeIp:_anonimous];
}

- (id)initWithAccountID:(NSString *)accountID {
    self = [super init];
    if (self) {
        self.error = nil;
        self.tracker = [GANTracker sharedTracker];
        [self.tracker startTrackerWithAccountID:accountID dispatchPeriod:10 delegate:nil];
    }
    return self;
}


#pragma mark actions

- (BOOL)setCustomerVariablesWithDictionary:(NSDictionary *)dictionary { 
    static int count = 0;
    NSError *error = nil;
    NSArray *keys = [dictionary allKeys];
    for (NSString *key in keys) {
        NSString *value = [dictionary objectForKey:key];
        [self.tracker setCustomVariableAtIndex:count name:key value:value withError:&error];
    }
    if (error) self.error = error;
    return (error == nil);
}

- (BOOL)trackPageViewWithName:(NSString *)pageName {
    NSError *error = nil;
    [self.tracker trackPageview:pageName withError:&error];
    if (error) self.error = error;
    return (error == nil);
}

- (BOOL)trackEvent:(NSString *)event action:(NSString *)action label:(NSString *)label andValue:(NSInteger)integerValue {
    NSError *error = nil;
    [self.tracker trackEvent:event action:action label:label value:integerValue withError:&error];
    if (error) self.error = error;
    return (error == nil);
}



@end
