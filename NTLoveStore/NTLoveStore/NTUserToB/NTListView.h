//
//  NTListView.h
//  NTLoveStore
//
//  Created by NTTian on 15/7/23.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTListView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id delegate;

@property (nonatomic) BOOL isSelect;

@property (nonatomic) NSInteger selectIndex;

@property (nonatomic, strong) UIButton *allOrderBtn;

@property (nonatomic, strong) UIButton *finOrderBtn;

@property (nonatomic, strong) UIButton *outOrderBtn;

@property (nonatomic, strong) UIButton *payOrderBtn;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *listAry;

@property (nonatomic, strong) NSArray *contentListAry;

@property (nonatomic, strong) UIView *contentView;

- (void)resetView;

- (void)selectAction:(id)sender;

@end
