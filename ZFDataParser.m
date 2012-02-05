//
//  ZFDataParser.m
//  Solgar
//
//  Created by Francesco on 03/02/2012.
//  Copyright (c) 2012 Ziofritz.com. All rights reserved.
//

#import "ZFDataParser.h"

@implementation ZFDataParser


- (id)dataFromURL:(NSURL*)url ofType:(ZFDataParserType)type { return nil; }
- (void)requestDataFromURL:(NSURL*)url ofType:(ZFDataParserType)type withBlock:(manageData)block { return; }
- (id)dataFromPath:(NSString*)path ofType:(ZFDataParserType)type { return nil; }

- (void)requestDataFromGoogleDocID:(NSString *)docID isFirstLineKey:(BOOL)firtLineKey withBlock:(manageData)block { return; }

@end
