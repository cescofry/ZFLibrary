//
//  ZFFileSystem.h
//  RCLighting
//
//  Created by Francesco on 31/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFFileSystem : NSObject

+ (NSString *)documentDirectory;
+ (NSString *)LibraryDirectory;

+ (BOOL)createSubdirectoriesToPath:(NSString *)path;

+ (BOOL)writeData:(NSData *)data toDocsWithFileName:(NSString *)fileName;
+ (NSData *)readDataFromDocsWithFileName:(NSString *)fileName checkBundleFirst:(BOOL)chekcBundle;

+ (BOOL)writeData:(NSData *)data toDocsWithFileName:(NSString *)fileName forDirectoryType:(NSSearchPathDirectory)directory;
+ (NSData *)readDataFromDocsWithFileName:(NSString *)fileName checkBundleFirst:(BOOL)chekcBundle forDirectoryType:(NSSearchPathDirectory)directory;

@end
