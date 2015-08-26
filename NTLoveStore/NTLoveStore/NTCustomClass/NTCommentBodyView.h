//
//  NTCommentBodyView.h
//  NTLoveStore
//
//  Created by liying on 15/8/26.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTCommentBodyView : UIView

@property (nonatomic, strong) UILabel *userLabel;

@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) UILabel *dateLabel;

- (void)resetView;

- (void)reloadTheViewWithData:(NSDictionary *)dic;

@end
