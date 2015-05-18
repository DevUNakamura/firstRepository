//
//  ApiAccessManager.h
//  TwitterTest
//
//  Created by Yuji Nakamura on 2015/05/15.
//  Copyright (c) 2015年 Yuji Nakamura. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiAccess.h"

@interface ApiAccessManager : NSObject

+ (ApiAccessManager *)sharedInstance;

typedef void (^CompleateDataCallback)(ApiAccess *apiAccess);

- (void)apiAccessUrl:(CompleateDataCallback)callback;


@end
