//
//  ZFFileSystem.m
//  RCLighting
//
//  Created by Francesco on 31/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ZFFileSystem.h"

@implementation ZFFileSystem

+ (NSString *)documentDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (BOOL)writeData:(NSData *)data toDocsWithFileName:(NSString *)fileName {
    NSString *filePath = [[ZFFileSystem documentDirectory] stringByAppendingPathComponent:fileName];
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

+ (NSData *)readDataFromDocsWithFileName:(NSString *)fileName checkBundleFirst:(BOOL)chekcBundle {
    NSString *filePath;
    if (chekcBundle) {
        NSString *ext = [fileName pathExtension];
        NSString *name = [fileName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@", fileName] withString:@""];
        filePath = [[NSBundle mainBundle] pathForResource:name ofType:ext];
        
    }
    if (!filePath) filePath = [[ZFFileSystem documentDirectory] stringByAppendingPathComponent:fileName];
    return [NSData dataWithContentsOfFile:filePath];
}



@end
