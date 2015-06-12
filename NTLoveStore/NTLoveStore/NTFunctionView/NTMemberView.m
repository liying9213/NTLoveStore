//
//  NTMemberView.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/12.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTMemberView.h"
#import "NTNormalHead.h"
#import <EGOImageLoading/EGOImageView.h>

@implementation NTMemberView

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - resetView

- (void)resetView{
    EGOImageView *imageView=[[EGOImageView alloc] initWithPlaceholderImage:nil];
    imageView.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame),  CGRectGetHeight(self.frame)-40);
    imageView.imageURL=[NSURL URLWithString:[_memberDic objectForKey:@"imagePath"]];
    [self addSubview:imageView];
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(imageView.frame), CGRectGetWidth(self.frame)/2, 20)];
    titleLabel.backgroundColor=[NTColor clearColor];
    titleLabel.text=[_memberDic objectForKey:@"name"];
    titleLabel.textAlignment=NSTextAlignmentLeft;
    [self addSubview:titleLabel];
    
    UILabel *priceLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame), CGRectGetWidth(self.frame)/2, 20)];
    priceLabel.backgroundColor=[NTColor clearColor];
    priceLabel.text=[_memberDic objectForKey:@"price"];
    priceLabel.textAlignment=NSTextAlignmentRight;
    [self addSubview:priceLabel];
    
    UILabel *finishNumLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(imageView.frame)+CGRectGetHeight(titleLabel.frame), CGRectGetWidth(self.frame)/2, 20)];
    finishNumLabel.backgroundColor=[NTColor clearColor];
    finishNumLabel.text=[_memberDic objectForKey:@"num"];
    finishNumLabel.textAlignment=NSTextAlignmentLeft;
    [self addSubview:finishNumLabel];
    
    UILabel *commentNumLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(finishNumLabel.frame), CGRectGetHeight(imageView.frame)+CGRectGetHeight(titleLabel.frame), CGRectGetWidth(self.frame)/2, 20)];
    commentNumLabel.backgroundColor=[NTColor clearColor];
    commentNumLabel.text=[_memberDic objectForKey:@"ComNum"];
    commentNumLabel.textAlignment=NSTextAlignmentRight;
    [self addSubview:commentNumLabel];
    
    UIButton *selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [selectBtn addTarget:self action:@selector(memberSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    selectBtn.backgroundColor=[NTColor clearColor];
    selectBtn.tag=[[_memberDic objectForKey:@"id"] integerValue];
    [self addSubview:selectBtn];
}

#pragma mark - memberAction

- (void)memberSelectAction:(id)sender{
    [_delegate memberSelectAction:sender];
}

@end
