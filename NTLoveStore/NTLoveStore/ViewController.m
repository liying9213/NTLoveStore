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
//getData
#import "NTReadConfiguration.h"
#import "NTUserDefaults.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetView];
    if (![NTUserDefaults getTheDataForKey:@"login"])
    {
        NTLoginViewController *viewController=[[NTLoginViewController alloc] init];
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - resetView

- (void)resetView{
    
    [self resetHeadSelectView];
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

#pragma mark - functionViewDelgate

- (void)leftViewActionWithID:(int)keyID{
    [_functionView reloadFunctionViewWithData:[NTReadConfiguration getConfigurationWithKey:@"contentData"]];
}

- (void)memberSelectAction:(id)sender{
    NTContentViewController *viewController=[[NTContentViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
