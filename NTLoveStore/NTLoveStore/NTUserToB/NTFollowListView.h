//
//  NTFollowListView.h
//  NTLoveStore
//
//  Created by NTTian on 15/7/23.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTFollowListView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *followListAry;

@property (nonatomic, strong) NSArray *contentListAry;

@property (nonatomic, strong) NSArray *keyAry;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic) NSInteger selectIndex;

@property (nonatomic) BOOL isSelect;

@property (nonatomic, weak) id delegate;

@property (nonatomic, strong) NSMutableArray *selectAry;

@property (nonatomic, copy) NSString *orderID;

- (void)resetView;

@end
