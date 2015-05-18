//
//  CellData.m
//  TwitterTest
//
//  Created by Yuji Nakamura on 2015/05/15.
//  Copyright (c) 2015年 Yuji Nakamura. All rights reserved.
//

#import "CellData.h"

@implementation CellData

+ (CellData*)initializeCellDataWithId:(int)value {
    CellData *cellData = [[CellData alloc]init];
    [cellData setTwitterID:[NSString stringWithFormat:@"%d",value]];
    [cellData setTwitterUserName:[NSString stringWithFormat:@"ユーザー名%d",value]];
    return cellData;
}


@end
