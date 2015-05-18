//
//  ContentTableViewCell.m
//  TwitterTest
//
//  Created by Yuji Nakamura on 2015/05/15.
//  Copyright (c) 2015年 Yuji Nakamura. All rights reserved.
//

#import "ContentTableViewCell.h"

@implementation ContentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setData:(CellData*)cellData {
    self.twitterUserNameLabel.text = cellData.twitterUserName;
}


@end
