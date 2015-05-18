//
//  ViewController.h
//  TwitterTest
//
//  Created by Yuji Nakamura on 2015/05/15.
//  Copyright (c) 2015年 Yuji Nakamura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UIView *contentView;
    IBOutlet UITableView *contentTableView;
}

@property (nonatomic,strong) NSMutableArray *tableViewDataArray;

typedef void (^pressButtonCallBack)(int index);
/** ボタン押下時のコールバック */
@property(nonatomic, strong) pressButtonCallBack pressButtonCallBack;



@end

