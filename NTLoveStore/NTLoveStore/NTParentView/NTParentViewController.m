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
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                imageView.hidden=YES;
            }
        }
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -20, ScreenWidth, 64)];
        imageView.image=[NTImage imageWithColor:[NTColor colorWithHexString:NTWhiteColor] size:CGSizeMake(ScreenWidth, 3)];
        [self.navigationController.navigationBar addSubview:imageView];
        [self.navigationController.navigationBar sendSubviewToBack:imageView];
    }
    if (!_isHomeView) {
     [self ResetBackView];
    }
}

-(void)ResetBackView
{
    [self.navigationController setNavigationBarHidden:NO];
    if (!_isShowLogo) {
        UIButton * _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(0, 0, 44, 44);
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.backgroundColor = [UIColor clearColor];
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -10;
        UIBarButtonItem *Lbar=[[UIBarButtonItem alloc] initWithCustomView:_backBtn];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:spaceButtonItem, Lbar, nil];
    }
    else{
        UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 45)];
        leftView.backgroundColor = [NTColor  clearColor];
        
        UIImageView *logoImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 99, 35)];
        logoImageView.backgroundColor=[NTColor clearColor];
        logoImageView.image=[NTImage imageNamed:@"logo"];
        [leftView addSubview:logoImageView];
        
        UIBarButtonItem * _leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
        self.navigationItem.leftBarButtonItem = _leftBarButtonItem;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
}

- (NSMutableArray *)getTheValuesWithKey:(NSArray *)keyAry withData:(NSMutableDictionary *)dic{
    NSMutableArray *ary=[[NSMutableArray array] init];
    for (NSString *str in keyAry) {
        [ary addObject:[dic objectForKey:str]];
    }
    return ary;
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
