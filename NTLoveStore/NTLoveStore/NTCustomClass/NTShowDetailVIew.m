//
//  NTShowDetailVIew.m
//  NTLoveStore
//
//  Created by liying on 15/6/30.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTShowDetailVIew.h"
#import "NTNormalHead.h"
#import <EGOImageButton.h>

@implementation NTShowDetailVIew

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
    }
    return self;
}

#pragma mark - showBackGroundView

- (void)resetBackgroundView{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    view.backgroundColor=[NTColor blackColor];
    view.alpha=0.4;
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(colseTheView:)];
    panGestureRecognizer.minimumNumberOfTouches = 1;
    panGestureRecognizer.maximumNumberOfTouches = 1;
    [view addGestureRecognizer:panGestureRecognizer];
    [self addSubview:view];
}

- (void)colseTheView:(UIPanGestureRecognizer*)paramSender{
    self.hidden=YES;
    [self removeFromSuperview];
}

#pragma mark - showImageView

- (void)showImageWithArray:(NSArray *)imageArray{
    [self resetBackgroundView];
    UIView *showView=[[UIView alloc] initWithFrame:CGRectMake(100, 60,ScreenWidth-200, ScreenHeight-120)];
    showView.backgroundColor=[NTColor whiteColor];
    [self addSubview:showView];
    
    _showImageView=[[EGOImageView alloc] initWithPlaceholderImage:thePlaceholderImage];
    _showImageView.imageURL=[NSURL URLWithString:[imageArray objectAtIndex:0]];
    _showImageView.frame=CGRectMake(10, 30, CGRectGetWidth(self.frame)-20, CGRectGetHeight(self.frame)-70);
    [showView addSubview:_showImageView];
    
    float width=10;
    
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(_showImageView.frame)+40, CGRectGetWidth(self.frame)-20, 50)];
    scrollView.scrollEnabled=YES;
    [showView addSubview:scrollView];
    for (NSString *imagePath in imageArray) {
        EGOImageButton *imageBtn=[[EGOImageButton alloc] initWithPlaceholderImage:thePlaceholderImage];
        imageBtn.frame=CGRectMake(width, CGRectGetHeight(_showImageView.frame)+40, 80, 50);
        imageBtn.imageURL=[NSURL URLWithString:imagePath];
        [imageBtn addTarget:self action:@selector(selectImageView:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:imageBtn];
        width+=CGRectGetWidth(imageBtn.frame)+10;
    }
    scrollView.contentSize=CGSizeMake(width, 0);
    [[[[UIApplication sharedApplication] windows] objectAtIndex:0] addSubview:self];
}

- (void)selectImageView:(id)sender{
    EGOImageButton *btn=(EGOImageButton *)sender;
    _showImageView.imageURL=btn.imageURL;
}

#pragma mark - showTextView

- (void)showTextWithString:(NSString *)string{
    [self resetBackgroundView];
    UIView *showView=[[UIView alloc] initWithFrame:CGRectMake(100, 60,ScreenWidth-200, ScreenHeight-120)];
    showView.backgroundColor=[NTColor whiteColor];
    [self addSubview:showView];
    UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.frame)-20, CGRectGetHeight(self.frame)-20)];
    textView.text=string;
    textView.editable=NO;
    [showView addSubview:textView];
    [[[[UIApplication sharedApplication] windows] objectAtIndex:0] addSubview:self];
}

@end
