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

@property (nonatomic, strong)UIView *imageInfoView;

@property (nonatomic, strong)UIView *videoInfoView;

@property (nonatomic, strong)UIView *commentInfoView;

@property (nonatomic, assign)int productID;

@end
