//
//  NTLoginViewController.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/8.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTLoginViewController.h"
#import "NTAsynService.h"
@interface NTLoginViewController ()

@end

@implementation NTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - resetView

- (void)resetView{
    
    UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight )];
    imageview.image=[NTImage imageWithFileName:@"login.png"];
    [self.view addSubview:imageview];
    
    
    _userName=[[UITextField alloc] initWithFrame:CGRectMake(100, 350+30, 200, 50)];
    _userName.center=CGPointMake(ScreenWidth/2, 350+50/2);
    _userName.backgroundColor=[NTColor clearColor];
    _userName.placeholder=@"账号";
    _userName.layer.masksToBounds=YES;
    _userName.layer.cornerRadius=8;
    _userName.layer.borderWidth=1;
    _userName.layer.borderColor=[[NTColor lightGrayColor] CGColor];
    _userName.leftViewMode=UITextFieldViewModeAlways;
    _userName.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,10, 50)];
    [self.view addSubview:_userName];
    
    _userPassWord=[[UITextField alloc] initWithFrame:CGRectMake(100, _userName.frame.size.height+_userName.frame.origin.y+20, 200, 50)];
    _userPassWord.center=CGPointMake(ScreenWidth/2, _userName.frame.size.height+_userName.frame.origin.y+20+50/2);
    _userPassWord.backgroundColor=[NTColor clearColor];
    _userPassWord.placeholder=@"密码";
    _userPassWord.layer.masksToBounds=YES;
    _userPassWord.layer.cornerRadius=8;
    _userPassWord.layer.borderWidth=1;
    _userPassWord.layer.borderColor=[[NTColor lightGrayColor] CGColor];
    _userPassWord.leftViewMode=UITextFieldViewModeAlways;
    _userPassWord.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,10, 50)];
    [self.view addSubview:_userPassWord];
    
    _submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _submitBtn.frame=CGRectMake(ScreenWidth/2-50, _userPassWord.frame.size.height+_userPassWord.frame.origin.y+30, 100, 30);
    _submitBtn.layer.masksToBounds=YES;
    _submitBtn.layer.cornerRadius=6;
    _submitBtn.layer.borderWidth=0.5;
    _submitBtn.layer.borderColor=[[NTColor lightGrayColor] CGColor];
    [_submitBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
    
    UILabel *messageLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, ScreenHeight-50, ScreenWidth-40, 50)];
    messageLabel.textAlignment=NSTextAlignmentRight;
    messageLabel.backgroundColor=[NTColor clearColor];
    messageLabel.font=[UIFont systemFontOfSize:16];
    messageLabel.text=@"客服：010-63850182   QQ：3284796320";
    [self.view addSubview:messageLabel];
    
}

#pragma mark - submitBtnAction

- (void)submitAction:(id)sender{
    [self showWaitingViewWithText:nil];
    NSDictionary *dic=@{@"user":_userName.text,
                        @"pass":_userPassWord.text};
    [NTAsynService requestWithHead:loginBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            if ([[finishData objectForKey:@"status"] intValue]==1) {
                [NTUserDefaults writeTheData:[finishData objectForKey:@"status"] ForKey:@"status"];
                [NTUserDefaults writeTheData:[finishData objectForKey:@"uid"] ForKey:@"uid"];
                [NTUserDefaults writeTheData:[finishData objectForKey:@"token"] ForKey:@"token"];
                [self performSelector:@selector(closeAction) withObject:nil afterDelay:1];
            }
            else{
                [self showEndViewWithText:@"登陆失败，请联系客服"];
            }
        }
        else{
            [self showEndViewWithText:connectionError.localizedDescription];
        }
    }];
    dic=nil;
}

#pragma mark - closeAction

- (void)closeAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
