//
//  ContentTableViewCell.h
//  TwitterTest
//
//  Created by Yuji Nakamura on 2015/05/15.
//  Copyright (c) 2015年 Yuji Nakamura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellData.h"

@interface ContentTableViewCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *twitterUserNameLabel;

- (void)setData:(CellData*)cellData;


@end
