//
//  ApiAccess.h
//  TwitterTest
//
//  Created by Yuji Nakamura on 2015/05/15.
//  Copyright (c) 2015年 Yuji Nakamura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiAccess : NSObject <NSURLConnectionDataDelegate>

/** アクセスURL */
@property(nonatomic, retain) NSString *accessURL;
/** リクエストパラメータ */
@property(nonatomic, retain) NSString *reqParam;
/** リクエストパラメータ(Dic) */
@property(nonatomic, retain) NSDictionary *reqParamDic;
/** HTTPステータスコード */
@property int httpStatusCode;
/** 受信したデータ格納Data */
@property(nonatomic, retain) NSMutableData *receivedData;
/** 受信したレスポンスをjsonへ変換したNSDictionary */
@property(nonatomic, retain) NSDictionary *parseJsonDic;

+ (ApiAccess *)genInstanceWithUrl:(NSString *)url;

- (void)createPostParamFromDic:(NSDictionary *)postParamDic;
- (void)startGetRequestAPI;
- (void)startPostRequestAPI;

@end
