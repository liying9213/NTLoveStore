//
//  NTFollowListView.m
//  NTLoveStore
//
//  Created by liying on 15/7/23.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTFollowListView.h"
#import "NTFollowListTableViewCell.h"
#import "NTColor.h"
#import "NTdefine.h"
#import "NTButton.h"
@implementation NTFollowListView

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)resetView{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame)-40)];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self addSubview:_tableView];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _followListAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectIndex==indexPath.row&&_isSelect&&_contentListAry&&_contentListAry.count>0) {
        long value=[_contentListAry count]/2;
        if ([_contentListAry count]%2>0) {
            value=value+1;
        }
        return 78+value*30+5;
    }
    else{
        return 78;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * _cellIdentify = @"cell";
    NTFollowListTableViewCell * iCell = [tableView dequeueReusableCellWithIdentifier:_cellIdentify];
    if (iCell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"NTFollowListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        iCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    }
    iCell.numLabel.text=_followListAry[indexPath.row][@"orderid"];
    iCell.creatDateLabel.text=_followListAry[indexPath.row][@"create_time"];
    iCell.telLabel.text=_followListAry[indexPath.row][@"send_contact"];
    iCell.nameLabel.text=_followListAry[indexPath.row][@"send_name"];
    iCell.priceLabel.text=_followListAry[indexPath.row][@"pricetotal"];
    iCell.weddingDateLabel.text=_followListAry[indexPath.row][@"time"];
    [iCell.codeButton addTarget:self action:@selector(showCodeImage:) forControlEvents:UIControlEventTouchUpInside];
    if (_selectIndex==indexPath.row&&_isSelect&&_contentListAry&&_contentListAry.count>0){
        long value=[_contentListAry count]/2;
        if ([_contentListAry count]%2>0) {
            value=value+1;
        }
        CGRect rect=iCell.contentInfoView.frame;
        iCell.contentInfoView.frame=CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), value*30);
        [iCell.contentInfoView addSubview:[self resetContentViewWith:CGRectMake(0, 0, CGRectGetWidth(rect), value*30)]];
    }
    if (!_isSelect) {
        CGRect rect=iCell.contentInfoView.frame;
        iCell.contentInfoView.frame=CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), 0);
    }
    return iCell;
}

- (UIView *)resetContentViewWith:(CGRect)rect{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:rect];
        UILabel *label=[[UILabel  alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
        label.text=@"所需物品：";
        label.font=[UIFont systemFontOfSize:15];
        [_contentView addSubview:label];
        int x=0;
        int y=0;
        int i=0;
        for (NSDictionary *dic in _contentListAry) {
            NTButton *btn=[NTButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(x*330+150, y*30, 30, 30);
            btn.keyWord=_keyAry[i];
            [btn setImage:[UIImage imageNamed:@"disSelect"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            [_contentView addSubview:btn];
            if ([dic[@"status"] intValue]==1) {
                btn.selected=YES;
            }
            UILabel *infoLabel=[[UILabel alloc] initWithFrame:CGRectMake(x*330+180, y*30, 300, 30)];
            infoLabel.text=[NSString stringWithFormat:@"%@:%@",dic[@"goodid"],dic[@"num"]];
            infoLabel.textAlignment=NSTextAlignmentLeft;
            infoLabel.font=[UIFont systemFontOfSize:15];
            [_contentView addSubview:infoLabel];
            if (x==0) {
                x++;
            }
            else{
                x=0;
                y++;
            }
            i++;
        }
    }
    return _contentView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectIndex!=indexPath.row||!_isSelect) {
        _selectIndex=indexPath.row;
        _isSelect=YES;
        [self getTheContentWithOrderid:_followListAry[indexPath.row][@"orderid"]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)getTheContentWithOrderid:(NSString *)orderID{
    [_delegate getTheContentWithOrderid:orderID];
}

- (void)showCodeImage:(id)sender{
    [_delegate showCodeImage:sender];
}

- (void)selectAction:(id)sender{
    NTButton *btn=(NTButton *)sender;
    btn.selected=!btn.selected;
}

@end
