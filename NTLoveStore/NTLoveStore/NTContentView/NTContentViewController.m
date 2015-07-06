//
//  NTContentViewController.m
//  NTLoveStore
//
//  Created by liying on 15/6/13.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTContentViewController.h"
#import "NTShowDetailVIew.h"
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
    _scrollView.scrollEnabled=YES;
    
    EGOImageView *imageView=[[EGOImageView alloc] initWithPlaceholderImage:[NTImage imageWithFileName:@"picple.png"]];
    imageView.frame=CGRectMake(20, 20, 570, 415);
    imageView.imageURL=[NSURL URLWithString:[_detailDic objectForKey:@"cover_id"]];
    [_scrollView addSubview:imageView];
    _heightValue+=CGRectGetHeight(imageView.frame)+20;
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(imageView.frame)+50, 60, ScreenWidth-640, 30)];
    titleLabel.backgroundColor=[NTColor clearColor];
    titleLabel.font=[UIFont systemFontOfSize:19];
    titleLabel.text=[_detailDic objectForKey:@"title"];
    [_scrollView addSubview:titleLabel];
    
    UILabel *priceLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetHeight(titleLabel.frame)+CGRectGetMinY(titleLabel.frame)+25, CGRectGetWidth(titleLabel.frame), 30)];
    priceLabel.backgroundColor=[NTColor clearColor];
    priceLabel.font=[UIFont systemFontOfSize:15];
    NSMutableAttributedString *pricehNum=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"价格:￥%@",[_detailDic objectForKey:@"price"]]];
    [pricehNum addAttribute:NSForegroundColorAttributeName value:[NTColor redColor] range:NSMakeRange(3,pricehNum.length-3)];
    priceLabel.attributedText=pricehNum;
    [_scrollView addSubview:priceLabel];
    
    UILabel *finishNumLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetHeight(priceLabel.frame)+CGRectGetMinY(priceLabel.frame)+20, CGRectGetWidth(titleLabel.frame)/2, 30)];
    finishNumLabel.font=[UIFont systemFontOfSize:15];
    finishNumLabel.backgroundColor=[NTColor clearColor];
    NSMutableAttributedString *finishNum=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"服务次数：%@次",[_detailDic objectForKey:@"sale"]]];
    [finishNum addAttribute:NSForegroundColorAttributeName value:[NTColor colorWithHexString:NTBlueColor] range:NSMakeRange(5,finishNum.length-5)];
    finishNumLabel.attributedText=finishNum;
    finishNumLabel.textAlignment=NSTextAlignmentLeft;
    [_scrollView addSubview:finishNumLabel];
    
    UILabel *commentNumLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(finishNumLabel.frame)+CGRectGetMinX(finishNumLabel.frame), CGRectGetMinY(finishNumLabel.frame), CGRectGetWidth(finishNumLabel.frame)/2, 30)];
    commentNumLabel.font=[UIFont systemFontOfSize:15];
    commentNumLabel.backgroundColor=[NTColor clearColor];
    NSMutableAttributedString *commentNum=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"评论：%@条",[_detailDic objectForKey:@"comment"]]];
    [commentNum addAttribute:NSForegroundColorAttributeName value:[NTColor colorWithHexString:NTBlueColor] range:NSMakeRange(3,commentNum.length-3)];
    commentNumLabel.attributedText=commentNum;
    commentNumLabel.textAlignment=NSTextAlignmentLeft;
    [_scrollView addSubview:commentNumLabel];
    
    UIButton *selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateNormal];
    [selectBtn setTitle:@"立即预定" forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    selectBtn.titleLabel.font=[UIFont systemFontOfSize:19];
    if (_isCanSelect) {
      [selectBtn setBackgroundColor:[NTColor colorWithHexString:NTBlueColor]];
    }
    else{
        [selectBtn setBackgroundColor:[NTColor lightGrayColor]];
    }
    selectBtn.frame=CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetHeight(finishNumLabel.frame)+CGRectGetMinY(finishNumLabel.frame)+100, 380, 40);
    selectBtn.enabled=_isCanSelect;
    [_scrollView addSubview:selectBtn];
}

- (void)resetContentView{
    int j=0;
    BOOL ishave=NO;
    for (int i=0; i<4; i++) {
        NSString *title;
        if ([_detailDic objectForKey:@"content"]&&i==0) {
            title=@"详细信息";
            ishave=YES;
        }
        else if ([_detailDic objectForKey:@"pics"]&&i==1){
            title=@"案例相册";
            j++;
            ishave=YES;
            [self GetTheImage];
        }
        else if ([self GetTheVideo]&&i==2){
            title=@"案例视频";
            j++;
            ishave=YES;
        }
        else if ([[_detailDic objectForKey:@"comment"] intValue]>0&&i==3){
            title=@"真实评论";
            j++;
            ishave=YES;
        }
        if (ishave) {
            UIButton *contentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [contentBtn setTitle:title forState:UIControlStateNormal];
            [contentBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateSelected];
            [contentBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
            [contentBtn addTarget:self action:@selector(contentInfoselect:) forControlEvents:UIControlEventTouchUpInside];
            contentBtn.layer.borderWidth=0.5;
            contentBtn.layer.borderColor=[[NTColor colorWithHexString:NTGrayColor] CGColor];
            contentBtn.backgroundColor=[NTColor colorWithHexString:NTBlueColor];
            contentBtn.tag=i;
            contentBtn.frame=CGRectMake(20+j*120, 455, 120, 40);
            [_scrollView addSubview:contentBtn];
            if (i==0) {
                [self contentInfoselect:contentBtn];
            }
            ishave=NO;
        }
    }
    _heightValue+=400;
    [_scrollView setContentSize:CGSizeMake(0, _heightValue)];
}

- (NSMutableArray *)GetTheVideo{
    
    return nil;
}

- (void)GetTheImage{
    _imageAry=[[_detailDic objectForKey:@"pics"] componentsSeparatedByString:@","];
}

#pragma  mark - selectAction

- (void)selectAction{
    
}

- (void)contentInfoselect:(id)sender{
    UIButton *btn=(UIButton *)sender;
    btn.selected=!btn.selected;
    switch (btn.tag) {
        case 0:
        {
            if (!_contenInfoView) {
                _contenInfoView=[[UIView alloc] initWithFrame:CGRectMake(20, 500, ScreenWidth-40, 250)];
                UILabel *contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth-40, 200)];
                contentLabel.text=[_detailDic objectForKey:@"content"];
                contentLabel.backgroundColor=[NTColor clearColor];
                contentLabel.font=[UIFont systemFontOfSize:15];
                contentLabel.lineBreakMode=NSLineBreakByTruncatingTail;
                contentLabel.numberOfLines=0;
                [_contenInfoView addSubview:contentLabel];
                _contenInfoView.backgroundColor=[NTColor clearColor];
                [_scrollView addSubview:_contenInfoView];
                
                UIButton *showAllBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(contentLabel.frame)-150, CGRectGetHeight(contentLabel.frame)+20, 150, 30)];
                [showAllBtn setTitle:@"查看更多信息 >" forState:UIControlStateNormal];
                [showAllBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
                showAllBtn.titleLabel.font=[UIFont systemFontOfSize:15];
                showAllBtn.tag=1;
                [showAllBtn addTarget:self action:@selector(showTextView:) forControlEvents:UIControlEventTouchUpInside];
                [_contenInfoView addSubview:showAllBtn];
                
            }
            _contenInfoView.hidden=NO;
            _imageInfoView.hidden=YES;
            _videoInfoView.hidden=YES;
            _commentInfoView.hidden=YES;
        }
            break;
        case 1:
        {
            if (!_imageInfoView) {
                _imageInfoView=[[UIScrollView alloc] initWithFrame:CGRectMake(20, 500, ScreenWidth-40, 225)];
                _imageInfoView.backgroundColor=[NTColor whiteColor];
                int i=0;
                for (NSString *imagePath in _imageAry) {
                    EGOImageButton *imageBtn=[[EGOImageButton alloc] initWithPlaceholderImage:[UIImage imageNamed:@"picple.png"]];
                    [imageBtn addTarget:self action:@selector(imageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                    imageBtn.tag=i;
                    imageBtn.imageURL=[NSURL URLWithString:imagePath];
                    imageBtn.frame=CGRectMake(i*(285+40), 20, 285, 185);
                    [_imageInfoView addSubview:imageBtn];
                    i++;
                }
                [_imageInfoView setContentSize:CGSizeMake([_imageAry count]*325, 225)];
                [_scrollView addSubview:_imageInfoView];
            }
            _contenInfoView.hidden=YES;
            _imageInfoView.hidden=NO;
            _videoInfoView.hidden=YES;
            _commentInfoView.hidden=YES;
        }
            break;
        case 2:
        {
            if (!_videoInfoView) {
                _videoInfoView=[[UIScrollView alloc] initWithFrame:CGRectMake(20, 500, ScreenWidth-40, 200)];
                _videoInfoView.backgroundColor=[NTColor orangeColor];
                [_scrollView addSubview:_videoInfoView];
            }
            _contenInfoView.hidden=YES;
            _imageInfoView.hidden=YES;
            _videoInfoView.hidden=NO;
            _commentInfoView.hidden=YES;
        }
            break;
        case 3:
        {
            if (!_commentInfoView) {
                _commentInfoView=[[UIView alloc] initWithFrame:CGRectMake(20, 500, ScreenWidth-40, 250)];
                _commentInfoView.backgroundColor=[NTColor clearColor];
                [_scrollView addSubview:_commentInfoView];
                UILabel *commentLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0,ScreenWidth-40, 200)];
                commentLabel.text=[_detailDic objectForKey:@"content"];
                commentLabel.backgroundColor=[NTColor clearColor];
                commentLabel.lineBreakMode=NSLineBreakByTruncatingTail;
                commentLabel.numberOfLines=0;
                commentLabel.font=[UIFont systemFontOfSize:15];
                
                UIButton *showAllBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(commentLabel.frame)-150, CGRectGetHeight(commentLabel.frame)+20, 150, 30)];
                [showAllBtn setTitle:@"查看更多信息 >" forState:UIControlStateNormal];
                [showAllBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
                showAllBtn.titleLabel.font=[UIFont systemFontOfSize:15];
                showAllBtn.tag=2;
                [showAllBtn addTarget:self action:@selector(showTextView:) forControlEvents:UIControlEventTouchUpInside];
                [_commentInfoView addSubview:showAllBtn];

                [_commentInfoView addSubview:commentLabel];
                
            }
            _contenInfoView.hidden=YES;
            _imageInfoView.hidden=YES;
            _videoInfoView.hidden=YES;
            _commentInfoView.hidden=NO;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - showDetailView

- (void)imageBtnAction:(id)sender{
    EGOImageButton *btn=(EGOImageButton *)sender;
    NTShowDetailVIew *detailView=[[NTShowDetailVIew alloc] initWithFrame:self.view.frame];
    [detailView showImageWithArray:_imageAry withIndex:btn.tag];
}

- (void)showTextView:(id)sender{
    UIButton *btn=(UIButton*)sender;
    NTShowDetailVIew *detailView=[[NTShowDetailVIew alloc] initWithFrame:self.view.frame];
    if(btn.tag==1){
       [detailView showTextWithString:[_detailDic objectForKey:@"content"]];
    }
    else{
        [detailView showTextWithString:[_detailDic objectForKey:@"content"]];
    }
    
}

@end
