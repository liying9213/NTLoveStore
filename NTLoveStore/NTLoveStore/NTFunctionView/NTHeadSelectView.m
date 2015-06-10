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
    scrollView.backgroundColor=[NTColor clearColor];
    [self addSubview:scrollView];
    
    float currentXValue=0;
    float currentWidth=CGRectGetWidth(self.frame)/_selectData.count;
    
    _selcetBackGroundView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, currentWidth, CGRectGetHeight(self.frame))];
    _selcetBackGroundView.backgroundColor=[NTColor lightGrayColor];
    [self addSubview:_selcetBackGroundView];
    for (NSDictionary *dic in _selectData) {
        [self resetSelectBtnWithData:dic WithXValue:currentXValue WithWidthValue:currentWidth WithParentView:scrollView];
        currentXValue+=currentWidth;
    }
}

- (void)resetSelectBtnWithData:(NSDictionary *)dic WithXValue:(float)xValue WithWidthValue:(float)WidthValue WithParentView:(UIScrollView *)view{
    UIButton *selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.backgroundColor=[NTColor clearColor];
    [selectBtn setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
    selectBtn.tag=[[dic objectForKey:@"id"] integerValue];
    selectBtn.frame=CGRectMake(xValue, 0, WidthValue, CGRectGetHeight(self.frame));
    [selectBtn addTarget:self action:@selector(headSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:selectBtn];
}

#pragma mark - selectAction

- (void)headSelectAction:(id)sender{
    UIButton *btn=(UIButton *)sender;
    [UIView animateWithDuration:0.25 animations:^{_selcetBackGroundView.frame=btn.frame;}];
    [_delegate headSelectAction:btn];
}

@end
