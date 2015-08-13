//
//  NTCommentView.h
//  NTLoveStore
//
//  Created by liying on 15/8/13.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTCommentView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *listAry;

@property (nonatomic, strong) NSArray *contentListAry;

@property (nonatomic, strong) NSArray *keyAry;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic) NSInteger selectIndex;

@property (nonatomic) BOOL isSelect;

@property (nonatomic, weak) id delegate;

- (void)resetView;

@end
