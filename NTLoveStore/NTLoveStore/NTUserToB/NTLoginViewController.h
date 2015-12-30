//
//  NTLoginViewController.h
//  NTLoveStore
//
//  Created by NTTian on 15/6/8.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import "NTParentViewController.h"

@interface NTLoginViewController : NTParentViewController<UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *userPassWord;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic) BOOL isHome;

@end
