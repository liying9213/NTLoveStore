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
                           @"http://hunhuiwang.xmbt21.com/uploadfile/2015/0113/20150113094734766.jpg",
                           @"http://hunhuiwang.xmbt21.com/uploadfile/2015/0113/20150113094946473.jpg",
                           @"http://hunhuiwang.xmbt21.com/uploadfile/2015/0116/20150116012703220.jpg"
                           ];
    
    NTScrollImageView *scrollImageView = [NTScrollImageView adScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 127)    imageLinkURL:imagesURL placeHoderImageName:nil   pageControlShowStyle:UIPageControlShowStyleCenter];
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
