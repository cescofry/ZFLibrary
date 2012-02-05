//
//  ZFGoogleSpreadSheatRequest.h
//  AsiaEtrading
//
//  Created by cescofry on 27/08/2011.
//  Copyright 2011 Ziofritz.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFGoogleSpreadSheatRequest : NSObject {
    BOOL _containKeys;
    NSString *_authUsername;
    NSString *_authPassword;
}

@property (nonatomic, assign) BOOL containKeys;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;


- (NSArray *)arrayFromDocumentKey:(NSString *)key;
- (NSArray *)arrayFromFilePath:(NSString *)filePath;



@end
