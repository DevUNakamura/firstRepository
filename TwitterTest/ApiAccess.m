//
//  ApiAccess.m
//  TwitterTest
//
//  Created by Yuji Nakamura on 2015/05/15.
//  Copyright (c) 2015年 Yuji Nakamura. All rights reserved.
//

#import "ApiAccess.h"

@implementation ApiAccess


/**
 *  URLを設定して初期化
 *
 *  @param url URL
 *
 *  @return APIAccessインスタンス
 */
+ (ApiAccess *)genInstanceWithUrl:(NSString *)url
{
    ApiAccess *apiAccess = [[ApiAccess alloc] init];
    apiAccess.accessURL = url;
    return apiAccess;
}

/**
 *  postパラメータを生成
 *
 *  @param postParamDic post用パラメータを格納したディクショナリ
 */
- (void)createPostParamFromDic:(NSDictionary *)paramDic
{
    self.reqParamDic = paramDic;
    self.reqParam = @"";
    NSArray *keyArray = [paramDic allKeys];
    NSArray *valueArray = [paramDic allValues];
    for (int i = 0; i < keyArray.count; i++) {
        NSString *key = [keyArray objectAtIndex:i];
        NSString *value = [valueArray objectAtIndex:i];
        self.reqParam =
        [NSString stringWithFormat:@"%@%@", self.reqParam, [NSString stringWithFormat:@"%@=%@&", key, value]];
    }
    int postParamLength = (int)[self.reqParam length];
    if (postParamLength != 0) {
        self.reqParam = [self.reqParam substringToIndex:(postParamLength - 1)];
    }
}

/**
 *  http GETリクエストを開始
 */
- (void)startGetRequestAPI
{
    if (self.reqParam) {
        self.accessURL = [NSString stringWithFormat:@"%@?%@", self.accessURL, self.reqParam];
    }
    [self startRequestAPI:@"GET" bodyParam:self.reqParam];
}

/**
 *  http POSTリクエストを開始
 */
- (void)startPostRequestAPI
{
    [self startRequestAPI:@"POST" bodyParam:self.reqParam];
}

/**
 *  httpリクエストの開始
 *
 *  @param method    リクエストタイプ
 *  @param bodyParam 付与パラメータ
 */
- (void)startRequestAPI:(NSString *)method bodyParam:(NSString *)bodyParam
{
    self.receivedData = [NSMutableData data];
    NSURL *url = [NSURL URLWithString:self.accessURL];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:url];
    [req setHTTPMethod:method];
    [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    if (![method isEqualToString:@"GET"]) {
        [req setHTTPBody:[bodyParam dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [NSURLConnection connectionWithRequest:req delegate:self];
    [[NSRunLoop currentRunLoop] run];
}

/**
 *  サーバからレスポンスが送られてきたときのデリゲート
 *
 *  @param connection NSURLConnection
 *  @param response   レスポンス
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    self.httpStatusCode = (int)httpResponse.statusCode;
    [self.receivedData setLength:0];
}

/**
 *  サーバからデータが送られてきたときのデリゲート
 *
 *  @param connection NSURLConnection
 *  @param data       受信したデータ
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

/**
 *  サーバからエラーが返されたときのデリゲート
 *
 *  @param connection NSURLConnection
 *  @param error      エラー情報
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
}

/**
 *  データのロードが完了した時のデリゲート
 *
 *  @param connection NSURLConnection
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *connectFinishResponse =
    [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"connectFinishResponse = %@",connectFinishResponse);
    
    NSError *error;
    self.parseJsonDic = [NSJSONSerialization JSONObjectWithData:[connectFinishResponse dataUsingEncoding:NSUTF8StringEncoding]
                                    options:0
                                      error:&error];
}

/**
 *  データの進捗を伝えるためのデリゲートメソッド
 *
 *  @param connection                NSURLConnection
 *  @param bytesWritten              受信するデータ
 *  @param totalBytesWritten         受信するデータの合計
 *  @param totalBytesExpectedToWrite totalBytesExpectedToWrite
 */
- (void)connection:(NSURLConnection *)connection
   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
}


@end
