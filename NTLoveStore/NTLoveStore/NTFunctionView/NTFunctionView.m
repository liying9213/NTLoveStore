//
//  NTFunctionView.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/12.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTFunctionView.h"
#import "NTFunctionTableViewCell.h"
#import "NTLeftTableViewCell.h"
#import "NTNormalHead.h"
@implementation NTFunctionView

#pragma mark - resetView

- (void)resetView{
    [self resetLeftSelectView];
    [self resetTableView];
}

- (void)resetLeftSelectView{
    _leftView=[[UITableView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth/5, CGRectGetHeight(self.frame))];
    _leftView.backgroundColor=[NTColor clearColor];
    _leftView.delegate=self;
    _leftView.dataSource=self;
    _leftView.rowHeight=60;
    [self addSubview:_leftView];
}

- (void)resetTableView{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_leftView.frame)+10, 0, CGRectGetWidth(self.frame)-CGRectGetWidth(_leftView.frame)-10, CGRectGetHeight(self.frame))];
    _tableView.backgroundColor=[NTColor clearColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=160;
    [self addSubview:_tableView];
}

- (void)reloadLeftViewWithData:(NSArray *)leftAry{
    _leftAry=leftAry;
    [_leftView reloadData];
    if (_leftAry.count>0) {
        [_leftView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
        [self leftViewActionWithID:[[[_leftAry objectAtIndex:0] objectForKey:@"id"] intValue]];
    }
}

- (void)reloadFunctionViewWithData:(NSArray *)functionAry{
    _functionAry=functionAry;
    [_tableView reloadData];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_leftView) {
        return [_leftAry count];
    }
    else{
        return [_functionAry count]/4+([_functionAry count]%4>0?1:0);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * _cellIdentify = @"cell";
    if (tableView==_leftView) {
        NTLeftTableViewCell * iCell = [tableView dequeueReusableCellWithIdentifier:_cellIdentify];
        if (iCell == nil){
            iCell=[[NTLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellIdentify];
        }
        [iCell reloadTheTableCellWithData:[_leftAry objectAtIndex:indexPath.row]];
        tableView.separatorStyle=UITableViewCellSelectionStyleNone;
        return iCell;
    }
    else{
        NTFunctionTableViewCell * iCell = [tableView dequeueReusableCellWithIdentifier:_cellIdentify];
        if (iCell == nil){
            iCell=[[NTFunctionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellIdentify WithMenberNum:4 WithWidth:CGRectGetWidth(_tableView.frame)];
            iCell.delegate=self;
        }
        if (_functionAry.count>=indexPath.row*4+4) {
            [iCell reloadTheTableCellWithData:[_functionAry subarrayWithRange:NSMakeRange(indexPath.row*4,4)]];
        }
        else{
           [iCell reloadTheTableCellWithData:[_functionAry subarrayWithRange:NSMakeRange(indexPath.row*4,_functionAry.count-indexPath.row*4)]];
        }
        tableView.separatorStyle=UITableViewCellSelectionStyleNone;
        return iCell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_leftView) {
        [self leftViewActionWithID:[[[_leftAry objectAtIndex:indexPath.row] objectForKey:@"id"] intValue]];
    }
}

#pragma mark - leftViewSelectAction

- (void)leftViewActionWithID:(int)keyID{
    [_delegate leftViewActionWithID:keyID];
}

#pragma mark - memberSelectAction

- (void)memberSelectAction:(id)sender{
    [_delegate memberSelectAction:sender];
}

@end
