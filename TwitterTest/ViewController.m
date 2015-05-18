//
//  ViewController.m
//  TwitterTest
//
//  Created by Yuji Nakamura on 2015/05/15.
//  Copyright (c) 2015年 Yuji Nakamura. All rights reserved.
//

#import "ViewController.h"
#import "CellData.h"
#import "ContentTableViewCell.h"
#import "ApiAccessManager.h"
#import "LoadingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setPressCellEvent];
    
    [self startAccessApi];
    
}

- (void)setPressCellEvent {
    __weak ViewController *weakSelf = self;
    [self setPressButtonCallBack:^(int cellIndex){
        CellData *selectCellData = [weakSelf.tableViewDataArray objectAtIndex:cellIndex];
        NSLog(@"ユーザー名 = %@",selectCellData.twitterUserName);
    }];

}

- (void)startAccessApi {
    LoadingView *loadingView = [LoadingView initWithShow:self.view];
    ApiAccessManager *apiAccessManager = [ApiAccessManager sharedInstance];
    [apiAccessManager apiAccessUrl:^(ApiAccess *apiAccess) {
        [loadingView hideLoadingView];
        [loadingView setHideAnimationEndCallBack:^() {
            NSLog(@"apiAccess.accessURL = %@",apiAccess.accessURL);
            NSLog(@"apiAccess.httpStatusCode = %d",apiAccess.httpStatusCode);
            NSLog(@"apiAccess.parseJsonDic = %@",apiAccess.parseJsonDic);
            
            [self startCreateDataTask];
        }];
    }];
}

- (void)startCreateDataTask {
    self.tableViewDataArray = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        [self.tableViewDataArray addObject:[CellData initializeCellDataWithId:i]];
    }
    [contentTableView reloadData];
}

- (IBAction)pressCellButton:(UIButton*)button {
    UITableViewCell *cell = [self seachTableViewCell:button];
    int indexRow = (int)[contentTableView indexPathForCell:cell].row;
    if (self.pressButtonCallBack) {
        self.pressButtonCallBack(indexRow);
    }
}

- (UITableViewCell *)seachTableViewCell:(UIView *)view
{
    id target = [view superview];
    if (!target) {
        return nil;
    }
    if ([target isKindOfClass:[UITableViewCell class]]) {
        return target;
    }
    return [self seachTableViewCell:target];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  TableView Delagate<br/>
 *  セクション数の設定
 *
 *  @param tableView TableViewインスタンス
 *
 *  @return セクション数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 *  TableView Delagate<br/>
 *  ロー数の設定
 *
 *  @param tableView TableViewインスタンス
 *  @param section   セクション
 *
 *  @return ロー数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewDataArray.count;
}

/**
 *  TableView Delagate<br/>
 *  セルの高さを設定
 *
 *  @param tableView TableViewインスタンス
 *  @param indexPath index情報
 *
 *  @return セルの高さ
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

/**
 *  TableView Delagate<br/>
 *  Cellの生成時に呼び出し
 *
 *  @param tableView TableViewインスタンス
 *  @param indexPath index情報
 *
 *  @return 生成したCellインスタンス
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellData *dispCellData = [self.tableViewDataArray objectAtIndex:indexPath.row];
    static NSString *TableCellID = @"ContentTableViewCell";
    ContentTableViewCell *cell = (ContentTableViewCell *)[contentTableView dequeueReusableCellWithIdentifier:TableCellID];
    [cell setData:dispCellData];
    return cell;
}


@end
