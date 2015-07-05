//
//  NTLoginViewController.h
//  NTLoveStore
//
//  Created by 李莹 on 15/6/8.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTParentViewController.h"

@interface NTLoginViewController : NTParentViewController

@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *userPassWord;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic) BOOL isHome;

@end
