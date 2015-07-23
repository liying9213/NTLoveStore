//
//  NTListView.m
//  NTLoveStore
//
//  Created by 李莹 on 15/7/23.
//  Copyright (c) 2015年 liying. All rights reserved.
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
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame)-40)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self addSubview:_tableView];
}

- (void)resetBtnView{
    _allOrderBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _allOrderBtn.frame=CGRectMake(0, 0, 100, 30);
    [_allOrderBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateSelected];
    [_allOrderBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    _allOrderBtn.layer.borderWidth=0.5;
    _allOrderBtn.layer.borderColor=[[NTColor colorWithHexString:NTGrayColor] CGColor];
    _allOrderBtn.backgroundColor=[NTColor whiteColor];
    [_allOrderBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    _allOrderBtn.tag=0;
    [self addSubview:_allOrderBtn];
    [self selectAction:_allOrderBtn];
    
    _finOrderBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _finOrderBtn.frame=CGRectMake(CGRectGetWidth(_allOrderBtn.frame), 0, 100, 30);
    [_finOrderBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateSelected];
    [_finOrderBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    _finOrderBtn.layer.borderWidth=0.5;
    _finOrderBtn.layer.borderColor=[[NTColor colorWithHexString:NTGrayColor] CGColor];
    _finOrderBtn.backgroundColor=[NTColor whiteColor];
    [_finOrderBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    _finOrderBtn.tag=1;
    [self addSubview:_finOrderBtn];
    
    _outOrderBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _outOrderBtn.frame=CGRectMake(CGRectGetWidth(_finOrderBtn.frame)+CGRectGetMinX(_finOrderBtn.frame), 0, 100, 30);
    [_outOrderBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateSelected];
    [_outOrderBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    _outOrderBtn.layer.borderWidth=0.5;
    _outOrderBtn.layer.borderColor=[[NTColor colorWithHexString:NTGrayColor] CGColor];
    _outOrderBtn.backgroundColor=[NTColor whiteColor];
    [_outOrderBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    _outOrderBtn.tag=2;
    [self addSubview:_outOrderBtn];
    
    _payOrderBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _payOrderBtn.frame=CGRectMake(CGRectGetWidth(_outOrderBtn.frame)+CGRectGetMinX(_outOrderBtn.frame), 0, 100, 30);
    [_payOrderBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateSelected];
    [_payOrderBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    _payOrderBtn.layer.borderWidth=0.5;
    _payOrderBtn.layer.borderColor=[[NTColor colorWithHexString:NTGrayColor] CGColor];
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
    [_delegate selectAction:sender];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectIndex==indexPath.row&&_isSelect&&_contentListAry&&_contentListAry.count>0) {
        return 199;
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
    iCell.numLabel.text=_listAry[indexPath.row][@"orderid"];
    iCell.creatDateLabel.text=_listAry[indexPath.row][@"create_time"];
    iCell.telLabel.text=_listAry[indexPath.row][@"send_contact"];
    iCell.nameLabel.text=_listAry[indexPath.row][@"send_name"];
    iCell.priceLabel.text=_listAry[indexPath.row][@"pricetotal"];
    iCell.weddingDateLabel.text=_listAry[indexPath.row][@"time"];
    if (_selectIndex==indexPath.row&&_isSelect&&_contentListAry&&_contentListAry.count>0){
        iCell.contentInfoView=[self resetContentView];
    }    return iCell;
}

- (UIView *)resetContentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        UILabel *label=[[UILabel  alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        label.text=@"所需物品：";
        [_contentView addSubview:label];
        int x=0;
        int y=0;
        for (NSDictionary *dic in _contentListAry) {
            UILabel *infoLabel=[[UILabel alloc] initWithFrame:CGRectMake(x*300+30, y*50, 300, 50)];
            infoLabel.text=[NSString stringWithFormat:@"%@:%@",dic[@"goodid"],dic[@"num"]];
            infoLabel.textAlignment=NSTextAlignmentLeft;
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
}

- (void)getTheContentWithOrderid:(NSString *)orderID{
    [_delegate getTheContentWithOrderid:orderID];
}

@end
