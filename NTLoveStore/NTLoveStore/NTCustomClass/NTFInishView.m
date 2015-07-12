//
//  NTFInishView.m
//  NTLoveStore
//
//  Created by liying on 15/7/11.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTFInishView.h"
#import "NTdefine.h"
@implementation NTFInishView

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void) showTheFinishView{
    [self resetView];
    [[[[UIApplication sharedApplication] windows] objectAtIndex:0] addSubview:self];
}

- (void)resetView{
    UIView *bgView=[[UIView alloc] initWithFrame:self.frame];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0.4;
    [self addSubview:bgView];
    
    UITapGestureRecognizer *panGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colseTheView:)];
    panGestureRecognizer.delegate=self;
    [bgView addGestureRecognizer:panGestureRecognizer];
    
    UIView *whiteView=[[UIView alloc] initWithFrame:CGRectMake(210,( ScreenHeight-185)/2, 610, 185)];
    whiteView.backgroundColor=[UIColor whiteColor];
    [self addSubview:whiteView];
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(170, 45, 90, 90)];
    imageView.image=[UIImage imageNamed:@"right"];
    [whiteView addSubview:imageView];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(270, 70, 150, 45)];
    label.font=[UIFont systemFontOfSize:17];
    label.text=@"恭喜您保存成功！";
    [whiteView addSubview:label];
}

- (void)colseTheView:(UIPanGestureRecognizer*)paramSender{
    _closeBlock();
    self.hidden=YES;
    [self removeFromSuperview];
}

@end
