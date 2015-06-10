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
    [self resetView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - resetView

- (void)resetView{
    [self resetHeadSelectView];
}

- (void)resetHeadSelectView{
    NTHeadSelectView *headSelectView=[[NTHeadSelectView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    headSelectView.selectData=[NTReadConfiguration getConfigurationWithKey:@"functionData"];
    headSelectView.delegate=self;
    headSelectView.selectTag=_currentID;
    [headSelectView creatHeadSelectView];
    [self.view addSubview:headSelectView];
}

- (void)resetHeadImageView{
    
}

- (void)resetLeftSelectViewWithData:(NSArray *)leftAry{
    if (_leftView) {
        [_leftView removeFromSuperview];
        _leftView=nil;
    }
    if (!leftAry||leftAry.count==0) {
        return;
    }
    _leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 80, ScreenWidth/6, CGRectGetHeight(self.view.frame)-80)];
    _leftView.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:_leftView];
    float currentYValue=0;
    for (NSDictionary *dic in leftAry){
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, currentYValue, CGRectGetWidth(_leftView.frame), 80);
        [btn setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
        btn.tag=[[dic objectForKey:@"id"] integerValue];
        [btn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(leftSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [_leftView addSubview:btn];
        currentYValue+=80;
    }
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
    NTButton *btn=(NTButton *)sender;
    [self resetLeftSelectViewWithData:[NTReadConfiguration getConfigurationWithKey:btn.keyWord]];
}


@end
