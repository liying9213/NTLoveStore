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
    self.view.backgroundColor=[NTColor whiteColor];
    [self resetView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetView{
    UIButton *userInfo=[UIButton buttonWithType:UIButtonTypeCustom];
    userInfo.frame=CGRectZero;
//    userInfo.backgroundColor=[NTColor clearColor];
//    userInfo.tag=0;
//    [userInfo setTitle:@"个人中心" forState:UIControlStateNormal];
//    [userInfo setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
//    userInfo.frame=CGRectMake(0, 0, 200, 50);
//    userInfo.titleLabel.font=[UIFont systemFontOfSize:14];
//    [userInfo addTarget:self action:@selector(userInfoSelect:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:userInfo];
//    
//    CALayer *bottomBorder = [CALayer layer];
//    float height1=userInfo.frame.size.height-0.5f;
//    float width1=userInfo.frame.size.width;
//    bottomBorder.frame = CGRectMake(0.0f, height1, width1, 0.5f);
//    bottomBorder.backgroundColor = [UIColor blackColor].CGColor;
//    [userInfo.layer addSublayer:bottomBorder];
    
    UIButton *logout=[UIButton buttonWithType:UIButtonTypeCustom];
    logout.backgroundColor=[NTColor clearColor];
    logout.tag=1;
    [logout setTitle:@"退出" forState:UIControlStateNormal];
    [logout setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    logout.frame=CGRectMake(0, CGRectGetHeight(userInfo.frame), 200, 50);
    logout.titleLabel.font=[UIFont systemFontOfSize:14];
    [logout addTarget:self action:@selector(userInfoSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logout];
    
}

- (void)userInfoSelect:(id)sender{
    [_delegate userInfoSelect:sender];
}

@end
