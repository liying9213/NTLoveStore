//
//  NTHomeView.m
//  NTLoveStore
//
//  Created by liying on 15/6/11.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTHomeView.h"
#import <EGOImageLoading/EGOImageView.h>
#import <EGOImageLoading/EGOImageButton.h>
#import "NTReadConfiguration.h"
#import "NTScrollImageView.h"
@implementation NTHomeView

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self ;
}

#pragma mark - resetView

- (void)resetHomeView{
    [self resetScrollImageView];
    [self resetFunctionView];
}

- (void)resetScrollImageView{
    
    NSArray *imagesURL = @[
                           @"http://b.hiphotos.baidu.com/image/pic/item/2934349b033b5bb5085486f834d3d539b600bc31.jpg",
                           @"http://h.hiphotos.baidu.com/image/pic/item/37d3d539b6003af3fd397a66372ac65c1038b631.jpg",
                           @"http://d.hiphotos.baidu.com/image/pic/item/3b87e950352ac65cdb86c075f9f2b21193138a31.jpg"
                           ];
    
    NTScrollImageView *scrollImageView = [NTScrollImageView adScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 132)    imageLinkURL:imagesURL placeHoderImageName:nil   pageControlShowStyle:UIPageControlShowStyleCenter];
    scrollImageView.callBack = ^(NSInteger index,NSString * imageURL)
    {
        [_delegate homeWebSelectAction:imageURL];
    };
    [self addSubview:scrollImageView];
}

- (void)resetFunctionView{
    NSArray *functionArray=[NTReadConfiguration getConfigurationWithKey:@"homeViewData"];
    functionBtnXValue=10;
    functionBtnYValue=142;
    functionBtnHeight=159;
    if (functionArray)
    {
        for (NSDictionary *dic in functionArray) {
            [self resetFunctionButtonWithData:dic];
        }
    }
}

- (void)resetFunctionButtonWithData:(NSDictionary *)data{
    int widthValue=[[data objectForKey:@"width"] intValue];
    int heightValue=[[data objectForKey:@"height"] intValue];
    float width=functionBtnHeight*widthValue+(widthValue-1)*10;
    float height=functionBtnHeight*heightValue+(heightValue-1)*10;
    EGOImageButton *funButton=[[EGOImageButton alloc] initWithPlaceholderImage:nil];
    funButton.backgroundColor=[UIColor clearColor];
    funButton.tag=[[data objectForKey:@"id"] integerValue];
    [funButton setTitle:[data objectForKey:@"name"] forState:UIControlStateNormal];
    funButton.frame=CGRectMake(functionBtnXValue, functionBtnYValue, width, height);
    [funButton setBackgroundColor:[NTColor colorWithHexString:[data objectForKey:@"color"]]];
    [funButton addTarget:self action:@selector(homeSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:funButton];
    if (heightValue>1) {
        moreRect=funButton.frame;
    }
    if (functionBtnXValue+funButton.frame.size.width+10<ScreenWidth) {
        functionBtnXValue+=funButton.frame.size.width+10;
    }
    else if (functionBtnYValue+height+10<CGRectGetHeight(moreRect)+CGRectGetMinY(moreRect)){
        functionBtnXValue=CGRectGetMinX(moreRect)+CGRectGetWidth(moreRect)+10;
        functionBtnYValue+=height+10;
    }
    else {
        functionBtnXValue=10;
        functionBtnYValue+=height+10;
    }
    if (funButton.tag==0) {
        funButton.enabled=NO;
    }
}

#pragma mark - homeSelectAction

- (void)homeSelectAction:(id)sender{
    UIButton *btn=(UIButton *)sender;
    if (btn.tag) {
         [_delegate homeWebSelectAction:nil];
    }
    else{
      [_delegate homeSelectAction:btn];
    }
}
@end
