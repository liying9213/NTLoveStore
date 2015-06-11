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
#import "NTFunctionViewController.h"
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
    
}


#pragma mark - headSelectViewDelegate

- (void)headSelectAction:(id)sender{
    NTButton *btn=(NTButton *)sender;
    if (btn.tag==0) {
        [self resetHomeView];
    }
    else{
        _homeView.hidden=YES;
    }
}

#pragma mark - headSelectViewDelegate

- (void)homeSelectAction:(id)sender{
    
}

















/*
- (void)resetScrollImageView{
    EGOImageView *imageView=[[EGOImageView alloc] initWithPlaceholderImage:nil];
    imageView.frame=CGRectMake(0, 0, ScreenWidth, functionBtnYValue);
    imageView.backgroundColor=[NTColor yellowColor];
    [imageView setImageURL:[NSURL URLWithString:@"http://hunhuiwang.xmbt21.com/uploadfile/2015/0113/20150113094734766.jpg"]];
    [self.view addSubview:imageView];
}

- (void)resetFunctionView{
    NSArray *functionArray=[NTReadConfiguration getConfigurationWithKey:@"homeViewData"];
    if (functionArray)
    {
        for (NSDictionary *dic in functionArray) {
            [self resetFunctionButtonWithData:dic];
        }
    }
}

- (void)resetFunctionButtonWithData:(NSDictionary *)data{
    float width=ScreenWidth/6;
    UIButton *funButton=[UIButton buttonWithType:UIButtonTypeCustom];
    funButton.backgroundColor=[UIColor clearColor];
    funButton.tag=[[data objectForKey:@"id"] integerValue];
    [funButton setTitle:[data objectForKey:@"name"] forState:UIControlStateNormal];
    funButton.frame=CGRectMake(functionBtnXValue, functionBtnYValue, width*[[data objectForKey:@"width"] integerValue], width);
    [funButton setBackgroundColor:[NTColor colorWithHexString:[data objectForKey:@"color"]]];
    [funButton addTarget:self action:@selector(functionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:funButton];
    if (functionBtnXValue+funButton.frame.size.width<ScreenWidth) {
        functionBtnXValue+=funButton.frame.size.width;
    }
    else{
        functionBtnXValue=0;
        functionBtnYValue+=width;
    }
    if (funButton.tag==0) {
        funButton.enabled=NO;
    }
}

#pragma mark - functionAction

- (void)functionAction:(id)sender{
    UIButton *btn=(UIButton *)sender;
    NTFunctionViewController *viewController=[[NTFunctionViewController alloc] init];
    viewController.currentID=btn.tag;
    [self.navigationController pushViewController:viewController animated:YES];
}
*/
@end
