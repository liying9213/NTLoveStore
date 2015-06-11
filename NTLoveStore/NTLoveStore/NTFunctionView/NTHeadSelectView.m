//
//  NTHeadSelectView.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/10.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTHeadSelectView.h"
#import "NTNormalHead.h"
@implementation NTHeadSelectView

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {

    }
    return self ;
}

#pragma mark - resetSelectView
- (void)creatHeadSelectView{
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:self.frame];
    scrollView.backgroundColor=[NTColor colorWithHexString:NTBlueColor];
    [self addSubview:scrollView];
    
    float currentXValue=100;
    float currentWidth=(CGRectGetWidth(self.frame)-200)/_selectData.count;
    
    _selcetBackGroundView=[[UIView alloc] initWithFrame:CGRectMake(currentXValue, CGRectGetHeight(self.frame)-3, currentWidth, 3)];
    _selcetBackGroundView.backgroundColor=[NTColor colorWithHexString:NTPinkColor];
    [scrollView addSubview:_selcetBackGroundView];
    
    for (NSDictionary *dic in _selectData) {
        [self resetSelectBtnWithData:dic WithXValue:currentXValue WithWidthValue:currentWidth WithParentView:scrollView];
        currentXValue+=currentWidth;
    }
}

- (void)resetSelectBtnWithData:(NSDictionary *)dic WithXValue:(float)xValue WithWidthValue:(float)WidthValue WithParentView:(UIScrollView *)view{
    NTButton *selectBtn=[NTButton buttonWithType:UIButtonTypeCustom];
    selectBtn.backgroundColor=[NTColor clearColor];
    [selectBtn setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
    selectBtn.tag=[[dic objectForKey:@"id"] integerValue];
    selectBtn.keyWord=[dic objectForKey:@"key"];
    selectBtn.frame=CGRectMake(xValue, 0, WidthValue, CGRectGetHeight(self.frame));
    [selectBtn setTitleColor:[NTColor colorWithHexString:NTWhiteColor] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(headSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:selectBtn];
    if (_selectTag==selectBtn.tag) {
        [self headSelectAction:selectBtn];
    }
}

#pragma mark - selectAction

- (void)headSelectAction:(id)sender{
    NTButton *btn=(NTButton *)sender;
    CGRect rect=btn.frame;
    rect.origin.y=CGRectGetHeight(btn.frame)-3;
    rect.size.height=3;
    [UIView animateWithDuration:0.25 animations:^{_selcetBackGroundView.frame=rect;}];
    [_delegate headSelectAction:btn];
}

@end