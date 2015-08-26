//
//  NTShowDetailVIew.h
//  NTLoveStore
//
//  Created by liying on 15/6/30.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTShowDetailVIew : UIView <UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UIImageView *showImageView;

@property (nonatomic, strong)NSArray *commentAry;

- (void)showImageWithArray:(NSArray *)imageArray withIndex:(NSInteger)index;

- (void)showTextWithString:(NSString *)string;

- (void)showLeftTextWithString:(NSString *)string;

- (void)showTableViewWithData:(NSArray*)dataAry;

@end
