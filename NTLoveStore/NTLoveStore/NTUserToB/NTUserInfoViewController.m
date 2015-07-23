//
//  NTUserInfoViewController.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/23.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTUserInfoViewController.h"
#import "NTLeftTableViewCell.h"
#import "NTListView.h"
@interface NTUserInfoViewController ()

@end

@implementation NTUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _leftAry=@[@{@"title":@"订单查询"},
               @{@"title":@"服务跟踪"},
               @{@"title":@"资料库"},
               @{@"title":@"婚会客服"},
               @{@"title":@"客户评价"}];
    
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self resetListView];
}

#pragma mark - getData

- (void)getTheListData{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    [self showWaitingViewWithText:nil];
    __weak typeof(self) __weakself=self;
    NSString *headStr;
    switch (_selectType) {
        case 0:
        {
            headStr=allOrderBaseUR;
        }
            break;
        case 1:
        {
            headStr=finOrderBaseUR;
        }
            break;
        case 2:
        {
            headStr=outOrderBaseUR;
        }
            break;
        case 3:
        {
            headStr=payOrderBaseUR;
        }
            break;
            
        default:
            break;
    }
    
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken]};
    [NTAsynService requestWithHead:headStr WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self resetViewWithType:_selectType withData:finishData];
            [self hideWaitingView];
        }
        else{
            __strong typeof(self) self=__weakself;
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
            }
            else{
                [self showEndViewWithText:@"网路请求失败！"];
            }
        }
    }];
    dic=nil;
}

- (void)resetViewWithType:(NSInteger)type withData:(id)listData{
    if (type==0||type==1||type==2||type==3) {
        _listView.listAry=[listData allValues];
        _listView.isSelect=NO;
        [_listView.tableView reloadData];
    }
}

- (void)resetView{
    [self resetListView];
}

- (void)resetListView{
    if (!_listView) {
        _listView=[[NTListView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_rightContentView.frame), CGRectGetHeight(_rightContentView.frame))];
        [_listView resetView];
        [_rightContentView  addSubview:_listView];
        _listView.hidden=NO;
    }
    else{
        _listView.hidden=!_listView.hidden;
    }
}

#pragma mark listViewDelegate

- (void)selectAction:(id)sender{
    UIButton *btn=(id)sender;
    _selectType=btn.tag;
    [self getTheListData];
}

- (void)getTheContentWithOrderid:(NSString *)orderID{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    [self showWaitingViewWithText:nil];
    __weak typeof(self) __weakself=self;
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"orderid":orderID};
    [NTAsynService requestWithHead:getodBaseUR WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self reloadTheListViewWithData:finishData];
            [self hideWaitingView];
        }
        else{
            __strong typeof(self) self=__weakself;
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
            }
            else{
                [self showEndViewWithText:@"网路请求失败！"];
            }
        }
    }];
    dic=nil;
}

- (void)reloadTheListViewWithData:(id)data{
    if (_listView) {
        _listView.contentListAry=[data allValues];
        [_listView.tableView reloadData];
    }
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==1) {
        return 5;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * _cellIdentify = @"cell";
    if (tableView.tag==1) {
        NTLeftTableViewCell * iCell = [tableView dequeueReusableCellWithIdentifier:_cellIdentify];
        if (iCell == nil){
            iCell=[[NTLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellIdentify];
        }
        [iCell reloadTheTableCellWithData:[_leftAry objectAtIndex:indexPath.row]];
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        return iCell;
    }
    else
        return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==1) {
        
    }
}


@end
