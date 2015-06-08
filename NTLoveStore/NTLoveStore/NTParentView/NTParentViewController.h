//
//  NTParentViewController.h
//  NTLoveStore
//
//  Created by 李莹 on 15/6/8.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTNormalHead.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface NTParentViewController : UIViewController

@property (nonatomic, strong) MBProgressHUD *waitingView;

- (void)showWaitingViewWithText:(NSString *)str;

- (void)showEndViewWithText:(NSString *)text;

- (void)hideWaitingView;

@end
