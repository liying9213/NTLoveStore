//
//  NTUserPopViewController.h
//  NTLoveStore
//
//  Created by liying on 15/6/22.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NTUserPopViewController;

@protocol NTUserPopViewControllerDelegate <NSObject>

@required

- (void)userInfoSelect:(id)sender;

@end

@interface NTUserPopViewController : UIViewController

@property (nonatomic, assign)id delegate;

@end
