//
//  DIEError.h
//  DressLink
//
//  Created by apple on 15/10/21.
//  Copyright © 2015年 devein. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DIENetworkErrorCode) {
    kDIENetworkErrorCodeNotFound = 1001,
    kDIENetworkErrorCodeNotAuth,
};

@interface DIEError : NSObject
@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, copy) NSString *reason;

- (instancetype)initWithCode:(NSInteger)code;
- (instancetype)initWithError:(NSError *)error;

+ (instancetype)errorWithCode:(NSInteger)code;


@end