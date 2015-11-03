//
//  DIENetworkManager.h
//  DressLink
//
//  Created by apple on 15/10/22.
//  Copyright © 2015年 devein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DIEError.h"

typedef void(^CompletionType)(id responseObject, DIEError *error);
@interface DIENetworkManager : NSObject


@end

