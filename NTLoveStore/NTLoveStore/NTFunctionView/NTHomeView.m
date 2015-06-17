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
    NSLog(@"===%f---%f",ScreenWidth,ScreenHeight);
    
    [self resetScrollImageView];
    [self resetFunctionView];
}

- (void)resetScrollImageView{
    
    NSArray *imagesURL = @[
                           @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                           @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                           @"http://www.5858baypgs.com/img/aHR0cDovL3BpYzE4Lm5pcGljLmNvbS8yMDEyMDEwNS8xMDkyOTU0XzA5MzE1MTMzOTExNF8yLmpwZw==.jpg"
                           ];
    
    NTScrollImageView *scrollImageView = [NTScrollImageView adScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 127)    imageLinkURL:imagesURL placeHoderImageName:nil   pageControlShowStyle:UIPageControlShowStyleLeft];
    scrollImageView.callBack = ^(NSInteger index,NSString * imageURL)
    {
        [_delegate homeWebSelectAction:imageURL];
    };
    [self addSubview:scrollImageView];
}

- (void)resetFunctionView{
    NSArray *functionArray=[NTReadConfiguration getConfigurationWithKey:@"homeViewData"];
    functionBtnXValue=10;
    functionBtnYValue=137;
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
