//
//  NTContentViewController.h
//  NTLoveStore
//
//  Created by liying on 15/6/13.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTParentViewController.h"

@interface NTContentViewController : NTParentViewController

@property (nonatomic, strong)NSDictionary *contentDic;

@property (nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic, strong)UIView *contenInfoView;

@property (nonatomic, strong)UIScrollView *imageInfoView;

@property (nonatomic, strong)UIScrollView *videoInfoView;

@property (nonatomic, strong)UIView *commentInfoView;

@property (nonatomic, assign)NSInteger productID;

@property (nonatomic, strong)NSDictionary *detailDic;

@property (nonatomic, strong)NSArray *imageAry;

@property (nonatomic, strong)NSMutableArray *videoAry;

@property (nonatomic) float heightValue;

@property (nonatomic) BOOL isCanSelect;

@end
