//
//  NTListView.m
//  NTLoveStore
//
//  Created by liying on 15/7/22.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTListView.h"
#import "NTListTableViewCell.h"
@implementation NTListView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * _cellIdentify = @"cell";
    NTListTableViewCell * iCell = [tableView dequeueReusableCellWithIdentifier:_cellIdentify];
    if (iCell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"NTShopcarTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        iCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    }
    return iCell;
}

@end
