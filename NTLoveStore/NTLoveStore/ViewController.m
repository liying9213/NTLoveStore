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
    [self showWaitingViewWithText:@"正在加载..."];
    if (![share()userIsLogin])
    {
        NTLoginViewController *viewController=[[NTLoginViewController alloc] init];
        [self presentViewController:viewController animated:YES completion:nil];
    }
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
//    [self getHomeViewData];

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
    [NTAsynService requestWithHead:adBaseURL WithBody:nil completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success){
        }
        else{
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
        }
    }];
    dic=nil;
    
    /*
     [
     {
     "id": "52",
     "name": "hlry",
     "pid": "0",
     "title": "婚礼人员",
     "icon": "85",
     "child": [
     {
     "id": "146",
     "name": "zcr",
     "pid": "52",
     "title": "主持人",
     "icon": "0",
     "child": []
     },
     {
     "id": "57",
     "name": "hzs",
     "pid": "52",
     "title": "化妆师",
     "icon": "0",
     "child": []
     },
     {
     "id": "58",
     "name": "sys",
     "pid": "52",
     "title": "摄影师",
     "icon": "0",
     "child": []
     },
     {
     "id": "145",
     "name": "sxs",
     "pid": "52",
     "title": "摄像师",
     "icon": "0",
     "child": []
     },
     {
     "id": "147",
     "name": "byry",
     "pid": "52",
     "title": "表演人员",
     "icon": "0",
     "child": []
     },
     {
     "id": "148",
     "name": "djs",
     "pid": "52",
     "title": "DJ师",
     "icon": "0",
     "child": []
     }
     ]
     },
     {
     "id": "107",
     "name": "hysj",
     "pid": "0",
     "title": "花艺设计",
     "icon": "87",
     "child": [
     {
     "id": "104",
     "name": "cht",
     "pid": "107",
     "title": "车头花",
     "icon": "0",
     "child": []
     },
     {
     "id": "105",
     "name": "hm",
     "pid": "107",
     "title": "花门",
     "icon": "0",
     "child": []
     },
     {
     "id": "149",
     "name": "lyh",
     "pid": "107",
     "title": "路引花",
     "icon": "0",
     "child": []
     },
     {
     "id": "150",
     "name": "qdt",
     "pid": "107",
     "title": "签到台",
     "icon": "0",
     "child": []
     },
     {
     "id": "151",
     "name": "zh",
     "pid": "107",
     "title": "桌花",
     "icon": "0",
     "child": []
     },
     {
     "id": "152",
     "name": "xh",
     "pid": "107",
     "title": "胸花",
     "icon": "0",
     "child": []
     }
     ]
     },
     {
     "id": "75",
     "name": "cddj",
     "pid": "0",
     "title": "场地搭建",
     "icon": "88",
     "child": [
     {
     "id": "115",
     "name": "wt",
     "pid": "75",
     "title": "舞台/T台",
     "icon": "0",
     "child": []
     },
     {
     "id": "118",
     "name": "dt",
     "pid": "75",
     "title": "地毯",
     "icon": "0",
     "child": []
     },
     {
     "id": "117",
     "name": "bj",
     "pid": "75",
     "title": "背景",
     "icon": "0",
     "child": []
     },
     {
     "id": "119",
     "name": "yjt",
     "pid": "75",
     "title": "演讲台",
     "icon": "0",
     "child": []
     },
     {
     "id": "154",
     "name": "cqdt",
     "pid": "75",
     "title": "签到台",
     "icon": "0",
     "child": []
     },
     {
     "id": "155",
     "name": "truss",
     "pid": "75",
     "title": "truss架",
     "icon": "0",
     "child": []
     }
     ]
     },
     {
     "id": "71",
     "name": "wmdg",
     "pid": "0",
     "title": "舞美灯光",
     "icon": "86",
     "child": [
     {
     "id": "86",
     "name": "wtxg",
     "pid": "71",
     "title": "舞台效果",
     "icon": "0",
     "child": []
     },
     {
     "id": "81",
     "name": "dgxg",
     "pid": "71",
     "title": "灯光效果",
     "icon": "0",
     "child": []
     }
     ]
     },
     {
     "id": "111",
     "name": "hldj",
     "pid": "0",
     "title": "婚礼道具",
     "icon": "56",
     "child": [
     {
     "id": "112",
     "name": "ysq",
     "pid": "111",
     "title": "仪式区",
     "icon": "0",
     "child": []
     },
     {
     "id": "156",
     "name": "yhq",
     "pid": "111",
     "title": "宴会区",
     "icon": "0",
     "child": []
     }
     ]
     },
     {
     "id": "153",
     "name": "dztc",
     "pid": "0",
     "title": "订制套餐",
     "icon": "0",
     "child": []
     }
     ]
     
     */

}

#pragma mark - headSelectViewDelegate

- (void)headSelectAction:(id)sender{
    NTButton *btn=(NTButton *)sender;
    if (btn.tag==0) {
        [self resetHomeView];
    }
    else{
        [self resetFunctionView];
        [_functionView reloadLeftViewWithData:[NTUserDefaults getTheDataForKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]]];
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

- (void)leftViewActionWithCategory:(NSString *)category WithOrder:(NSInteger)orderID{
    [self showWaitingViewWithText:@"正在加载..."];
    _functionView.tableView.hidden=YES;
    __weak typeof(self) __weakself=self;
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"category":category,
                        @"order":[NSNumber numberWithInteger:orderID],
                        @"sort":@"asc"};
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
    /*
     {
     "95": {
	    "id": "95",
	    "title": "订制套餐",
	    "price": "100.00",
	    "cover_id": "http://aihunhui.kfrig.net/Uploads/Picture/2015-06-17/558177c96e860.jpg",
	    "sale": "0",
	    "comment": "0"
     }
     }
     */
    
//    [_functionView reloadFunctionViewWithData:[NTReadConfiguration getConfigurationWithKey:@"contentData"]];
}

- (void)memberSelectAction:(id)sender{
    UIButton *btn=(UIButton *)sender;
    
    NTContentViewController *viewController=[[NTContentViewController alloc] init];
    viewController.productID=btn.tag;
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
