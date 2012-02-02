//
//  ZFGoogleAnalytics.h
//  Solgar
//
//  Created by Francesco on 02/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GANTracker.h"

@interface ZFGoogleAnalytics : NSObject <GANTrackerDelegate>

@property (nonatomic, strong) GANTracker *tracker;

- (id)initWithAccountID:(NSString *)accountID;

@end
