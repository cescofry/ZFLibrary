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

- (id)initWithAccountID:(NSString *)accountID {
    self = [super init];
    if (self) {
        self.tracker = [GANTracker sharedTracker];
        [self.tracker startTrackerWithAccountID:accountID dispatchPeriod:10 delegate:self];
    }
    return self;
}

- (void)trackerDispatchDidComplete:(GANTracker *)tracker eventsDispatched:(NSUInteger)eventsDispatched eventsFailedDispatch:(NSUInteger)eventsFailedDispatch {
    
    //boh!
}


@end
