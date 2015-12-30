//
//  NTListView.m
//  NTLoveStore
//
//  Created by NTTian on 15/7/23.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import "NTListView.h"
#import "NTColor.h"
#import "NTdefine.h"
#import "NTListTableViewCell.h"
@implementation NTListView

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)resetView{
    [self resetBtnView];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-40)];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self addSubview:_tableView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), 200)];
    label.text = @"您还未产生订单！";
    label.textAlignment = NSTextAlignmentCenter;
    _tableView.backgroundView = label;
    
}

- (void)resetBtnView{
    _allOrderBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _allOrderBtn.frame=CGRectMake(0, 0, 100, 30);
    [_allOrderBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateSelected];
    [_allOrderBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    [_allOrderBtn setTitle:@"所有订单" forState:UIControlStateNormal];
    _allOrderBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    _allOrderBtn.layer.borderWidth=1;
    _allOrderBtn.layer.borderColor=[[NTColor colorWithHexString:@"E3E3E3"] CGColor];
    _allOrderBtn.backgroundColor=[NTColor whiteColor];
    [_allOrderBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    _allOrderBtn.tag=0;
    [self addSubview:_allOrderBtn];
    [self selectAction:_allOrderBtn];
    
    _finOrderBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _finOrderBtn.frame=CGRectMake(CGRectGetWidth(_allOrderBtn.frame), 0, 100, 30);
    [_finOrderBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateSelected];
    [_finOrderBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    [_finOrderBtn setTitle:@"已完成订单" forState:UIControlStateNormal];
    _finOrderBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    _finOrderBtn.layer.borderWidth=1;
    _finOrderBtn.layer.borderColor=[[NTColor colorWithHexString:@"E3E3E3"] CGColor];
    _finOrderBtn.backgroundColor=[NTColor whiteColor];
    [_finOrderBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    _finOrderBtn.tag=1;
    [self addSubview:_finOrderBtn];
    
    _outOrderBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _outOrderBtn.frame=CGRectMake(CGRectGetWidth(_finOrderBtn.frame)+CGRectGetMinX(_finOrderBtn.frame), 0, 100, 30);
    [_outOrderBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateSelected];
    [_outOrderBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    [_outOrderBtn setTitle:@"未完成订单" forState:UIControlStateNormal];
    _outOrderBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    _outOrderBtn.layer.borderWidth=1;
    _outOrderBtn.layer.borderColor=[[NTColor colorWithHexString:@"E3E3E3"] CGColor];
    _outOrderBtn.backgroundColor=[NTColor whiteColor];
    [_outOrderBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    _outOrderBtn.tag=2;
    [self addSubview:_outOrderBtn];
    
    _payOrderBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _payOrderBtn.frame=CGRectMake(CGRectGetWidth(_outOrderBtn.frame)+CGRectGetMinX(_outOrderBtn.frame), 0, 100, 30);
    [_payOrderBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateSelected];
    [_payOrderBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    [_payOrderBtn setTitle:@"未支付订单" forState:UIControlStateNormal];
    _payOrderBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    _payOrderBtn.layer.borderWidth=1;
    _payOrderBtn.layer.borderColor=[[NTColor colorWithHexString:@"E3E3E3"] CGColor];
    _payOrderBtn.backgroundColor=[NTColor whiteColor];
    [_payOrderBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    _payOrderBtn.tag=3;
    [self addSubview:_payOrderBtn];
    
}

- (void)selectAction:(id)sender{
    _allOrderBtn.backgroundColor=[NTColor whiteColor];
    _allOrderBtn.selected=NO;
    _finOrderBtn.backgroundColor=[NTColor whiteColor];
    _finOrderBtn.selected=NO;
    _outOrderBtn.backgroundColor=[NTColor whiteColor];
    _outOrderBtn.selected=NO;
    _payOrderBtn.backgroundColor=[NTColor whiteColor];
    _payOrderBtn.selected=NO;
    UIButton *btn=(UIButton *)sender;
    btn.backgroundColor=[NTColor colorWithHexString:NTBlueColor];
    btn.selected=YES;
    _isSelect=NO;
    [_contentView removeFromSuperview];
    _contentView=nil;
    [_delegate selectAction:sender];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listAry.count;
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
    NTListTableViewCell * iCell = [tableView dequeueReusableCellWithIdentifier:_cellIdentify];
    if (iCell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"NTListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        iCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    }
    iCell.selectionStyle=UITableViewCellSelectionStyleNone;
    iCell.numLabel.text=_listAry[indexPath.row][@"orderid"];
    iCell.creatDateLabel.text=_listAry[indexPath.row][@"create_time"];
    iCell.telLabel.text=_listAry[indexPath.row][@"send_contact"];
    iCell.nameLabel.text=_listAry[indexPath.row][@"send_name"];
    iCell.priceLabel.text=_listAry[indexPath.row][@"pricetotal"];
    iCell.weddingDateLabel.text=_listAry[indexPath.row][@"time"];
    if (_selectIndex==indexPath.row&&_isSelect&&_contentListAry&&_contentListAry.count>0){
        long value=[_contentListAry count]/2;
        if ([_contentListAry count]%2>0) {
            value=value+1;
        }
        CGRect rect=iCell.contentInfoView.frame;
        [iCell.contentInfoView addSubview:[self resetContentViewWith:CGRectMake(0, 0, CGRectGetWidth(rect), value*30)]];
    }
    return iCell;
}

- (UIView *)resetContentViewWith:(CGRect)rect{
    if (_contentView) {
        [_contentView removeFromSuperview];
        _contentView=nil;
    }
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:rect];
        UILabel *label=[[UILabel  alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
        label.text=@"所需物品：";
        label.font=[UIFont systemFontOfSize:15];
        [_contentView addSubview:label];
        int x=0;
        int y=0;
        for (NSDictionary *dic in _contentListAry) {
            UILabel *infoLabel=[[UILabel alloc] initWithFrame:CGRectMake(x*300+150, y*30, 300, 30)];
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
        }
    }
    return _contentView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectIndex!=indexPath.row||!_isSelect) {
        _selectIndex=indexPath.row;
        _isSelect=YES;
        [self getTheContentWithOrderid:_listAry[indexPath.row][@"orderid"]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)getTheContentWithOrderid:(NSString *)orderID{
    [_delegate getTheContentWithOrderid:orderID];
}

@end
