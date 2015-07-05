//
//  NTParentViewController.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/8.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTParentViewController.h"

@implementation NTParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor=[NTColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - waitingView

- (void)showWaitingViewWithText:(NSString *)text{
    if (!_waitingView)
    {
        _waitingView =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_waitingView];
    }
    if (text==nil)
    {
        text=@"正在请求...";
    }
    [self.view bringSubviewToFront:_waitingView];
    _waitingView.mode = MBProgressHUDModeIndeterminate;
    _waitingView.labelText = text;
    [_waitingView show:YES];
}

- (void)showEndViewWithText:(NSString *)text{
    if (!_waitingView)
    {
        _waitingView =[[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_waitingView];
    }
    [self.view bringSubviewToFront:_waitingView];
    _waitingView.labelText = text;
    _waitingView.mode=MBProgressHUDModeText;
    [_waitingView show:YES];
    [_waitingView hide:YES afterDelay:1.0];
}

- (void)hideWaitingView{
    [_waitingView hide:YES];
}

@end
