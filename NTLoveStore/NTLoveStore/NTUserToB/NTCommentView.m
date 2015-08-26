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
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
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
    if (_selectIndex==indexPath.row&&_isSelect) {
        return 78+500;
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
    if (_selectIndex==indexPath.row&&_isSelect){
        CGRect rect=iCell.contentInfoView.frame;
        //        iCell.contentInfoView.frame=CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), value*30);
        //        iCell.contentInfoView.backgroundColor=[UIColor yellowColor];
        [iCell.contentInfoView addSubview:[self resetContentViewWith:CGRectMake(0, 0, CGRectGetWidth(rect), 500)]];
    }
    return iCell;
}

- (UIView *)resetContentViewWith:(CGRect)rect{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:rect];
        UILabel *label=[[UILabel  alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
        label.text=@"商品动态评分：";
        label.font=[UIFont systemFontOfSize:15];
        [_contentView addSubview:label];
        UIView *firstview=[self resetTheStartViewWithTitle:@"宝贝与描述相符：" WithScore:0 withTag:0];
        firstview.frame=CGRectMake(130, 0, 280, 30);
        firstview.tag=0;
        [_contentView addSubview:firstview];
        
        UIView *secview=[self resetTheStartViewWithTitle:@"酒店的服务态度：" WithScore:0 withTag:1];
        secview.frame=CGRectMake(130, 40, 280, 30);
        secview.tag=1;
        [_contentView addSubview:secview];
        
        UIView *thirdlyview=[self resetTheStartViewWithTitle:@"宴会的现场效果：" WithScore:0 withTag:2];
        thirdlyview.frame=CGRectMake(130, 80, 280, 30);
        thirdlyview.tag=2;
        [_contentView addSubview:thirdlyview];
        
        UIView *fourthlyview=[self resetTheStartViewWithTitle:@"宴会的整体创意：" WithScore:0 withTag:3];
        fourthlyview.frame=CGRectMake(130, 120, 280, 30);
        fourthlyview.tag=3;
        [_contentView addSubview:fourthlyview];
        
        UILabel *contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 160, 130, 30)];
        contentLabel.text=@"商品追加评论：";
        contentLabel.font=[UIFont systemFontOfSize:15];
        [_contentView addSubview:contentLabel];
        
        _textView=[[UITextView alloc] initWithFrame:CGRectMake(130, 160, 665, 300)];
        _textView.layer.masksToBounds=YES;
        _textView.layer.cornerRadius=4;
        _textView.layer.borderWidth=1;
        _textView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
        [_contentView addSubview:_textView];
        
        UIButton *saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        saveBtn.frame=CGRectMake(710,470,90, 30);
        [saveBtn setBackgroundColor:[NTColor colorWithHexString:NTBlueColor]];
        [saveBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateNormal];
        [saveBtn addTarget:self action:@selector(saveCommentAction:) forControlEvents:UIControlEventTouchUpInside];
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
        _orderID=[_listAry[indexPath.row] objectForKey:@"orderid"];
        [tableView reloadData];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)resetTheStartViewWithTitle:(NSString *)title WithScore:(int)score withTag:(int)tag{
    UIView *view=[[UIView alloc] init];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 30)];
    label.text=title;
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    for (int i=0; i<5; i++) {
        NTButton *btn=[NTButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"score_n"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"score_p"] forState:UIControlStateSelected];
        btn.frame=CGRectMake(130+i*25, 5, 20, 20);
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
    NSInteger value=5;
    for (UIView *iview in [view subviews]) {
        if ([[iview class]isSubclassOfClass:[NTButton class]]) {
            NTButton *ibtn=(NTButton *)iview;
            if (ibtn.tag<=btn.tag) {
                ibtn.selected=YES;
            }
            else
            {
                ibtn.selected=NO;
            }
        }
    }
    [self setTheValue:btn.tag+1 withTag:view.tag];
}

- (void)setTheValue:(NSInteger)value withTag:(NSInteger)tag{
    switch (tag) {
        case 0:
        {
            _firstValue=value;
        }
            break;
        case 1:
        {
            _secValue=value;
        }
            break;
        case 2:
        {
            _thirdlyValue=value;
        }
            break;
        case 3:
        {
            _fourthlyValue=value;
        }
            break;
        default:
            break;
    }
}

- (void)getTheContentWithOrderid:(NSString *)orderID{
    [_delegate getTheContentWithOrderid:orderID];
}

- (void)saveCommentAction:(id)sender{
    if (!_textView.text||_textView.text.length<5) {
        return;
    }
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setObject:_orderID forKey:@"oderid"];
    [dic setObject:[NSNumber numberWithInteger:_firstValue] forKey:@"b"];
    [dic setObject:[NSNumber numberWithInteger:_secValue] forKey:@"j"];
    [dic setObject:[NSNumber numberWithInteger:_thirdlyValue] forKey:@"y"];
    [dic setObject:[NSNumber numberWithInteger:_fourthlyValue] forKey:@"c"];
    [dic setObject:_textView.text forKey:@"tag"];
    [_delegate saveCommentAction:dic];
}


@end
