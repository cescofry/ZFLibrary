//
//  ZFFileSystem.m
//  RCLighting
//
//  Created by Francesco on 31/01/2012.
//  Copyright (c) 2012 Fuerte International. All rights reserved.
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

+ (NSString *)libraryDirectory {
    return [ZFFileSystem pathForSearchPath:NSLibraryDirectory];
}


#pragma mark write data

+ (BOOL)writeData:(NSData *)data toDocsWithFileName:(NSString *)fileName {
    return [ZFFileSystem writeData:data toDocsWithFileName:fileName forDirectoryType:NSDocumentDirectory];
}



+ (BOOL)writeData:(NSData *)data toDocsWithFileName:(NSString *)fileName forDirectoryType:(NSSearchPathDirectory)directory {
    NSString *filePath = [[ZFFileSystem pathForSearchPath:directory] stringByAppendingPathComponent:fileName];
    NSDictionary *attr = nil;
    NSError *error = nil;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:[filePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:attr error:&error];
    success = [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:attr];
    return success;    
}


#pragma mark read data

+ (NSData *)readDataFromDocsWithFileName:(NSString *)fileName checkBundleFirst:(BOOL)chekcBundle {
    return [ZFFileSystem readDataFromDocsWithFileName:fileName checkBundleFirst:chekcBundle forDirectoryType:NSDocumentDirectory];
}

+ (NSData *)readDataFromDocsWithFileName:(NSString *)fileName checkBundleFirst:(BOOL)chekcBundle forDirectoryType:(NSSearchPathDirectory)directory {
    NSString *filePath = [self pathForFileName:fileName checkBundleFirst:chekcBundle forDirectoryType:directory];
    return [NSData dataWithContentsOfFile:filePath];   
}

#pragma mark paths

+ (NSString *)pathForFileName:(NSString *)fileName checkBundleFirst:(BOOL)chekcBundle forDirectoryType:(NSSearchPathDirectory)directory {
    NSString *filePath = [[NSString alloc] init];
    if (chekcBundle) {
        NSString *onlyFile = [fileName lastPathComponent];
        NSString *ext = [onlyFile pathExtension];
        NSString *name = [onlyFile stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@", ext] withString:@""];
        filePath = [[NSBundle mainBundle] pathForResource:name ofType:ext];
        
    }
    if (!filePath) {
        filePath = [NSString stringWithString:[[ZFFileSystem pathForSearchPath:directory] stringByAppendingPathComponent:fileName]];
    }
    return filePath;  
}



@end
