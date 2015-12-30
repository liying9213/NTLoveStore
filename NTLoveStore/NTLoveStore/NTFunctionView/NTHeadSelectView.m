//
//  NTHeadSelectView.m
//  NTLoveStore
//
//  Created by NTTian on 15/6/10.
//  Copyright (c) 2015年 NTTian. All rights reserved.
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
    _scrollView=[[UIScrollView alloc] initWithFrame:self.frame];
    _scrollView.backgroundColor=[NTColor colorWithHexString:NTBlueColor];
    [self addSubview:_scrollView];
    
    float currentXValue=100;
    float currentWidth=(CGRectGetWidth(self.frame)-200)/_selectData.count;
    
    _selcetBackGroundView=[[UIView alloc] initWithFrame:CGRectMake(currentXValue+5, CGRectGetHeight(self.frame)-3, currentWidth-10, 3)];
    _selcetBackGroundView.backgroundColor=[NTColor colorWithHexString:NTPinkColor];
    [_scrollView addSubview:_selcetBackGroundView];
    
    int i=0;
    for (NSDictionary *dic in _selectData) {
        i++;
        [self resetSelectBtnWithData:dic WithXValue:currentXValue WithWidthValue:currentWidth WithParentView:_scrollView];
        currentXValue+=currentWidth;
        if (i!=_selectData.count) {
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(currentXValue-2, (CGRectGetHeight(self.frame)-28)/2, 2, 28)];
//            imageView.backgroundColor=[NTColor colorWithHexString:@"#6BDEE2"];
            imageView.image=[NTImage imageNamed:@"interval"];
            [_scrollView addSubview:imageView];
        }
    }
    _selectData=nil;
}

- (void)resetSelectBtnWithData:(NSDictionary *)dic WithXValue:(float)xValue WithWidthValue:(float)WidthValue WithParentView:(UIScrollView *)view{
    NTButton *selectBtn=[NTButton buttonWithType:UIButtonTypeCustom];
    selectBtn.backgroundColor=[NTColor clearColor];
    [selectBtn setTitle:[dic objectForKey:@"title"] forState:UIControlStateNormal];
    selectBtn.tag=[[dic objectForKey:@"id"] integerValue];
    selectBtn.keyWord=[dic objectForKey:@"name"];
    selectBtn.frame=CGRectMake(xValue, 0, WidthValue, CGRectGetHeight(self.frame));
    [selectBtn setTitleColor:[NTColor colorWithHexString:NTWhiteColor] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(headSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:selectBtn];
    if (_selectTag==selectBtn.tag) {
        [self headSelectAction:selectBtn];
    }
}

#pragma mark - selectAction

- (void)selectTheTag:(NSInteger)tag{
    for (id body in _scrollView.subviews) {
        if ([[body class] isSubclassOfClass:[NTButton class]]) {
            if ([(NTButton *)body tag]==tag) {
                [self headSelectAction:body];
            }
        }
    }
}

- (void)headSelectAction:(id)sender{
    NTButton *btn=(NTButton *)sender;
    if ([share()userIsLogin]) {
        CGRect rect=btn.frame;
        rect.origin.x=CGRectGetMinX(btn.frame)+15;
        rect.origin.y=CGRectGetHeight(btn.frame)-3;
        rect.size.height=3;
        rect.size.width=CGRectGetWidth(btn.frame)-30;
        [UIView animateWithDuration:0.25 animations:^{
            _selcetBackGroundView.frame=rect;
        }];
    }
    [_delegate headSelectAction:btn];
}

@end
