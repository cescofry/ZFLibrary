//
//  ZFFileSystem.m
//  RCLighting
//
//  Created by Francesco on 31/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ZFFileSystem.h"

@implementation ZFFileSystem

#pragma mark get directory path

+ (NSString *)pathForSearchPath:(NSSearchPathDirectory)directory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)documentDirectory {
    return [ZFFileSystem pathForSearchPath:NSDocumentDirectory];
}

+ (NSString *)LibraryDirectory {
    return [ZFFileSystem pathForSearchPath:NSLibraryDirectory];
}


#pragma mark write data

+ (BOOL)writeData:(NSData *)data toDocsWithFileName:(NSString *)fileName {
    return [ZFFileSystem writeData:data toDocsWithFileName:fileName forDirectoryType:NSDocumentDirectory];
}



+ (BOOL)writeData:(NSData *)data toDocsWithFileName:(NSString *)fileName forDirectoryType:(NSSearchPathDirectory)directory {
    NSString *filePath = [[ZFFileSystem pathForSearchPath:directory] stringByAppendingPathComponent:fileName];
    NSURL *url = [NSURL URLWithString:filePath];
    BOOL success;
    if (!url) {
        success = [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
    }
    else {
        success = [data writeToFile:filePath atomically:YES];
    }
    return success;    
}


#pragma mark read data

+ (NSData *)readDataFromDocsWithFileName:(NSString *)fileName checkBundleFirst:(BOOL)chekcBundle {
    return [ZFFileSystem readDataFromDocsWithFileName:fileName checkBundleFirst:chekcBundle forDirectoryType:NSDocumentDirectory];
}

+ (NSData *)readDataFromDocsWithFileName:(NSString *)fileName checkBundleFirst:(BOOL)chekcBundle forDirectoryType:(NSSearchPathDirectory)directory {
    NSString *filePath;
    if (chekcBundle) {
        NSString *ext = [fileName pathExtension];
        NSString *name = [fileName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@", fileName] withString:@""];
        filePath = [[NSBundle mainBundle] pathForResource:name ofType:ext];
        
    }
    if (!filePath) {
        filePath = [[ZFFileSystem pathForSearchPath:directory] stringByAppendingPathComponent:fileName];
    }
    return [NSData dataWithContentsOfFile:filePath];   
}



@end
