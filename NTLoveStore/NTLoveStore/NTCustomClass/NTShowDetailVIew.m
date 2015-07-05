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
    self=[super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if (self) {
    }
    return self;
}

#pragma mark - showBackGroundView

- (void)resetBackgroundView{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    view.backgroundColor=[NTColor blackColor];
    view.alpha=0.4;
    view.userInteractionEnabled=YES;
    self.userInteractionEnabled=YES;
    UITapGestureRecognizer *panGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colseTheView:)];
    panGestureRecognizer.delegate=self;
    [view addGestureRecognizer:panGestureRecognizer];
    [self addSubview:view];
}

- (void)colseTheView:(UIPanGestureRecognizer*)paramSender{
    self.hidden=YES;
    [self removeFromSuperview];
}

#pragma mark - showImageView

- (void)showImageWithArray:(NSArray *)imageArray withIndex:(NSInteger)index{
    [self resetBackgroundView];
    UIView *showView=[[UIView alloc] initWithFrame:CGRectMake(70, 40,ScreenWidth-140, 650)];
    showView.backgroundColor=[NTColor whiteColor];
    [self addSubview:showView];
    
    _showImageView=[[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"picple.jpg"]];
    _showImageView.imageURL=[NSURL URLWithString:[imageArray objectAtIndex:index]];
    _showImageView.frame=CGRectMake(10, 40, CGRectGetWidth(showView.frame)-20, CGRectGetHeight(showView.frame)-170);
    _showImageView.backgroundColor=[UIColor clearColor];
    [showView addSubview:_showImageView];
    
    float width=10;
    
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(_showImageView.frame)+50, CGRectGetWidth(_showImageView.frame), 120)];
    scrollView.scrollEnabled=YES;
    scrollView.backgroundColor=[UIColor clearColor];
    [showView addSubview:scrollView];
    for (NSString *imagePath in imageArray) {
        EGOImageButton *imageBtn=[[EGOImageButton alloc] initWithPlaceholderImage:[UIImage  imageNamed:@"picple.jpg"]];
        imageBtn.frame=CGRectMake(width, 0, 160, 110);
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
    UIView *showView=[[UIView alloc] initWithFrame:CGRectMake(70, 40,ScreenWidth-140, ScreenHeight-80)];
    showView.backgroundColor=[NTColor whiteColor];
    [self addSubview:showView];
    UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(showView.frame)-20, CGRectGetHeight(showView.frame)-20)];
    textView.text=string;
    textView.font=[UIFont systemFontOfSize:16];
    textView.editable=NO;
    [showView addSubview:textView];
    [[[[UIApplication sharedApplication] windows] objectAtIndex:0] addSubview:self];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isMemberOfClass:[UIButton class]]) {
        //放过button点击拦截
        return NO;
    }else{
        return YES;
    }
}

@end
