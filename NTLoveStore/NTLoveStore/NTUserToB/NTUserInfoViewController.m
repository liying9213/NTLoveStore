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
//    [self getTheListData];
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
                [self showEndViewWithText:@"网络请求失败！"];
            }
        }
    }];
    dic=nil;
}

- (void)saveTheOrderWithdata:(NSString*)ids{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    [self showWaitingViewWithText:nil];
    __weak typeof(self) __weakself=self;
//    订单保存是gorder 参数 uid token  ids

    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"ids":ids};
    [NTAsynService requestWithHead:saveOrderBaseUR WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self hideWaitingView];
        }
        else{
            __strong typeof(self) self=__weakself;
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
            }
            else{
                [self showEndViewWithText:@"网络请求失败！"];
            }
        }
    }];
    dic=nil;
}

- (void)finishTheOrder:(NSString *)orderID{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    [self showWaitingViewWithText:nil];
    __weak typeof(self) __weakself=self;
    //    订单完成是worder  参数 uid token orderid
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"orderid":orderID};
    [NTAsynService requestWithHead:finishOrderBaseUR WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self hideWaitingView];
        }
        else{
            __strong typeof(self) self=__weakself;
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
            }
            else{
                [self showEndViewWithText:@"网络请求失败！"];
            }
        }
    }];
    dic=nil;
}

- (void)delTheOrder:(NSString *)orderID{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    [self showWaitingViewWithText:nil];
    __weak typeof(self) __weakself=self;

    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken]};
    [NTAsynService requestWithHead:delOrderBaseUR WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self hideWaitingView];
        }
        else{
            __strong typeof(self) self=__weakself;
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
            }
            else{
                [self showEndViewWithText:@"网络请求失败！"];
            }
        }
    }];
    dic=nil;
}

#pragma mark - resetView

- (void)resetViewWithType:(NSInteger)type withData:(id)listData{
    if (type==0||type==1||type==2||type==3) {
//        _listView.listAry=[listData allValues];
        if (_isFollow) {
            _listView.hidden=YES;
            if (!_followListView) {
                [self resetFollowListView];
            }
            _followListView.followListAry=listData;
            _followListView.isSelect=NO;
            [_followListView.tableView reloadData];
            _followListView.hidden=NO;
        }
        else{
            _followListView.hidden=YES;
            if (!_listView) {
                [self resetListView];
            }
            _listView.listAry=listData;
            _listView.isSelect=NO;
            [_listView.tableView reloadData];
            _listView.hidden=NO;
        }
    }
}

- (void)resetView{
    [self resetListView];
}

- (void)resetListView{
    NSArray *ary=@[
                   @{@"id":@"100",
                     @"orderid":@"E616698396244850355",
                     @"create_time":@"2015-09-09 12:01:01",
                     @"pricetotal":@"100.0",
                     @"send_name":@"张三",
                     @"send_contact":@"135576786",
                     @"time":@"2015-09-09"},
                   @{@"id":@"100",
                     @"orderid":@"E616698396244850355",
                     @"create_time":@"2015-09-09 12:01:01",
                     @"pricetotal":@"100.0",
                     @"send_name":@"张三",
                     @"send_contact":@"135576786",
                     @"time":@"2015-09-09"},
                   @{@"id":@"100",
                     @"orderid":@"E616698396244850355",
                     @"create_time":@"2015-09-09 12:01:01",
                     @"pricetotal":@"100.0",
                     @"send_name":@"张三",
                     @"send_contact":@"135576786",
                     @"time":@"2015-09-09"}];
    if (!_listView) {
        _listView=[[NTListView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_rightContentView.frame), CGRectGetHeight(_rightContentView.frame))];
        _listView.delegate=self;
        [_listView resetView];
         _listView.listAry=ary;
        [_rightContentView  addSubview:_listView];
        _listView.hidden=NO;
    }
    else{
        _listView.hidden=!_listView.hidden;
    }
}

- (void)resetFollowListView{
    if (!_followListView) {
        _followListView=[[NTFollowListView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_rightContentView.frame), CGRectGetHeight(_rightContentView.frame))];
        _followListView.delegate=self;
        [_followListView resetView];
        [_rightContentView  addSubview:_followListView];
        _followListView.hidden=NO;
    }
    else{
        _followListView.hidden=!_followListView.hidden;
    }
}

- (void)resetNomalView{
    _listView.hidden=YES;
    _followListView.hidden=YES;
    if (!_normalView) {
        _normalView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_rightContentView.frame), CGRectGetHeight(_rightContentView.frame))];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
        label.text=@"正在完善...";
        [_normalView addSubview:label];
        [_rightContentView  addSubview:_normalView];
    }
    _rightContentView.hidden=NO;
}

#pragma mark - LeftTableViewDelegate

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
        switch (indexPath.row) {
            case 0:
            {
                _isFollow=NO;
//                [self getTheListData];
                [self selectAction:nil];
                _normalView.hidden=YES;
            }
                break;
            case 1:
            {
                _isFollow=YES;
                _selectType=2;
//                [self getTheListData];
                [self selectAction:nil];
                _normalView.hidden=YES;
            }
                break;
            case 2:
            {
                [self resetNomalView];
            }
                break;
            case 3:
            {
                [self resetNomalView];
            }
                break;
            case 4:
            {
                [self resetNomalView];
            }
                break;
            default:
                break;
        }
    }
}


#pragma mark listViewDelegate

- (void)selectAction:(id)sender{
    UIButton *btn=(id)sender;
    _selectType=btn.tag;
    //    [self getTheListData];
    NSArray *ary=@[
                   @{@"id":@"100",
                     @"orderid":@"E616698396244850355",
                     @"create_time":@"2015-09-09 12:01:01",
                     @"pricetotal":@"100.0",
                     @"send_name":[NSString stringWithFormat:@"张三%ld",(long)_selectType],
                     @"send_contact":@"135576786",
                     @"time":@"2015-09-09"},
                   @{@"id":@"100",
                     @"orderid":@"E616698396244850355",
                     @"create_time":@"2015-09-09 12:01:01",
                     @"pricetotal":@"100.0",
                     @"send_name":@"张三1",
                     @"send_contact":@"135576786",
                     @"time":@"2015-09-09"},
                   @{@"id":@"100",
                     @"orderid":@"E616698396244850355",
                     @"create_time":@"2015-09-09 12:01:01",
                     @"pricetotal":@"100.0",
                     @"send_name":@"张三1",
                     @"send_contact":@"135576786",
                     @"time":@"2015-09-09"}];
    
    [self resetViewWithType:_selectType withData:ary];
}

- (void)getTheContentWithOrderid:(NSString *)orderID{
    [self reloadTheListViewWithData:nil];
    return;
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
                [self showEndViewWithText:@"网络请求失败！"];
            }
        }
    }];
    dic=nil;
}

- (void)reloadTheListViewWithData:(id)data{
    NSDictionary *dic=@{
                        @"100":@{@"goodid":@"手捧花",@"num":@"13",@"price":@"100",@"status":@"1"},
                        @"101":@{@"goodid":@"手捧花",@"num":@"13",@"price":@"100",@"status":@"1"},
                        @"102":@{@"goodid":@"手捧花",@"num":@"13",@"price":@"100",@"status":@"2"},
                        @"103":@{@"goodid":@"手捧花",@"num":@"13",@"price":@"100",@"status":@"2"},
                        @"104":@{@"goodid":@"手捧花",@"num":@"13",@"price":@"100",@"status":@"2"}};
    if (_isFollow) {
        if (_followListView) {
            _followListView.contentListAry=[dic allValues];
            [_followListView.tableView reloadData];
        }
    }
    else{
        if (_listView) {
            _listView.contentListAry=[dic allValues];
            [_listView.tableView reloadData];
        }
    }
    
    
    
}

- (void)showCodeImage:(id)seder{
    UIButton *btn=(UIButton *)seder;
    UIViewController *viewcontroller=[[UIViewController alloc] init];
    UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageview.image=[UIImage imageNamed:@"code"];
    [viewcontroller.view addSubview:imageview];
    UIPopoverController* _popoverView=[[UIPopoverController alloc] initWithContentViewController:viewcontroller];
    _popoverView.popoverContentSize = CGSizeMake(100, 100);
    _popoverView.delegate=self;
    [_popoverView presentPopoverFromRect:btn.bounds inView:btn permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (void)saveAction:(id)sender{
    [self saveTheOrderWithdata:sender];
}

- (void)finishAction:(id)sender{
    [self finishTheOrder:sender];
}

@end
