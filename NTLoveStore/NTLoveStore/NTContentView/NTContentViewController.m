//
//  NTContentViewController.m
//  NTLoveStore
//
//  Created by liying on 15/6/13.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTContentViewController.h"

@interface NTContentViewController ()

@end

@implementation NTContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getTheContentData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - getContentData

- (void)getTheContentData{
    [self resetView];
}

#pragma mark - resetView

- (void)resetView{
    _scrollView=[[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.backgroundColor=[NTColor clearColor];
    [self.view addSubview:_scrollView];
    
    EGOImageView *imageView=[[EGOImageView alloc] initWithPlaceholderImage:nil];
    imageView.frame=CGRectMake(10, 10, ScreenWidth/2-15, ScreenWidth/3);
    imageView.imageURL=[NSURL URLWithString:@"http://hunhuiwang.xmbt21.com/uploadfile/2014/1219/20141219115629964.jpg"];
    [_scrollView addSubview:imageView];
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(imageView.frame)+20, 30, ScreenWidth/2-15, 30)];
    titleLabel.backgroundColor=[NTColor clearColor];
    titleLabel.text=@"资深婚礼主持人";
    [_scrollView addSubview:titleLabel];
    
    UILabel *priceLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetHeight(titleLabel.frame)+CGRectGetMinY(titleLabel.frame), 60, 30)];
    priceLabel.backgroundColor=[NTColor clearColor];
    priceLabel.text=@"价格：";
    [_scrollView addSubview:priceLabel];
    
    UILabel *price=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(priceLabel.frame)+CGRectGetWidth(priceLabel.frame),CGRectGetMinY(priceLabel.frame), CGRectGetWidth(titleLabel.frame)-40, 30)];
    price.backgroundColor=[NTColor clearColor];
    price.text=@"￥2000";
    [_scrollView addSubview:price];
    
    
    
}

@end
