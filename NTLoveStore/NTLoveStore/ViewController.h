//
//  ViewController.h
//  NTLoveStore
//
//  Created by 李莹 on 15/6/1.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTParentViewController.h"
#import "NTHeadSelectView.h"
#import "NTFunctionView.h"
#import "NTHomeView.h"
@interface ViewController : NTParentViewController<NTHeadSelectViewDelegate,NTHomeViewDelegate,NTFunctionViewDelegate>
{
    float functionBtnXValue;
    float functionBtnYValue;
}

@property (nonatomic, strong) NTHomeView *homeView;

@property (nonatomic, strong) NTFunctionView *functionView;

@end

