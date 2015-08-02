//
//  NTPayCodeView.m
//  NTLoveStore
//
//  Created by liying on 15/8/2.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTPayCodeView.h"
#import "NTdefine.h"
@implementation NTPayCodeView

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void) showThepayCodeView{
    [self resetView];
    UITapGestureRecognizer *panGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colseTheView:)];
    panGestureRecognizer.delegate=self;
    [self addGestureRecognizer:panGestureRecognizer];
    [[[[UIApplication sharedApplication] windows] objectAtIndex:0] addSubview:self];
}

- (void)resetView{
    _payCodeImageView=[[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"picple.png"]];
    _payCodeImageView.frame=CGRectMake((ScreenWidth-400)/2, (ScreenHeight-400)/2, 400, 400);
    _payCodeImageView.imageURL=[NSURL URLWithString:_imagePath];
    [self addSubview:_payCodeImageView];
}

- (void)colseTheView:(UIPanGestureRecognizer*)paramSender{
    _closeBlock();
    self.hidden=YES;
    [self removeFromSuperview];
}

@end
