//
//  NTContentViewController.m
//  NTLoveStore
//
//  Created by liying on 15/6/13.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTContentViewController.h"
#import "NTAsynService.h"
@interface NTContentViewController ()

@end

@implementation NTContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showWaitingViewWithText:@"正在加载..."];
    [self getTheContentData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - getContentData

- (void)getTheContentData{
    __weak typeof(self) __weakself=self;
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"id":[NSNumber numberWithInteger:_productID]};
    [NTAsynService requestWithHead:detileBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            _detailDic=finishData;
            [self resetView];
            [self resetContentView];
            [self hideWaitingView];
        }
        else{
            __strong typeof(self) self=__weakself;
            [self showEndViewWithText:connectionError.localizedDescription];
        }
    }];
    dic=nil;
    /*
     id	string	商品ID
     title	string	商品名称
     content	string	商品详情（包括视频）
     price	string	商品单价
     cover_id	string	商品主图片地址
     pics	string	商品展示图集 多个地址使用逗号隔开
     sale	string	卖出商品数量
     comment	string	商品评论数
     
     {
     "id": "100",
     "title": "truss架",
     "content": "这是商品简介",
     "price": "66.00",
     "cover_id": "http://127.0.0.1/Uploads/Picture/2015-06-24/558ab221b7b3a.png",
     "pics":"http://../Uploads/Picture/2015/3a.png,http://../Uploads/Picture/2015/3a.png",
     "sale": "0",
     "comment": "0"
     }
     
     */
}

#pragma mark - resetView

- (void)resetView{
    _scrollView=[[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.backgroundColor=[NTColor clearColor];
    [self.view addSubview:_scrollView];
    
    EGOImageView *imageView=[[EGOImageView alloc] initWithPlaceholderImage:[NTImage imageWithFileName:@"picple.jpg"]];
    imageView.frame=CGRectMake(10, 10, ScreenWidth/2+30, ScreenWidth/3);
    imageView.imageURL=[NSURL URLWithString:[_detailDic objectForKey:@"cover_id"]];
    [_scrollView addSubview:imageView];
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(imageView.frame)+20, 30, ScreenWidth/2-15, 30)];
    titleLabel.backgroundColor=[NTColor clearColor];
    titleLabel.text=[_detailDic objectForKey:@"title"];
    [_scrollView addSubview:titleLabel];
    
    UILabel *priceLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetHeight(titleLabel.frame)+CGRectGetMinY(titleLabel.frame)+10, CGRectGetWidth(titleLabel.frame), 30)];
    priceLabel.backgroundColor=[NTColor clearColor];
    priceLabel.text=[NSString stringWithFormat:@"价格:￥%@",[_detailDic objectForKey:@"price"]];
    [_scrollView addSubview:priceLabel];
    
    UILabel *finishNumLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetHeight(priceLabel.frame)+CGRectGetMinY(priceLabel.frame)+10, CGRectGetWidth(titleLabel.frame)/2, 30)];
    finishNumLabel.font=[UIFont systemFontOfSize:14];
    finishNumLabel.backgroundColor=[NTColor clearColor];
    finishNumLabel.text=[NSString stringWithFormat:@"服务次数：%@",[_detailDic objectForKey:@"sale"]];
    finishNumLabel.textColor=[NTColor blackColor];
    finishNumLabel.textAlignment=NSTextAlignmentLeft;
    [_scrollView addSubview:finishNumLabel];
    
    UILabel *commentNumLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(finishNumLabel.frame)+CGRectGetMinX(finishNumLabel.frame), CGRectGetMinY(finishNumLabel.frame), CGRectGetWidth(finishNumLabel.frame)/2, 30)];
    commentNumLabel.font=[UIFont systemFontOfSize:14];
    commentNumLabel.backgroundColor=[NTColor clearColor];
    commentNumLabel.text=[NSString stringWithFormat:@"评论：%@",[_detailDic objectForKey:@"comment"]];
    commentNumLabel.textColor=[NTColor blackColor];
    commentNumLabel.textAlignment=NSTextAlignmentLeft;
    [_scrollView addSubview:commentNumLabel];
    
    UIButton *selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateNormal];
    [selectBtn setTitle:@"立即预定" forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    selectBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [selectBtn setBackgroundColor:[NTColor colorWithHexString:NTBlueColor]];
    selectBtn.frame=CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetHeight(finishNumLabel.frame)+CGRectGetMinY(finishNumLabel.frame)+100, 300, 30);
    [_scrollView addSubview:selectBtn];
    
}

- (void)resetContentView{
    
    for (int i=0; i<4; i++) {
        UIButton *contentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [contentBtn setTitle:@"详细信息" forState:UIControlStateNormal];
        [contentBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateSelected];
        [contentBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
        [contentBtn addTarget:self action:@selector(contentInfoselect:) forControlEvents:UIControlEventTouchUpInside];
        contentBtn.layer.masksToBounds=YES;
        contentBtn.layer.cornerRadius=0.2;
        contentBtn.layer.borderWidth=0.5;
        contentBtn.layer.borderColor=[[UIColor lightGrayColor] CGColor];
        contentBtn.backgroundColor=[NTColor lightGrayColor];
        contentBtn.tag=i;
        contentBtn.frame=CGRectMake(i*100, ScreenWidth/3+20, 100, 30);
        [_scrollView addSubview:contentBtn];
        if (i==0) {
            contentBtn.selected=YES;
            [self contentInfoselect:contentBtn];
        }
    }
}

#pragma  mark - selectAction

- (void)selectAction{
    
}

- (void)contentInfoselect:(id)sender{
    UIButton *btn=(UIButton *)sender;
    switch (btn.tag) {
        case 0:
        {
            if (!_contenInfoView) {
                _contenInfoView=[[UIView alloc] initWithFrame:CGRectMake(10, ScreenWidth/3+60, ScreenWidth-20, 200)];
                UILabel *contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth-20, 200)];
                contentLabel.text=[_detailDic objectForKey:@"content"];
                contentLabel.backgroundColor=[NTColor clearColor];
                contentLabel.font=[UIFont systemFontOfSize:15];
                [_contenInfoView addSubview:contentLabel];
                _contenInfoView.backgroundColor=[NTColor lightGrayColor];
                [_scrollView addSubview:_contenInfoView];
            }
            else{
                _contenInfoView.hidden=NO;
                _imageInfoView.hidden=YES;
                _videoInfoView.hidden=YES;
                _commentInfoView.hidden=YES;
            }
        }
            break;
        case 1:
        {
            if (!_imageInfoView) {
                _imageInfoView=[[UIView alloc] initWithFrame:CGRectMake(10, ScreenWidth/3+60, ScreenWidth-20, 200)];
                _imageInfoView.backgroundColor=[NTColor yellowColor ];
                [_scrollView addSubview:_imageInfoView];
            }
            else{
                _contenInfoView.hidden=YES;
                _imageInfoView.hidden=NO;
                _videoInfoView.hidden=YES;
                _commentInfoView.hidden=YES;
            }
        }
            break;
        case 2:
        {
            if (!_videoInfoView) {
                _videoInfoView=[[UIView alloc] initWithFrame:CGRectMake(10, ScreenWidth/3+60, ScreenWidth-20, 200)];
                _videoInfoView.backgroundColor=[NTColor orangeColor];
                [_scrollView addSubview:_videoInfoView];
            }
            else{
                _contenInfoView.hidden=YES;
                _imageInfoView.hidden=YES;
                _videoInfoView.hidden=NO;
                _commentInfoView.hidden=YES;
            }
        }
            break;
        case 3:
        {
            if (!_commentInfoView) {
                _commentInfoView=[[UIView alloc] initWithFrame:CGRectMake(10, ScreenWidth/3+60, ScreenWidth-20, 200)];
                _commentInfoView.backgroundColor=[NTColor blueColor];
                [_scrollView addSubview:_commentInfoView];
                UILabel *commentLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth-20, 200)];
                commentLabel.text=[_detailDic objectForKey:@"content"];
                commentLabel.backgroundColor=[NTColor clearColor];
                commentLabel.font=[UIFont systemFontOfSize:15];
                [_commentInfoView addSubview:commentLabel];
                
            }
            else{
                _contenInfoView.hidden=YES;
                _imageInfoView.hidden=YES;
                _videoInfoView.hidden=YES;
                _commentInfoView.hidden=NO;
            }
        }
            break;
            
        default:
            break;
    }
    
}

@end
