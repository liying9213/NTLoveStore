//
//  NTLoginViewController.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/8.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTLoginViewController.h"
#import "NTNormalHead.h"
@interface NTLoginViewController ()

@end

@implementation NTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - ResetView

- (void)ResetView{
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 100)];
    titleLabel.backgroundColor=[NTColor clearColor];
    titleLabel.font=[UIFont systemFontOfSize:16];
    titleLabel.text=@"";
    [self.view addSubview:titleLabel];
    
    _userName=[[UITextField alloc] initWithFrame:CGRectMake(100, titleLabel.frame.size.height+titleLabel.frame.origin.y, 200, 50)];
    _userName.center=CGPointMake(ScreenWidth/2, 0);
    _userName.backgroundColor=[NTColor clearColor];
    _userName.placeholder=@"";
    _userName.layer.masksToBounds=YES;
    _userName.layer.cornerRadius=6;
    _userName.layer.borderWidth=0.5;
    _userName.layer.borderColor=[[NTColor lightGrayColor] CGColor];
    _userName.leftViewMode=UITextFieldViewModeAlways;
    _userName.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,10, 40)];
    [self.view addSubview:_userName];
    
    _userPassWord=[[UITextField alloc] initWithFrame:CGRectMake(100, _userName.frame.size.height+_userName.frame.origin.y+20, 200, 50)];
    _userPassWord.center=CGPointMake(ScreenWidth/2, 0);
    _userPassWord.backgroundColor=[NTColor clearColor];
    _userPassWord.placeholder=@"";
    _userPassWord.layer.masksToBounds=YES;
    _userPassWord.layer.cornerRadius=6;
    _userPassWord.layer.borderWidth=0.5;
    _userPassWord.layer.borderColor=[[NTColor lightGrayColor] CGColor];
    _userPassWord.leftViewMode=UITextFieldViewModeAlways;
    _userPassWord.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,10, 40)];
    [self.view addSubview:_userPassWord];
    
    _submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _submitBtn.frame=CGRectMake(150, _userPassWord.frame.size.height+_userPassWord.frame.origin.y+20, 100, 30);
    _submitBtn.layer.masksToBounds=YES;
    _submitBtn.layer.cornerRadius=6;
    _submitBtn.layer.borderWidth=0.5;
    _submitBtn.layer.borderColor=[[NTColor lightGrayColor] CGColor];
    [_submitBtn setTitle:@"" forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
    
}

#pragma mark - submitBtnAction

- (void)submitAction:(id)sender{
    [self showWaitingViewWithText:nil];
}


@end
