//
//  Created by Francesco Frison on 4/16/14.
//  Copyright (c) 2014 Ziofritz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFRCoreData : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
