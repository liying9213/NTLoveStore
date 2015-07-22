//
//  NTUserInfoViewController.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/23.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTUserInfoViewController.h"
#import "NTLeftTableViewCell.h"
#import "NTListView.h"
@interface NTUserInfoViewController ()

@end

@implementation NTUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _leftAry=@[@{@"title":@"订单查询"},
               @{@"title":@"服务跟踪"},
               @{@"title":@"资料库"},
               @{@"title":@"婚会客服"},
               @{@"title":@"客户评价"}];
    
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self resetListView];
}

- (void)resetView{
    [self resetListView];
}

- (void)resetListView{
    NTListView *listView=[[NTListView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_rightContentView.frame), CGRectGetHeight(_rightContentView.frame))];
    [_rightContentView  addSubview:listView];
    [listView reloadData];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==1) {
        return 5;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * _cellIdentify = @"cell";
    if (tableView.tag==1) {
        NTLeftTableViewCell * iCell = [tableView dequeueReusableCellWithIdentifier:_cellIdentify];
        if (iCell == nil){
            iCell=[[NTLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellIdentify];
        }
        [iCell reloadTheTableCellWithData:[_leftAry objectAtIndex:indexPath.row]];
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        return iCell;
    }
    else
        return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==1) {
        
    }
}


@end
