//
//  ZFDataParser.h
//  Solgar
//
//  Created by Francesco on 03/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^manageData)(NSData*);

typedef enum {
    ZFDataParserTypeJSON,
    ZFDataParserTypeXML,
    ZFDataParserTypeCVS
} ZFDataParserType;

@interface ZFDataParser : NSObject

- (id)dataFromURL:(NSURL*)url ofType:(ZFDataParserType)type;
- (void)requestDataFromURL:(NSURL*)url ofType:(ZFDataParserType)type withBlock:(manageData)block;
- (id)dataFromPath:(NSString*)path ofType:(ZFDataParserType)type;

- (void)requestDataFromGoogleDocID:(NSString *)docID isFirstLineKey:(BOOL)firtLineKey withBlock:(manageData)block;


@end

