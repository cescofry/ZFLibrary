//
//  ZFGoogleSpreadSheatRequest.m
//  AsiaEtrading
//
//  Created by cescofry on 27/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ZFGoogleSpreadSheatRequest.h"
#import "CHCSV.h"
#import "CHCSVParser.h"
#import "NSArray+CHCSVAdditions.h"

@implementation ZFGoogleSpreadSheatRequest

@synthesize containKeys = _containKeys;
@synthesize authUsername = _authUsername;
@synthesize authPassword = _authPassword;

- (id)init {
    self = [super init];
    if (self) {
        self.containKeys = YES;
        self.authUsername = @"";
        self.authPassword = @"";
    }
    
    return self;
}


- (NSArray *)convertResult:(NSArray *)result {
    NSArray *keys = nil;
    NSMutableArray *processed = [NSMutableArray array];
    int count = 0;
    
    for (NSArray *line in result) {
        //setUp keys
        if (!keys) {
            keys = line;
            continue;
        }
        else {
            count ++;
            if ([keys count] != [line count]) {
                if ([line count] == 0) continue;
                NSLog(@"line n' %d {%@ : %@} doesn't match keys structure", count, [keys objectAtIndex:0], [line objectAtIndex:0]);
                continue;
            }
            NSDictionary *dict = [NSDictionary dictionaryWithObjects:line forKeys:keys];
            [processed addObject:dict];
        }
    }
    
    return processed;
}

- (NSArray *)arrayFromDocumentKey:(NSString *)key {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://docs.google.com/spreadsheet/ccc?key=%@&hl=en_US&output=csv#gid=0", key]];
    NSError *error = nil;
    NSString *stringData = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"ZFGoogleSpreadSheatRequest: %@", [error description]);
        return [NSArray array];
    }
    NSArray *result = [NSArray arrayWithContentsOfCSVString:stringData encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"ZFGoogleSpreadSheatRequest: %@", [error description]);
    }
    
    return (self.containKeys)? [self convertResult:result] : result;
    
}

- (NSArray *)arrayFromFilePath:(NSString *)filePath {
    NSError *error = nil;
    NSArray *result = [NSArray arrayWithContentsOfCSVFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"ZFGoogleSpreadSheatRequest: %@", [error description]);
    }
    
    return (self.containKeys)? [self convertResult:result] : result;
}


@end
