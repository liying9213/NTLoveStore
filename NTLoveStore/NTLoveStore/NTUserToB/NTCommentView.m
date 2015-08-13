//
//  NTCommentView.m
//  NTLoveStore
//
//  Created by liying on 15/8/13.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTCommentView.h"
#import "NTListTableViewCell.h"
#import "NTColor.h"
#import "NTdefine.h"
#import "NTButton.h"
@implementation NTCommentView

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
        //        iCell.contentInfoView.frame=CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), value*30);
        //        iCell.contentInfoView.backgroundColor=[UIColor yellowColor];
        [iCell.contentInfoView addSubview:[self resetContentViewWith:CGRectMake(0, 0, CGRectGetWidth(rect), value*30)]];
    }
    return iCell;
}

- (UIView *)resetContentViewWith:(CGRect)rect{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:rect];
        UILabel *label=[[UILabel  alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
        label.text=@"商品动态评分：";
        label.font=[UIFont systemFontOfSize:15];
        [_contentView addSubview:label];
        UIView *firstview=[self resetTheStartViewWithTitle:@"宝贝与描述相符：" WithScore:0 withTag:0];
        firstview.frame=CGRectMake(160, 0, 250, 30);
        [_contentView addSubview:firstview];
        UIView *secview=[self resetTheStartViewWithTitle:@"酒店的服务态度：" WithScore:0 withTag:1];
        secview.frame=CGRectMake(160, 40, 250, 30);
        [_contentView addSubview:secview];
        UIView *thirdlyview=[self resetTheStartViewWithTitle:@"宴会的现场效果：" WithScore:0 withTag:2];
        thirdlyview.frame=CGRectMake(160, 80, 250, 30);
        [_contentView addSubview:thirdlyview];
        UIView *fourthlyview=[self resetTheStartViewWithTitle:@"宴会的整体创意：" WithScore:0 withTag:3];
        fourthlyview.frame=CGRectMake(160, 120, 250, 30);
        [_contentView addSubview:fourthlyview];
        
        UILabel *contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 160, 150, 30)];
        contentLabel.text=@"商品追加评论：";
        contentLabel.font=[UIFont systemFontOfSize:15];
        [_contentView addSubview:contentLabel];
        
        UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(160, 160, 700, 300)];
        [_contentView addSubview:textView];
        
        UIButton *saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn.frame=CGRectMake(780,430,90, 30);
        [saveBtn setBackgroundColor:[NTColor colorWithHexString:NTBlueColor]];
        [saveBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateNormal];
        [saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
        [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        saveBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [_contentView addSubview:saveBtn];
    }
    return _contentView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectIndex!=indexPath.row||!_isSelect) {
        _selectIndex=indexPath.row;
        _isSelect=YES;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)resetTheStartViewWithTitle:(NSString *)title WithScore:(int)score withTag:(int)tag{
    UIView *view=[[UIView alloc] init];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text=title;
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    for (int i=0; i<5; i++) {
        NTButton *btn=[NTButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"score_n"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"score_p"] forState:UIControlStateSelected];
        btn.frame=CGRectMake(100+i*25, 5, 20, 20);
        [btn addTarget:self action:@selector(scoreAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.section=tag;
        btn.tag=i;
        if (i<=score) {
            btn.selected=YES;
        }
        [view addSubview:btn];
    }
    return view;
}

- (void)scoreAction:(id)sender{
    NTButton *btn=(NTButton *)sender;
    UIView *view=btn.superview;
    for (UIView *iview in [view subviews]) {
        if ([[iview class]isSubclassOfClass:[NTButton class]]) {
            NTButton *ibtn=(NTButton *)iview;
            if (ibtn.tag<=btn.tag) {
                ibtn.selected=YES;
            }
            else
                ibtn.selected=NO;
        }
    }
}

- (void)getTheContentWithOrderid:(NSString *)orderID{
    [_delegate getTheContentWithOrderid:orderID];
}

- (void)saveAction:(id)sender{
 
    [_delegate saveAction:sender];
}


@end
