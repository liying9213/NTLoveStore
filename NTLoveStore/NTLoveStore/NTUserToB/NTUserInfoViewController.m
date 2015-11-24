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
    self.isShowLogo=YES;
    [super viewDidLoad];
    NSArray *ary=@[@{@"title":@"首页",@"name":@"首页",@"id":@"1"},@{@"title":@"个人中心",@"name":@"个人中心",@"id":@"2"},@{@"title":@"策划助理",@"name":@"策划助理",@"id":@"3"}];
    [self resetHeadSelectView:ary];
    _leftAry=@[@{@"title":@"订单查询"},
               @{@"title":@"服务跟踪"},
               @{@"title":@"资料库"},
               @{@"title":@"婚会客服"},
               @{@"title":@"客户评价"}];
    
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
    _selectType=0;
    [self getTheListData];
}

- (void)resetHeadSelectView:(NSArray *)ary{
    _headSelectView=[[NTHeadSelectView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    _headSelectView.selectData=ary;
    _headSelectView.delegate=self;
    _headSelectView.selectTag=2;
    [_headSelectView creatHeadSelectView];
    [self.view addSubview:_headSelectView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self resetListView];
}

#pragma mark - headSelectViewDelegate

- (void)headSelectAction:(id)sender{
    UIButton *btn=(UIButton *)sender;
    if (btn.tag==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (btn.tag==2) {
        
    }
    else if (btn.tag==3) {
        [self resetNomalView];
    }
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
            headStr=allOrderBaseURL;
        }
            break;
        case 1:
        {
            headStr=finOrderBaseURL;
        }
            break;
        case 2:
        {
            headStr=outOrderBaseURL;
        }
            break;
        case 3:
        {
            headStr=payOrderBaseURL;
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
           [self resetViewWithType:_selectType withData: [self getTheValuesWithKey:[[finishData allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] withData:finishData]];
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
            [self resetViewWithType:_selectType withData: [self getTheValuesWithKey:[[finishData allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] withData:finishData]];
        }
    }];
    dic=nil;
}

- (void)saveTheOrderWithdata:(NSMutableDictionary*)dic{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    [self showWaitingViewWithText:nil];
    __weak typeof(self) __weakself=self;
//    订单保存是gorder 参数 uid token  ids

//    NSDictionary *dic=@{@"uid":[share()userUid],
//                        @"token":[share()userToken],
//                        @"ids":ids};
    [dic setObject:[share()userUid] forKey:@"uid"];
    [dic setObject:[share()userToken] forKey:@"token"];
    [NTAsynService requestWithHead:saveOrderBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self showEndViewWithText:@"保存成功"];
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
    [NTAsynService requestWithHead:finishOrderBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self showEndViewWithText:@"订单已完成！"];
            _isFollow=YES;
            _isComment=NO;
            _selectType=2;
            [self getTheListData];
            _normalView.hidden=YES;
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
                        @"token":[share()userToken],
                        @"orderid":orderID};
    [NTAsynService requestWithHead:delOrderBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
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
        if (_isFollow) {
            _listView.hidden=YES;
            _commentView.hidden=YES;
            if (!_followListView) {
                [self resetFollowListView];
            }
            _followListView.followListAry=listData;
            if (_followListView.followListAry&&_followListView.followListAry.count>0) {
                _followListView.tableView.backgroundView.hidden= YES;
            }
            else
                _followListView.tableView.backgroundView.hidden= NO;
            _followListView.isSelect=NO;
            [_followListView.tableView reloadData];
            _followListView.hidden=NO;
        }
        else if (_isComment) {
            _listView.hidden=YES;
            _followListView.hidden=YES;
            if (!_commentView) {
                [self resetCommentView];
            }
            _commentView.listAry=listData;
            if (_commentView.listAry&&_commentView.listAry.count>0) {
                _commentView.tableView.backgroundView.hidden= YES;
            }
            else
                _commentView.tableView.backgroundView.hidden= NO;
            _commentView.isSelect=NO;
            [_commentView.tableView reloadData];
            _commentView.hidden=NO;
        }
        else if(!_isFollow&&!_isComment){
            _followListView.hidden=YES;
            _commentView.hidden=YES;
            if (!_listView) {
                [self resetListView];
            }
            _listView.listAry=listData;
            if (_listView.listAry&&_listView.listAry.count>0) {
                _listView.tableView.backgroundView.hidden= YES;
            }
            else
                _listView.tableView.backgroundView.hidden= NO;
            _listView.isSelect=NO;
            [_listView.tableView reloadData];
            _listView.hidden=NO;
        }
    }
}

- (void)resetListView{
    if (!_listView) {
        _listView=[[NTListView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_rightContentView.frame), CGRectGetHeight(_rightContentView.frame))];
        _listView.delegate=self;
        [_listView resetView];
        [_rightContentView  addSubview:_listView];
        _listView.hidden=NO;
    }
    else{
        _listView.hidden=!_listView.hidden;
    }
}

- (void)resetCommentView{
    if (!_commentView) {
        _commentView=[[NTCommentView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_rightContentView.frame), CGRectGetHeight(_rightContentView.frame))];
        _commentView.delegate=self;
        [_commentView resetView];
        [_rightContentView  addSubview:_commentView];
        _commentView.hidden=NO;
    }
    else{
        _commentView.hidden=!_commentView.hidden;
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
    _normalView.hidden=NO;
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
                _selectType=0;
                _isFollow=NO;
                _isComment=NO;
//                [self getTheListData];
                [_listView selectAction:_listView.allOrderBtn];
                _normalView.hidden=YES;
            }
                break;
            case 1:
            {
                _isFollow=YES;
                _isComment=NO;
                _selectType=2;
                [self getTheListData];
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
                _isFollow=NO;
                _isComment=YES;
                _selectType=1;
                [self getTheListData];
                _normalView.hidden=YES;
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
    [NTAsynService requestWithHead:getodBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self reloadTheListViewWithData:[self getTheValuesWithKey:[[finishData allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] withData:finishData]];
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
        finishData=nil;
    }];
    dic=nil;
}

- (void)reloadTheListViewWithData:(id)data{
    if (_isFollow) {
        if (_followListView) {
            _followListView.contentListAry=data;
            [_followListView.tableView reloadData];
        }
    }
    else{
        if (_listView) {
            _listView.contentListAry=data;
            [_listView.tableView reloadData];
        }
    }
}

- (void)showCodeImage:(id)seder{
    UIButton *btn=(UIButton *)seder;
    UIViewController *viewcontroller=[[UIViewController alloc] init];
    UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    imageview.image=[UIImage imageNamed:@"code"];
    [viewcontroller.view addSubview:imageview];
    UIPopoverController* _popoverView=[[UIPopoverController alloc] initWithContentViewController:viewcontroller];
    _popoverView.popoverContentSize = CGSizeMake(120, 120);
    _popoverView.delegate=self;
    [_popoverView presentPopoverFromRect:btn.bounds inView:btn permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (void)saveAction:(id)sender{
    [self saveTheOrderWithdata:sender];
}

- (void)finishAction:(id)sender{
    [self finishTheOrder:sender];
}

- (void)saveCommentAction:(id)sender{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    [self showWaitingViewWithText:nil];
    __weak typeof(self) __weakself=self;
    NSMutableDictionary *dic=(NSMutableDictionary *)sender;
    [dic setValue:[share()userUid] forKey:@"uid"];
    [dic setValue:[share()userToken] forKey:@"token"];
    [NTAsynService requestWithHead:comOrderBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            self.isFollow=NO;
            self.isComment=YES;
            self.selectType=1;
            [self getTheListData];
            self.normalView.hidden=YES;
            [self showEndViewWithText:@"评论成功！"];
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
        finishData=nil;
    }];
    dic=nil;
}

- (void)backBtnAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
