//
//  NTMemberView.h
//  NTLoveStore
//
//  Created by NTTian on 15/6/12.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTNormalHead.h"

@class NTMemberView;

@protocol NTMemberViewDelegate <NSObject>

@required

- (void)memberSelectAction:(id)sender;

@end


@interface NTMemberView : UIView

@property (nonatomic, assign) id delegate;

//@property (nonatomic, strong) NSDictionary *memberDic;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *finishNumLabel;

@property (nonatomic, strong) UILabel *commentNumLabel;

@property (nonatomic, strong) NTButton *selectBtn;

- (id)initWithFrame:(CGRect)frame;

- (void)resetView;

- (void)reloadTheViewWithData:(NSDictionary *)dic;
@end
