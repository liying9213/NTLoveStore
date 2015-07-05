//
//  NTLoginViewController.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/8.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTLoginViewController.h"
#import "NTAsynService.h"
#import "NTLoginViewController.h"
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
    
    
    _userName=[[UITextField alloc] initWithFrame:CGRectMake((ScreenWidth-340)/2, 350+30, 340, 47)];
    _userName.center=CGPointMake(ScreenWidth/2, 350+50/2);
    _userName.backgroundColor=[NTColor whiteColor];
    _userName.placeholder=@"账号";
    _userName.layer.masksToBounds=YES;
    _userName.layer.cornerRadius=2;
    _userName.leftViewMode=UITextFieldViewModeAlways;
    UIImageView *userimageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    userimageview.image=[UIImage imageNamed:@"user"];
    userimageview.contentMode = UIViewContentModeScaleAspectFit;
    _userName.leftView=userimageview;
    [self.view addSubview:_userName];
    
    _userPassWord=[[UITextField alloc] initWithFrame:CGRectMake((ScreenWidth-340)/2, _userName.frame.size.height+_userName.frame.origin.y+20, 340, 47)];
    _userPassWord.center=CGPointMake(ScreenWidth/2, _userName.frame.size.height+_userName.frame.origin.y+20+50/2);
    _userPassWord.backgroundColor=[NTColor whiteColor];
    _userPassWord.placeholder=@"密码";
    _userPassWord.layer.masksToBounds=YES;
    _userPassWord.layer.cornerRadius=2;
    _userPassWord.leftViewMode=UITextFieldViewModeAlways;
    UIImageView *passimageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    passimageview.image=[UIImage imageNamed:@"pass"];
    passimageview.contentMode = UIViewContentModeScaleAspectFit;
    _userPassWord.leftView=passimageview;
    [self.view addSubview:_userPassWord];
    
    _submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _submitBtn.frame=CGRectMake((ScreenWidth-187)/2, _userPassWord.frame.size.height+_userPassWord.frame.origin.y+30, 184, 47);
    _submitBtn.layer.masksToBounds=YES;
    _submitBtn.layer.cornerRadius=3;
    [_submitBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_submitBtn setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateNormal];
    _submitBtn.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [_submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
    
    UILabel *messageLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, ScreenHeight-50, ScreenWidth-40, 47)];
    messageLabel.textAlignment=NSTextAlignmentRight;
    messageLabel.backgroundColor=[NTColor clearColor];
    messageLabel.font=[UIFont systemFontOfSize:16];
    messageLabel.textColor=[NTColor whiteColor];
    messageLabel.text=@"客服：010-63850182   QQ：3284796320";
    [self.view addSubview:messageLabel];
}

#pragma mark - submitBtnAction

- (void)submitAction:(id)sender{
    __weak typeof(self) __weakself=self;
    [self showWaitingViewWithText:nil];
    NSDictionary *dic=@{@"user":_userName.text,
                        @"pass":_userPassWord.text};
    [NTAsynService requestWithHead:loginBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
             __strong typeof(self) self=__weakself;
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
             __strong typeof(self) self=__weakself;
            [self showEndViewWithText:connectionError.localizedDescription];
        }
    }];
    dic=nil;
}

#pragma mark - closeAction

- (void)closeAction{
    if (_isHome) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [share() setRootViewController];
        [self removeFromParentViewController];
    }
}



@end
