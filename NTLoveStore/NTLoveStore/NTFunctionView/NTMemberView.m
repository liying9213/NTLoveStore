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
    _imageView=[[EGOImageView alloc] initWithPlaceholderImage:[NTImage imageWithFileName:@"picple.png"]];
    _imageView.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame),  CGRectGetHeight(self.frame)-50);
    [self addSubview:_imageView];
    
    _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_imageView.frame)+5, CGRectGetWidth(self.frame)/2, 20)];
    _titleLabel.font=[UIFont systemFontOfSize:16];
    _titleLabel.backgroundColor=[NTColor clearColor];
    _titleLabel.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    _priceLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_titleLabel.frame), CGRectGetHeight(_imageView.frame)+5, CGRectGetWidth(self.frame)/2, 20)];
    _priceLabel.font=[UIFont systemFontOfSize:16];
    _priceLabel.backgroundColor=[NTColor clearColor];
    _priceLabel.textColor=[NTColor redColor];
    _priceLabel.textAlignment=NSTextAlignmentRight;
    [self addSubview:_priceLabel];
    
    _finishNumLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_imageView.frame)+CGRectGetHeight(_titleLabel.frame)+10, CGRectGetWidth(self.frame)/2, 20)];
    _finishNumLabel.font=[UIFont systemFontOfSize:15];
    _finishNumLabel.backgroundColor=[NTColor clearColor];
    _finishNumLabel.textColor=[NTColor lightGrayColor];
    _finishNumLabel.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_finishNumLabel];
    
    _commentNumLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_finishNumLabel.frame), CGRectGetHeight(_imageView.frame)+CGRectGetHeight(_titleLabel.frame)+10, CGRectGetWidth(self.frame)/2, 20)];
    _commentNumLabel.font=[UIFont systemFontOfSize:15];
    _commentNumLabel.backgroundColor=[NTColor clearColor];
    _commentNumLabel.textColor=[NTColor lightGrayColor];
    _commentNumLabel.textAlignment=NSTextAlignmentRight;
    [self addSubview:_commentNumLabel];
    
    _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _selectBtn.frame=CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [_selectBtn addTarget:self action:@selector(memberSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    _selectBtn.backgroundColor=[NTColor clearColor];
    [self addSubview:_selectBtn];
}

- (void)reloadTheViewWithData:(NSDictionary *)dic{
    _imageView.imageURL=[NSURL URLWithString:[dic objectForKey:@"cover_id"]];
    _titleLabel.text=[dic objectForKey:@"title"];
    _priceLabel.text=[NSString stringWithFormat:@"￥%@",[dic objectForKey:@"price"]];
    _selectBtn.tag=[[dic objectForKey:@"id"] integerValue];
    NSMutableAttributedString *finishNum=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已服务%@人",[dic objectForKey:@"sale"]]];
    [finishNum addAttribute:NSForegroundColorAttributeName value:[NTColor colorWithHexString:NTBlueColor] range:NSMakeRange(3,finishNum.length-4)];
    NSMutableAttributedString *commentNum=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"好评数%@条",[dic objectForKey:@"comment"]]];
    [commentNum addAttribute:NSForegroundColorAttributeName value:[NTColor colorWithHexString:NTBlueColor] range:NSMakeRange(3,commentNum.length-4)];
    _finishNumLabel.attributedText=finishNum;
    _commentNumLabel.attributedText=commentNum;

}

#pragma mark - memberAction

- (void)memberSelectAction:(id)sender{
    [_delegate memberSelectAction:sender];
}

@end
