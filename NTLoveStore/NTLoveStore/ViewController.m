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
    [self resetView];
//    if (![share()userIsLogin])
//    {
//        NTLoginViewController *viewController=[[NTLoginViewController alloc] init];
//        [self presentViewController:viewController animated:YES completion:nil];
//    }
    
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
    
    UIImageView *logoImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 45)];
    logoImageView.backgroundColor=[NTColor clearColor];
    logoImageView.image=[NTImage imageWithFileName:@"logo.png"];
    [leftView addSubview:logoImageView];

    UIBarButtonItem * _leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = _leftBarButtonItem;
    
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    titleView.backgroundColor = [UIColor yellowColor];

    UISearchBar *searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    searchBar.backgroundColor=[UIColor lightGrayColor];
    searchBar.delegate=self;
    [titleView addSubview:searchBar];
    self.navigationItem.titleView=titleView;
    
    _searchDisplayView=[[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    _searchDisplayView.delegate=self;
    _searchDisplayView.searchResultsDataSource=self;
    _searchDisplayView.searchResultsDelegate=self;
    
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
        [_functionView resetView];
        [self.view addSubview:_functionView];
    }
    else{
        _functionView.hidden=NO;
    }
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
    
    NSDictionary *dic=@{@"user":@"",
                        @"pass":@""};
    [NTAsynService requestWithHead:loginBaseURL WithBody:dic completionHandler:^(BOOL success, NSDictionary *finishDic, NSError *connectionError) {
        if (success) {
        }
        else{
            [self showEndViewWithText:connectionError.localizedDescription];
        }
    }];
    dic=nil;
}

- (void)getFunctionLeftData{
    
}

- (void)getFunctionData{
    
    NSDictionary *dic=@{@"user":@"",
                        @"pass":@""};
    [NTAsynService requestWithHead:loginBaseURL WithBody:dic completionHandler:^(BOOL success, NSDictionary *finishDic, NSError *connectionError) {
        if (success) {
        }
        else{
            [self showEndViewWithText:connectionError.localizedDescription];
        }
    }];
    dic=nil;
    
}

#pragma mark - headSelectViewDelegate

- (void)headSelectAction:(id)sender{
    NTButton *btn=(NTButton *)sender;
    if (btn.tag==0) {
        [self resetHomeView];
    }
    else{
        [self resetFunctionView];
        [_functionView reloadLeftViewWithData:[NTReadConfiguration getConfigurationWithKey:btn.keyWord]];
    }
}

#pragma mark - homeSelectDelegate

- (void)homeSelectAction:(id)sender{
    EGOImageButton *btn=(EGOImageButton *)sender;
    [_headSelectView selectTheTag:btn.tag];
}

- (void)homeWebSelectAction:(NSString *)path{
    NTWebViewController *webView=[[NTWebViewController alloc] init];
    webView.urlPath=path;
    [self.navigationController pushViewController:webView animated:YES];
}

#pragma mark - functionViewDelgate

- (void)leftViewActionWithID:(int)keyID{
    [_functionView reloadFunctionViewWithData:[NTReadConfiguration getConfigurationWithKey:@"contentData"]];
}

- (void)memberSelectAction:(id)sender{
    NTContentViewController *viewController=[[NTContentViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma  mark - navAction

- (void)shoppingCarAction{
    NTShoppingCarViewController *shoppingCar=[[NTShoppingCarViewController alloc] init];
    [self.navigationController pushViewController:shoppingCar animated:YES];
}

- (void)userInfoAction:(id)sender {
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
        
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    _popoverView=nil;
    _popoverContent=nil;
}


@end
