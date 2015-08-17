//
//  NTHomeView.m
//  NTLoveStore
//
//  Created by liying on 15/6/11.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTHomeView.h"
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
    
    NSArray *adArray=[NTUserDefaults getTheDataForKey:@"scrollADData"];
    if (nil==adArray||!adArray.count>0) {
        return;
    }
    NSMutableArray *imagesURLAry=[[NSMutableArray alloc] init];
    for (NSDictionary *dic in adArray) {
        [imagesURLAry addObject:[dic objectForKey:@"icon"]];
    }
    NTScrollImageView *scrollImageView = [NTScrollImageView adScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 132)    imageLinkURL:imagesURLAry placeHoderImageName:@"picple.png"   pageControlShowStyle:UIPageControlShowStyleCenter];
    scrollImageView.callBack = ^(NSInteger index,NSString * imageURL)
    {
        [_delegate homeWebSelectAction:[[adArray objectAtIndex:index] objectForKey:@"url"]];
    };
    [self addSubview:scrollImageView];
    adArray = nil;
}

- (void)resetFunctionView{
    NSArray *functionArray=[NTUserDefaults getTheDataForKey:@"homeData"];
    if (nil==functionArray||functionArray.count!=10) {
        functionArray=[NTReadConfiguration getConfigurationWithKey:@"homeViewData"];
    }
    functionBtnXValue=10;
    functionBtnYValue=142;
    functionBtnHeight=159;
    if (functionArray)
    {
        for (NSDictionary *dic in functionArray) {
            [self resetFunctionButtonWithData:dic];
        }
    }
    functionArray=nil;
}

- (void)resetFunctionButtonWithData:(NSDictionary *)data{
    float widthValue=[[data objectForKey:@"width"] floatValue];
    int heightValue=[[data objectForKey:@"height"] intValue];
    int typeValue=[[data objectForKey:@"type"] intValue];
    float width=functionBtnHeight*widthValue+(widthValue-1)*10;
    float height=functionBtnHeight*heightValue+(heightValue-1)*10;
    NTButton *funButton=[NTButton buttonWithType:UIButtonTypeCustom];
    if (typeValue==0) {
        [funButton sd_setImageWithURL:[NSURL URLWithString:[data objectForKey:@"icon"]] forState:UIControlStateNormal placeholderImage:thePlaceholderImage];
        funButton.tag=0;
        funButton.contentPath=[data objectForKey:@"url"];
    }
    else{
        [funButton setImage:[NTImage imageWithFileName:[data objectForKey:@"imageName"]] forState:UIControlStateNormal];
        funButton.tag=[[data objectForKey:@"id"] integerValue];
    }
    funButton.backgroundColor=[UIColor clearColor];
    funButton.frame=CGRectMake(functionBtnXValue, functionBtnYValue, width, height);
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
}

#pragma mark - homeSelectAction

- (void)homeSelectAction:(id)sender{
    NTButton *btn=(NTButton *)sender;
    if (btn.tag==0) {
         [_delegate homeWebSelectAction:btn.contentPath];
    }
    else{
      [_delegate homeSelectAction:sender];
    }
}
@end
