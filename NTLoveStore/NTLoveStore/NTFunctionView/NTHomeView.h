//
//  NTHomeView.h
//  NTLoveStore
//
//  Created by liying on 15/6/11.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTNormalHead.h"
@protocol NTHomeViewDelegate <NSObject>

@optional

- (void)homeSelectAction:(id)sender;

@optional

- (void)homeWebSelectAction:(NSString *)path;

@end

@interface NTHomeView : UIView
{
    float functionBtnXValue;
    float functionBtnYValue;
    float functionBtnHeight;
    CGRect moreRect;
}

@property (nonatomic, assign)id delegate;
@property (nonatomic, strong)NSDictionary *homeDic;

- (id)initWithFrame:(CGRect)frame;

- (void)resetHomeView;

@end
