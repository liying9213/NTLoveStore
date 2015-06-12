//
//  NTMemberView.h
//  NTLoveStore
//
//  Created by 李莹 on 15/6/12.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NTMemberView;

@protocol NTMemberViewDelegate <NSObject>

@required

- (void)memberSelectAction:(id)sender;

@end


@interface NTMemberView : UIView

@property (nonatomic, assign) id delegate;

@property (nonatomic, strong) NSDictionary *memberDic;

- (id)initWithFrame:(CGRect)frame;

- (void)resetView;

@end
