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
    _orderID=1;
    _selectID=0;
    [self resetLeftSelectView];
    [self resetSelectTypeView];
    [self resetTableView];
}

- (void)resetLeftSelectView{
    _leftView=[[UITableView alloc] initWithFrame:CGRectMake(10, 0, 165, CGRectGetHeight(self.frame))];
    _leftView.backgroundColor=[NTColor clearColor];
    _leftView.delegate=self;
    _leftView.dataSource=self;
    _leftView.rowHeight=45;
    [self addSubview:_leftView];
}

- (void)resetSelectTypeView{
    UIView *typeView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_leftView.frame)+20, 0, CGRectGetWidth(self.frame)-CGRectGetWidth(_leftView.frame)-10, 30)];
    typeView.backgroundColor=[NTColor clearColor];
    UIButton *firstBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [firstBtn setTitle:@"综合排序："forState:UIControlStateNormal];
    firstBtn.frame=CGRectMake(0, 0, 105, 30);
//    [firstBtn addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
//    firstBtn.tag=0;
    firstBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [firstBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    firstBtn.layer.borderWidth=1;
    firstBtn.layer.borderColor=[[NTColor colorWithHexString:NTGrayColor] CGColor];
    [typeView addSubview:firstBtn];
    
    UIButton *secBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [secBtn setTitle:@"价格"forState:UIControlStateNormal];
    secBtn.frame=CGRectMake(CGRectGetWidth(firstBtn.frame), 0, 105, 30);
    [secBtn addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
    secBtn.tag=3;
    secBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [secBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    secBtn.layer.borderWidth=1;
    secBtn.layer.borderColor=[[NTColor colorWithHexString:NTGrayColor] CGColor];
    [typeView addSubview:secBtn];
    
    UIButton *thirdBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [thirdBtn setTitle:@"好评数"forState:UIControlStateNormal];
    thirdBtn.frame=CGRectMake(CGRectGetWidth(secBtn.frame)+CGRectGetMinX(secBtn.frame), 0, 105, 30);
    [thirdBtn addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
    thirdBtn.tag=1;
    thirdBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [thirdBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    thirdBtn.layer.borderWidth=1;
    thirdBtn.layer.borderColor=[[NTColor colorWithHexString:NTGrayColor] CGColor];
    [typeView addSubview:thirdBtn];
    
    UIButton *fourBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [fourBtn setTitle:@"销量"forState:UIControlStateNormal];
    fourBtn.frame=CGRectMake(CGRectGetWidth(thirdBtn.frame)+CGRectGetMinX(thirdBtn.frame), 0, 105, 30);
    [fourBtn addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
    fourBtn.tag=4;
    fourBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [fourBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    fourBtn.layer.borderWidth=1;
    fourBtn.layer.borderColor=[[NTColor colorWithHexString:NTGrayColor] CGColor];
    [typeView addSubview:fourBtn];
    
    [self addSubview:typeView];
}

- (void)resetTableView{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_leftView.frame)+20, 35, CGRectGetWidth(self.frame)-CGRectGetWidth(_leftView.frame)-30, CGRectGetHeight(self.frame)-35)];
    _tableView.backgroundColor=[NTColor clearColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=200;
    [self addSubview:_tableView];
}

- (void)resetTableFootView{
    [self getThePrice];
    UIView *footView=[[UIView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(_tableView.frame), 80)];
    footView.backgroundColor=[UIColor clearColor];
    
    UILabel *priceLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 30)];
    priceLabel.text=[NSString stringWithFormat:@"原价:￥%.2lf",_thePrice];
    priceLabel.font=[UIFont systemFontOfSize:14];
    priceLabel.backgroundColor=[UIColor clearColor];
    [footView addSubview:priceLabel];
    
    UILabel *tuanPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(priceLabel.frame)+30, 20, 100, 30)];
    NSMutableAttributedString *tuanPrice=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"现价:￥%.2lf",_theTuanPrice]];
    [tuanPrice addAttribute:NSForegroundColorAttributeName value:[NTColor redColor] range:NSMakeRange(3,tuanPrice.length-3)];
    tuanPriceLabel.attributedText=tuanPrice;
    tuanPriceLabel.font=[UIFont systemFontOfSize:14];
    tuanPriceLabel.backgroundColor=[UIColor clearColor];
    [footView addSubview:tuanPriceLabel];

    UIButton *showBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(tuanPriceLabel.frame)+CGRectGetMinX(tuanPriceLabel.frame)+60, 25, 100, 20)];
    showBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [showBtn setTitle:@"查看现场全景" forState:UIControlStateNormal];
    [showBtn setTitleColor:[NTColor colorWithHexString:NTBlueColor] forState:UIControlStateNormal];
    [footView addSubview:showBtn];
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(_tableView.frame)-120, 50, 120, 30)];
    [btn setTitle:@"立即购买" forState:UIControlStateNormal];
    [btn setTitleColor:[NTColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[NTColor colorWithHexString:NTBlueColor]];
    [footView addSubview:btn];
    _tableView.tableFooterView=footView;
}

- (void)reloadLeftViewWithData:(NSArray *)leftAry{
    _leftAry=leftAry;
    [_leftView reloadData];
    if (_leftAry.count>0) {
        [_leftView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
        [self leftViewActionWithCategory:[[_leftAry objectAtIndex:0] objectForKey:@"name"] WithOrder:_orderID];
    }
}

- (void)reloadFunctionViewWithData:(NSArray *)functionAry{
    _functionAry=functionAry;
    if (_isTheme) {
        [self resetTableFootView];
    }
    else{
        _tableView.tableFooterView.hidden=YES;
    }
    [_tableView reloadData];
}

- (void)getThePrice{
    for (NSDictionary *dic in _functionAry) {
        _thePrice+=[[dic objectForKey:@"price"] floatValue];
        _theTuanPrice+=[[dic objectForKey:@"tuan_price"] floatValue];
    }
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
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
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
        _selectID=indexPath.row;
        [self leftViewActionWithCategory:[[_leftAry objectAtIndex:indexPath.row] objectForKey:@"name"] WithOrder:_orderID];
    }
}

#pragma mark - leftViewSelectAction

- (void)leftViewActionWithCategory:(NSString *)category WithOrder:(NSInteger)orderID{
    [_delegate leftViewActionWithCategory:category WithOrder:orderID];
}

#pragma mark - memberSelectAction

- (void)memberSelectAction:(id)sender{
    [_delegate memberSelectAction:sender];
}

#pragma mark - selectTypeAction

- (void)selectType:(id)sender{
    UIButton *btn=(UIButton *)sender;
    _orderID=btn.tag;
    [self leftViewActionWithCategory:[[_leftAry objectAtIndex:_selectID] objectForKey:@"name"] WithOrder:_orderID];
}

@end
