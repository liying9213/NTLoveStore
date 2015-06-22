//
//  NTUserPopViewController.m
//  NTLoveStore
//
//  Created by liying on 15/6/22.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTUserPopViewController.h"
#import "NTNormalHead.h"
@interface NTUserPopViewController ()

@end

@implementation NTUserPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetView{
    UIButton *userInfo=[UIButton buttonWithType:UIButtonTypeCustom];
    userInfo.backgroundColor=[NTColor clearColor];
    [userInfo setTitle:@"个人中心" forState:UIControlStateNormal];
    userInfo.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 60);
    [self.view addSubview:userInfo];
    
    UIButton *logout=[UIButton buttonWithType:UIButtonTypeCustom];
    logout.backgroundColor=[NTColor clearColor];
    [logout setTitle:@"退出" forState:UIControlStateNormal];
    logout.frame=CGRectMake(0, CGRectGetHeight(userInfo.frame), CGRectGetWidth(self.view.frame), 60);
    [self.view addSubview:userInfo];
    
}

@end
