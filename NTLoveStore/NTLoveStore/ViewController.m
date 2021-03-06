//
//  ViewController.m
//  NTLoveStore
//
//  Created by NTTian on 15/6/1.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//
//viewController
#import "ViewController.h"
#import "NTLoginViewController.h"
#import "NTContentViewController.h"
#import "NTWebViewController.h"
#import "NTShoppingCarViewController.h"
#import "NTUserInfoViewController.h"
#import "NTConsultViewController.h"
#import "NTShowDetailVIew.h"
//getData
#import "NTAsynService.h"
#import "NTReadConfiguration.h"
#import "NTUserDefaults.h"
#import "NTShare.h"
#import "NTNormalHead.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    self.isHomeView=YES;
    [super viewDidLoad];
    [self showWaitingViewWithText:@"正在加载..."];
    [self getHomeViewData];
    [self getFunctionData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - resetView

- (void)resetView{
    [self resetNavView];
}

- (void)resetNavView{
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 45)];
    leftView.backgroundColor = [NTColor  clearColor];
    UIImageView *logoImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 99, 35)];
    logoImageView.backgroundColor=[NTColor clearColor];
    logoImageView.image=[NTImage imageNamed:@"logo"];
    [leftView addSubview:logoImageView];

    UIBarButtonItem * _leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = _leftBarButtonItem;
    
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    titleView.backgroundColor = [UIColor yellowColor];
    
    UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, 44)];
    rightView.backgroundColor = [NTColor clearColor];
    
    UIButton *shoppingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    shoppingBtn.frame=CGRectMake(0, 0, 120, 44);
    [shoppingBtn setImage:[NTImage imageWithFileName:nil] forState:UIControlStateNormal];
    shoppingBtn.backgroundColor=[NTColor clearColor];
    [shoppingBtn addTarget:self action:@selector(shoppingCarAction) forControlEvents:UIControlEventTouchUpInside];
    [shoppingBtn setImage:[NTImage imageWithFileName:@"shopping.png"] forState:UIControlStateNormal];
    [shoppingBtn setTitle:@"我的购物车" forState:UIControlStateNormal];
    [shoppingBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    shoppingBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    shoppingBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, -10);
    [rightView addSubview:shoppingBtn];
    
    UIButton *userBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    userBtn.frame=CGRectMake(130, 0, 110, 44);
    [userBtn setImage:[NTImage imageWithFileName:nil] forState:UIControlStateNormal];
    userBtn.backgroundColor=[NTColor clearColor];
    [userBtn addTarget:self action:@selector(userInfoAction:) forControlEvents:UIControlEventTouchUpInside];
    [userBtn setImage:[NTImage imageWithFileName:@"user.png"] forState:UIControlStateNormal];
    [userBtn setTitle:@"个人中心" forState:UIControlStateNormal];
    [userBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    userBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    userBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, -10);
    [rightView addSubview:userBtn];
    
    UIBarButtonItem * _rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = _rightBarButtonItem;
}

- (void)resetHeadSelectView:(NSArray *)ary{
    _headSelectView=[[NTHeadSelectView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    _headSelectView.selectData=ary;
    _headSelectView.delegate=self;
    _headSelectView.selectTag=0;
    [_headSelectView creatHeadSelectView];
    [self.view addSubview:_headSelectView];
}

- (void)resetHomeView{
    _functionView.hidden=YES;
    [_functionView removeFromSuperview];
    _functionView=nil;
    if (!_homeView){
        _homeView=[[NTHomeView alloc] initWithFrame:CGRectMake(0, 55, ScreenWidth, CGRectGetHeight(self.view.frame)-55)];
        _homeView.delegate=self;
        [_homeView  resetHomeView];
        [self.view addSubview:_homeView];
    }
    else{
        _homeView.hidden=NO;
    }
}

- (void)resetFunctionView{
    _homeView.hidden=YES;
    [_homeView removeFromSuperview];
    _homeView=nil;
    if (!_functionView) {
        _functionView=[[NTFunctionView alloc] initWithFrame:CGRectMake(0, 60, ScreenWidth, CGRectGetHeight(self.view.frame)-60)];
        _functionView.delegate=self;
        _functionView.isTheme=_isTheme;
        [_functionView resetView];
        [self.view addSubview:_functionView];
    }
    else{
         _functionView.isTheme=_isTheme;
        _functionView.hidden=NO;
    }
}

-(void)reloadFunctionView:(NSArray *)functionAry{
    _functionView.index=1;
    _functionView.tableView.hidden=NO;
    [_functionView reloadFunctionViewWithData:functionAry];
    [self hideWaitingView];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - getTheData

- (void)getHomeViewData{
    __weak typeof(self) __weakself=self;
    [NTAsynService requestWithHead:adBaseURL WithBody:nil completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success){
            [NTUserDefaults writeTheAdData:[finishData allValues]];
            finishData=nil;
            __strong typeof(self) self=__weakself;
            [self resetView];
        }
        else{
             __strong typeof(self) self=__weakself;
            [self resetView];
        }
    }];
}

- (void)getFunctionData{
    
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken]};
    [NTAsynService requestWithHead:catalogBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            [self hideWaitingView];
            [NTUserDefaults writeTheFunctionData:(NSArray *)finishData];
            NSMutableArray *ary=[[NSMutableArray array] init];
            [ary addObject:@{@"id":@"0",@"title":@"首页",@"name":@"sy"}];
            [ary addObjectsFromArray:(NSArray *)finishData];
            [self resetHeadSelectView:ary];
            ary=nil;
            finishData=nil;
        }
        else{
            [self hideWaitingView];
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
                NTLoginViewController *viewcontroller=[[NTLoginViewController alloc] init];
                viewcontroller.isHome=YES;
                [self presentViewController:viewcontroller animated:YES completion:nil];
            }
        }
    }];
    dic=nil;
}

#pragma mark - headSelectViewDelegate

- (void)headSelectAction:(id)sender{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        NTLoginViewController *viewcontroller=[[NTLoginViewController alloc] init];
        viewcontroller.isHome=YES;
        [self presentViewController:viewcontroller animated:YES completion:nil];
        return;
    }
    _isTheme=NO;
    NTButton *btn=(NTButton *)sender;
    if (btn.tag==0) {
        [self resetHomeView];
    }
    else{
        if (btn.tag==153) {
            _isTheme=YES;
        }
        [self resetFunctionView];
        id data=[NTUserDefaults getTheDataForKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
        [_functionView reloadLeftViewWithData:data];
        data=nil;
    }
}

#pragma mark - homeSelectDelegate

- (void)homeSelectAction:(id)sender{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        NTLoginViewController *viewcontroller=[[NTLoginViewController alloc] init];
        viewcontroller.isHome=YES;
        [self presentViewController:viewcontroller animated:YES completion:nil];
        return;
    }
    NTButton *btn=(NTButton *)sender;
    if (btn.tag==1024) {
        NTConsultViewController *viewcontroller=[[NTConsultViewController alloc] init];
        [self.navigationController pushViewController:viewcontroller animated:YES];
    }
    else{
        [_headSelectView selectTheTag:btn.tag];
    }
}

- (void)homeWebSelectAction:(NSString *)path{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        NTLoginViewController *viewcontroller=[[NTLoginViewController alloc] init];
        viewcontroller.isHome=YES;
        [self presentViewController:viewcontroller animated:YES completion:nil];
        return;
    }
    NTWebViewController *webView=[[NTWebViewController alloc] init];
    webView.urlPath=path;
    [self.navigationController pushViewController:webView animated:YES];
}

#pragma mark - functionViewDelgate

- (void)leftViewActionWithCategory:(NSString *)category WithOrder:(NSInteger)orderID{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    
    [self showWaitingViewWithText:@"正在加载..."];
    _functionView.tableView.hidden=YES;
    __weak typeof(self) __weakself=self;
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"category":category,
                        @"order":[NSNumber numberWithInteger:orderID],
                        @"sort":@"asc"};
    _currentType=category;
    _theID=_functionView.theID;
    [NTAsynService requestWithHead:listBaseURL WithBody:dic completionHandler:^(BOOL success,  id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self reloadFunctionView:[self getTheValuesWithKey:[[finishData allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] withData:finishData]];
            finishData=nil;
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

- (void)memberSelectAction:(id)sender{
    NTButton *btn=(NTButton *)sender;
    NTContentViewController *viewController=[[NTContentViewController alloc] init];
    viewController.productID=btn.tag;
    viewController.title = btn.keyWord;
    viewController.isCanSelect=!_isTheme;
    viewController.currentType=_currentType;
    viewController.isPerson=[self isPerson];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)showResult:(id)sender{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    if (!sender) {
        [self showEndViewWithText:@"未找到场地效果图！"];
        return;
    }
    [self showWaitingViewWithText:nil];
    __weak typeof(self) __weakself=self;
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"id":[sender objectForKey:@"id"]};
    [NTAsynService requestWithHead:detileBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self hideWaitingView];
            NTShowDetailVIew *detailView=[[NTShowDetailVIew alloc] initWithFrame:self.view.frame];
            [detailView showImageWithArray:[[finishData objectForKey:@"pics"] componentsSeparatedByString:@","] withIndex:0];
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

- (void)selectAction:(id)sender{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    UIButton *btn=(id)sender;
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [self showWaitingViewWithText:@"正在加入购物车..."];
    __weak typeof(self) __weakself=self;
    NSString *num=@"1";
    NSString *date=@"0";
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"id":[NSString stringWithFormat:@"%d",_theID],
                        @"price":[NSString stringWithFormat:@"%f",_functionView.theTuanPrice],
                        @"pet":@"1",
                        @"num":num,
                        @"parameters":date,
                        @"sort":_currentType};
    [NTAsynService requestWithHead:addItemBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            btn.enabled=NO;
            [btn setBackgroundColor:[NTColor lightGrayColor]];
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

- (BOOL)isPerson{
    NSDictionary *dic=[_functionView.leftAry firstObject];
    if ([[dic objectForKey:@"pid"] intValue]==52) {
        return YES;
    }
    return NO;
}

#pragma  mark - navAction

- (void)shoppingCarAction{
    NTShoppingCarViewController *shoppingCar=[[NTShoppingCarViewController alloc] init];
    [self.navigationController pushViewController:shoppingCar animated:YES];
}

- (void)userInfoAction:(id)sender {
    if (![share()userIsLogin]) {
        NTLoginViewController *viewcontroller=[[NTLoginViewController alloc] init];
        viewcontroller.isHome=YES;
        [self presentViewController:viewcontroller animated:YES completion:nil];
        return;
    }
    UIButton *btn=(UIButton *)sender;
    _popoverContent=[[NTUserPopViewController alloc] init];
    _popoverContent.delegate=self;
    _popoverView=[[UIPopoverController alloc] initWithContentViewController:_popoverContent];
    _popoverView.popoverContentSize = CGSizeMake(200, 100);
    _popoverView.delegate=self;
    [_popoverView presentPopoverFromRect:btn.bounds inView:btn permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

#pragma mark - popoverViewDelegate

- (void)userInfoSelect:(id)sender{
    if ([(UIButton *)sender tag]==0) {
        [_popoverView dismissPopoverAnimated:YES];
        NTUserInfoViewController *userInfoView=[[NTUserInfoViewController alloc] init];
        [self.navigationController pushViewController:userInfoView animated:YES];
//        [self presentViewController:userInfoView animated:YES completion:nil];
    }
    else if ([(UIButton *)sender tag]==1){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"确定退出" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
         [_popoverView dismissPopoverAnimated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [NTUserDefaults writeTheData:@"0" ForKey:@"status"];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    _popoverView=nil;
    _popoverContent=nil;
}


@end
