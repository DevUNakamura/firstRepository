//
//  ApiAccessManager.m
//  TwitterTest
//
//  Created by Yuji Nakamura on 2015/05/15.
//  Copyright (c) 2015年 Yuji Nakamura. All rights reserved.
//

#import "ApiAccessManager.h"
#import "ApiAccess.h"

#define API_URL @"http://localHost/test.php"

@implementation ApiAccessManager

static ApiAccessManager *apiAccessManager = nil;

/**
 *  Managerの初期化処理
 *
 *  @return DataManagerインスタンス
 */
+ (ApiAccessManager *)sharedInstance
{
    @synchronized(self)
    {
        if (apiAccessManager == nil) {
            apiAccessManager = [[self alloc] init];
        }
    }
    return apiAccessManager;
}

/**
 *  利用規約Apiへアクセス
 *
 *  @param callback 通信後コールバック処理
 */
- (void)apiAccessUrl:(CompleateDataCallback)callback
{
    dispatch_async(dispatch_queue_create("sub_thread", 0), ^{
        ApiAccess *apiAccess = [ApiAccess genInstanceWithUrl:API_URL];
        [apiAccess startGetRequestAPI];
        //メインスレッド復帰後処理
        dispatch_async(dispatch_get_main_queue(), ^{
            if (callback) {
                callback(apiAccess);
            }
        });
    });

}





@end
