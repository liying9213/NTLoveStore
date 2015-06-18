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
//getData
#import "NTReadConfiguration.h"
#import "NTUserDefaults.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetView];
//    if (![NTUserDefaults getTheDataForKey:@"login"])
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
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    leftView.backgroundColor = [UIColor yellowColor];
    
    UIImageView *logoImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    logoImageView.backgroundColor=[UIColor lightGrayColor];
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
    
    
    UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    rightView.backgroundColor = [UIColor yellowColor];
    
    UIButton *shoppingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    shoppingBtn.frame=CGRectMake(0, 0, 80, 44);
    [shoppingBtn setImage:[NTImage imageWithContentsOfFile:nil] forState:UIControlStateNormal];
    shoppingBtn.backgroundColor=[NTColor lightGrayColor];
    [shoppingBtn addTarget:self action:@selector(shoppingCarAction) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:shoppingBtn];
    
    UIButton *userBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    userBtn.frame=CGRectMake(120, 0, 80, 44);
    [userBtn setImage:[NTImage imageWithContentsOfFile:nil] forState:UIControlStateNormal];
    userBtn.backgroundColor=[NTColor lightGrayColor];
    [userBtn addTarget:self action:@selector(userInfoAction) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:userBtn];
    
    UIBarButtonItem * _rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = _rightBarButtonItem;

}

- (void)resetHeadSelectView{
    NTHeadSelectView *headSelectView=[[NTHeadSelectView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    headSelectView.selectData=[NTReadConfiguration getConfigurationWithKey:@"functionData"];
    headSelectView.delegate=self;
    headSelectView.selectTag=0;
    [headSelectView creatHeadSelectView];
    [self.view addSubview:headSelectView];
}

- (void)resetHomeView{
    _functionView.hidden=YES;
    if (!_homeView){
        _homeView=[[NTHomeView alloc] initWithFrame:CGRectMake(0, 60, ScreenWidth, CGRectGetHeight(self.view.frame)-60)];
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
    
}

- (void)getFunctionLeftData{
    
}

- (void)getFunctionData{
    
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
    
}

- (void)homeWebSelectAction:(NSString *)path{
    NSLog(@"====%@",path);
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

- (void)userInfoAction{
    
}

@end
