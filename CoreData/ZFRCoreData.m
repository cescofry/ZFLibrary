//
//  Created by Francesco Frison on 4/16/14.
//  Copyright (c) 2014 Ziofritz. All rights reserved.
//

#import "ZFRCoreData.h"
#import <CoreData/CoreData.h>


static NSString * const __databaseName = @"Database.sqlite";
static NSString * const __databaseNameTest = @"TestDatabase.sqlite";
static NSString * const __managedObjectModelName = @"ModelName";

@implementation ZFRCoreData


@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark --
#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

/**
 Returns the managed object model for the application.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:__managedObjectModelName withExtension:@"momd"];
    if (!modelURL) modelURL = [[NSBundle mainBundle] URLForResource:__managedObjectModelName withExtension:@"mom"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSString *dbName = __databaseName;
    
#ifdef TEST
    dbName = __databaseNameTest;
#endif
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:dbName];
    
    NSError *error = nil;
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
    {
        
        NSLog(@"Unresolved error %@, %@\n\n", error, [error userInfo]);
        //abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *aManagedObjectContext = self.managedObjectContext;
    if (aManagedObjectContext != nil)
    {
        BOOL isChanged = [aManagedObjectContext hasChanges];
        if (isChanged && ![aManagedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@\n\n", error, [error userInfo]);
            //abort();
        }
    }
}

@end