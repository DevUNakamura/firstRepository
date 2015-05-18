//
//  CellData.h
//  TwitterTest
//
//  Created by Yuji Nakamura on 2015/05/15.
//  Copyright (c) 2015年 Yuji Nakamura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellData : NSObject

/** ツイッターID */
@property (nonatomic,retain) NSString *twitterID;
/** ツイッター　ユーザー名 */
@property (nonatomic,retain) NSString *twitterUserName;

+ (CellData*)initializeCellDataWithId:(int)value;

@end
