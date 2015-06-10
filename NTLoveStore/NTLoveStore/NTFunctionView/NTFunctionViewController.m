//
//  NTFunctionViewController.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/10.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTFunctionViewController.h"
//getData
#import "NTReadConfiguration.h"

@interface NTFunctionViewController ()

@end

@implementation NTFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - resetView

- (void)resetView{
    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _scrollView.backgroundColor=[NTColor clearColor];
    [self.view addSubview:_scrollView];
    [self resetHeadSelectView];
}

- (void)resetHeadSelectView{
    NTHeadSelectView *headSelectView=[[NTHeadSelectView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    headSelectView.selectData=[NTReadConfiguration getConfigurationWithKey:@"functionData"];
    headSelectView.delegate=self;
    [headSelectView creatHeadSelectView];
    [_scrollView addSubview:headSelectView];
}

- (void)resetHeadImageView{
    
}

- (void)resetLeftSelectView{
    
}

- (void)resetContentView{
    
}

#pragma mark - leftSelectAction

- (void)leftSelectAction:(id)sender{
    
}


#pragma mark - requestServiceData

- (void)getCurrentFunctionData{
    
}

#pragma mark - headSelectViewDelegate

- (void)headSelectAction:(id)sender{
    
}

@end
