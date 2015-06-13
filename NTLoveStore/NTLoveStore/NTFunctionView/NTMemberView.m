//
//  NTMemberView.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/12.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTMemberView.h"

@implementation NTMemberView

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - resetView

- (void)resetView{
    _imageView=[[EGOImageView alloc] initWithPlaceholderImage:nil];
    _imageView.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame),  CGRectGetHeight(self.frame)-40);
    [self addSubview:_imageView];
    
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_imageView.frame), CGRectGetWidth(self.frame)/2, 20)];
    _titleLabel.font=[UIFont systemFontOfSize:15];
    _titleLabel.backgroundColor=[NTColor clearColor];
    _titleLabel.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    _priceLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_titleLabel.frame), CGRectGetHeight(_imageView.frame), CGRectGetWidth(self.frame)/2, 20)];
    _priceLabel.backgroundColor=[NTColor clearColor];
    _priceLabel.textAlignment=NSTextAlignmentRight;
    [self addSubview:_priceLabel];
    
    _finishNumLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_imageView.frame)+CGRectGetHeight(_titleLabel.frame), CGRectGetWidth(self.frame)/2, 20)];
    _finishNumLabel.backgroundColor=[NTColor clearColor];
    _finishNumLabel.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_finishNumLabel];
    
    _commentNumLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_finishNumLabel.frame), CGRectGetHeight(_imageView.frame)+CGRectGetHeight(_titleLabel.frame), CGRectGetWidth(self.frame)/2, 20)];
    _commentNumLabel.backgroundColor=[NTColor clearColor];
    _commentNumLabel.textAlignment=NSTextAlignmentRight;
    [self addSubview:_commentNumLabel];
    
    _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _selectBtn.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [_selectBtn addTarget:self action:@selector(memberSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    _selectBtn.backgroundColor=[NTColor clearColor];
    [self addSubview:_selectBtn];
}

- (void)reloadTheViewWithData:(NSDictionary *)dic{
    _imageView.imageURL=[NSURL URLWithString:[dic objectForKey:@"imagePath"]];
    _titleLabel.text=[dic objectForKey:@"name"];
    _priceLabel.text=[dic objectForKey:@"price"];
    _finishNumLabel.text=[dic objectForKey:@"num"];
    _commentNumLabel.text=[dic objectForKey:@"ComNum"];
    _selectBtn.tag=[[dic objectForKey:@"id"] integerValue];
}

#pragma mark - memberAction

- (void)memberSelectAction:(id)sender{
    [_delegate memberSelectAction:sender];
}

@end
