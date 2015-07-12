//
//  ViewController.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/1.
//  Copyright (c) 2015年 liying. All rights reserved.
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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
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
    [self resetHeadSelectView];
}

- (void)resetNavView{
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 45)];
    leftView.backgroundColor = [NTColor  clearColor];
    
    UIImageView *logoImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 99, 35)];
    logoImageView.backgroundColor=[NTColor clearColor];
    logoImageView.image=[NTImage imageWithFileName:@"logo.png"];
    [leftView addSubview:logoImageView];

    UIBarButtonItem * _leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = _leftBarButtonItem;
    
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    titleView.backgroundColor = [UIColor yellowColor];

//    UISearchBar *searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
//    searchBar.backgroundColor=[UIColor lightGrayColor];
//    searchBar.delegate=self;
//    [titleView addSubview:searchBar];
//    self.navigationItem.titleView=titleView;
//    
//    _searchDisplayView=[[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
//    _searchDisplayView.delegate=self;
//    _searchDisplayView.searchResultsDataSource=self;
//    _searchDisplayView.searchResultsDelegate=self;
    
    UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, 44)];
    rightView.backgroundColor = [NTColor clearColor];
    
    UIButton *shoppingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    shoppingBtn.frame=CGRectMake(0, 0, 120, 44);
    [shoppingBtn setImage:[NTImage imageWithContentsOfFile:nil] forState:UIControlStateNormal];
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
    [userBtn setImage:[NTImage imageWithContentsOfFile:nil] forState:UIControlStateNormal];
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

- (void)resetHeadSelectView{
    _headSelectView=[[NTHeadSelectView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    _headSelectView.selectData=[NTReadConfiguration getConfigurationWithKey:@"functionData"];
    _headSelectView.delegate=self;
    _headSelectView.selectTag=0;
    [_headSelectView creatHeadSelectView];
    [self.view addSubview:_headSelectView];
}

- (void)resetHomeView{
    _functionView.hidden=YES;
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
    _functionView.tableView.hidden=NO;
    [_functionView reloadFunctionViewWithData:functionAry];
    [self hideWaitingView];
}

#pragma mark - searchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}

#pragma mark - searchDisplayDelegate

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    _searchDisplayView.searchResultsTableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    return YES;
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
        }
        else{
            [self hideWaitingView];
        }
    }];
    dic=nil;
}

#pragma mark - headSelectViewDelegate

- (void)headSelectAction:(id)sender{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
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
        [_functionView reloadLeftViewWithData:[NTUserDefaults getTheDataForKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]]];
    }
}

#pragma mark - homeSelectDelegate

- (void)homeSelectAction:(id)sender{
    EGOImageButton *btn=(EGOImageButton *)sender;
    if (btn.tag==1024) {
        NTConsultViewController *viewcontroller=[[NTConsultViewController alloc] init];
        [self.navigationController pushViewController:viewcontroller animated:YES];
    }
    else{
        [_headSelectView selectTheTag:btn.tag];
    }
}

- (void)homeWebSelectAction:(NSString *)path{
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
    [NTAsynService requestWithHead:listBaseURL WithBody:dic completionHandler:^(BOOL success,  id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self reloadFunctionView:[finishData allValues]];
        }
        else{
            __strong typeof(self) self=__weakself;
            [self showEndViewWithText:connectionError.localizedDescription];
        }
    }];
    dic=nil;
}

- (void)memberSelectAction:(id)sender{
    UIButton *btn=(UIButton *)sender;
    NTContentViewController *viewController=[[NTContentViewController alloc] init];
    viewController.productID=btn.tag;
    viewController.isCanSelect=!_isTheme;
    viewController.currentType=_currentType;
    viewController.isPerson=[self isPerson];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)showResult:(id)sender{
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
            [self showEndViewWithText:connectionError.localizedDescription];
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
    }
    else if ([(UIButton *)sender tag]==1){
         [_popoverView dismissPopoverAnimated:YES];
        [NTUserDefaults writeTheData:@"0" ForKey:@"status"];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    _popoverView=nil;
    _popoverContent=nil;
}


@end
