//
//  NTContentViewController.m
//  NTLoveStore
//
//  Created by NTTian on 15/6/13.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import "NTContentViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "NTShowDetailVIew.h"
#import "NTAsynService.h"
#import "NTMemberView.h"
#import "HTMLParser.h"
#import "NTNormalHead.h"
#import "NSDate+convenience.h"
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

- (void)dealloc{
    _contentDic=nil;
    _detailDic=nil;
    _hotListAry=nil;
    _imageAry=nil;
    _videoAry=nil;
    _contentStr=nil;
    _currentType=nil;
}

#pragma mark - getContentData

- (void)getTheContentData{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    __weak typeof(self) __weakself=self;
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"id":[NSNumber numberWithInteger:_productID]};
    [NTAsynService requestWithHead:detileBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            _detailDic=finishData;
            [self getTheHotListData];
            [self resetView];
            [self resetContentView];
            [self hideWaitingView];
        }
        else{
            __strong typeof(self) self=__weakself;
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
            }
            else{
                [self showEndViewWithText:@"网络请求失败！"];
            }
        }
    }];
    dic=nil;
}

- (void)getCommentAction{
    __weak typeof(self) __weakself=self;
    NSDictionary *dic=@{@"goodid":[NSNumber numberWithInteger:_productID]};
    [NTAsynService requestWithHead:getcomOrderBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self hideWaitingView];
            _commentAry=[finishData allValues];
            if (self.firCommentView) {
                [self.firCommentView reloadTheViewWithData:_commentAry[0]];
            }
            if (self.secCommentView&&[_commentAry count]>=2) {
                [self.firCommentView reloadTheViewWithData:_commentAry[1]];
            }
        }
        else{
            __strong typeof(self) self=__weakself;
            if (!self.waitingView.hidden) {
                [self showEndViewWithText:@"网络请求失败！"];
            }
        }
    }];
    dic=nil;
}

- (void)getTheHotListData{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    __weak typeof(self) __weakself=self;
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"goodid":[NSNumber numberWithInteger:_productID]};
    [NTAsynService requestWithHead:hotListBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            _hotListAry=[finishData allValues];
            [self resetHotListView];
        }
        else{
            __strong typeof(self) self=__weakself;
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
            }
            else{
                [self showEndViewWithText:@"网络请求失败！"];
            }
        }
        finishData=nil;
    }];
    dic=nil;
}

#pragma mark - resetView

- (void)resetView{
    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight-64)];
    _scrollView.backgroundColor=[NTColor clearColor];
    [self.view addSubview:_scrollView];
    _scrollView.scrollEnabled=YES;
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 570, 415)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[_detailDic objectForKey:@"cover_id"]] placeholderImage:[NTImage imageWithFileName:@"picple.png"]];
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
    
    if ([_detailDic objectForKey:@"stock"]&&!_isCanSelect) {
        UIView *numView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetHeight(finishNumLabel.frame)+CGRectGetMinY(finishNumLabel.frame)+20,  ScreenWidth-640, 50)];
        [self resetSelectNumWithView:numView];
        numView.backgroundColor=[UIColor clearColor];
        [_scrollView addSubview:numView];
        _selectNumLabel.text=[_detailDic objectForKey:@"stock"];
    }
    
    if (_isPerson&&_isCanSelect) {
        UIView *calendarView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetHeight(finishNumLabel.frame)+CGRectGetMinY(finishNumLabel.frame)+20,  ScreenWidth-640, 50)];
        [self resetCalendarSelectWithView:calendarView];
        calendarView.backgroundColor=[UIColor clearColor];
        [_scrollView addSubview:calendarView];
    }
    else if(!_isPerson&&_isCanSelect)
    {
        UIView *numView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetHeight(finishNumLabel.frame)+CGRectGetMinY(finishNumLabel.frame)+20,  ScreenWidth-640, 50)];
        [self resetSelectNumWithView:numView];
        numView.backgroundColor=[UIColor clearColor];
        [_scrollView addSubview:numView];
    }
    UIButton *selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateNormal];
    [selectBtn setTitle:@"立即预定" forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
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
    [self flattenHTML:[_detailDic objectForKey:@"content"]];
    int j=0;
    for (int i=0; i<4; i++) {
        NSString *title;
        if ([_detailDic objectForKey:@"content"]&&i==0) {
            title=@"详细信息";
            _contentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_contentBtn setTitle:title forState:UIControlStateNormal];
            [_contentBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateSelected];
            [_contentBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
            [_contentBtn addTarget:self action:@selector(contentInfoselect:) forControlEvents:UIControlEventTouchUpInside];
            _contentBtn.layer.borderWidth=0.5;
            _contentBtn.layer.borderColor=[[NTColor colorWithHexString:NTGrayColor] CGColor];
            _contentBtn.backgroundColor=[NTColor colorWithHexString:NTBlueColor];
            _contentBtn.tag=i;
            _contentBtn.frame=CGRectMake(20+j*120, 455, 120, 40);
            [_scrollView addSubview:_contentBtn];
            if (i==0) {
                [self contentInfoselect:_contentBtn];
            }
        }
        else if ([_detailDic objectForKey:@"pics"]&&i==1){
            title=@"案例相册";
            j++;
            [self GetTheImage];
            _imageViewBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_imageViewBtn setTitle:title forState:UIControlStateNormal];
            [_imageViewBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateSelected];
            [_imageViewBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
            [_imageViewBtn addTarget:self action:@selector(contentInfoselect:) forControlEvents:UIControlEventTouchUpInside];
            _imageViewBtn.layer.borderWidth=0.5;
            _imageViewBtn.layer.borderColor=[[NTColor colorWithHexString:NTGrayColor] CGColor];
            _imageViewBtn.backgroundColor=[NTColor colorWithHexString:NTBlueColor];
            _imageViewBtn.tag=i;
            _imageViewBtn.frame=CGRectMake(20+j*120, 455, 120, 40);
            [_scrollView addSubview:_imageViewBtn];
        }
        else if (_videoAry&&_videoAry.count>0&&i==2){
            title=@"案例视频";
            j++;
            _videoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_videoBtn setTitle:title forState:UIControlStateNormal];
            [_videoBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateSelected];
            [_videoBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
            [_videoBtn addTarget:self action:@selector(contentInfoselect:) forControlEvents:UIControlEventTouchUpInside];
            _videoBtn.layer.borderWidth=0.5;
            _videoBtn.layer.borderColor=[[NTColor colorWithHexString:NTGrayColor] CGColor];
            _videoBtn.backgroundColor=[NTColor colorWithHexString:NTBlueColor];
            _videoBtn.tag=i;
            _videoBtn.frame=CGRectMake(20+j*120, 455, 120, 40);
            [_scrollView addSubview:_videoBtn];
        }
        else if ([[_detailDic objectForKey:@"comment"] intValue]>0&&i==3){
            title=@"真实评论";
            j++;
            [self getCommentAction];
            _commentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [_commentBtn setTitle:title forState:UIControlStateNormal];
            [_commentBtn setTitleColor:[NTColor whiteColor] forState:UIControlStateSelected];
            [_commentBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
            [_commentBtn addTarget:self action:@selector(contentInfoselect:) forControlEvents:UIControlEventTouchUpInside];
            _commentBtn.layer.borderWidth=0.5;
            _commentBtn.layer.borderColor=[[NTColor colorWithHexString:NTGrayColor] CGColor];
            _commentBtn.backgroundColor=[NTColor colorWithHexString:NTBlueColor];
            _commentBtn.tag=i;
            _commentBtn.frame=CGRectMake(20+j*120, 455, 120, 40);
            [_scrollView addSubview:_commentBtn];
            
        }
    }
    _heightValue+=400;
    [_scrollView setContentSize:CGSizeMake(0, _heightValue)];
}

- (void)resetCalendarSelectWithView:(UIView *)view{
    UIButton *selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame=CGRectMake(0, 0, 130, 30);
    [selectBtn setTitle:@"选择档期" forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(resetCalendar:) forControlEvents:UIControlEventTouchUpInside];
    selectBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [selectBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    selectBtn.layer.borderWidth=1;
    selectBtn.layer.borderColor=[[NTColor colorWithHexString:@"BBBBBB"] CGColor];
    [view addSubview:selectBtn];
    
    _selectDateLabel=[[UILabel alloc] initWithFrame:CGRectMake(200, 0, 200, 30)];
    _selectDateLabel.backgroundColor=[UIColor clearColor];
    _selectDateLabel.font=[UIFont systemFontOfSize:15];
    [view addSubview:_selectDateLabel];
}

- (void)resetSelectNumWithView:(UIView *)view{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    label.backgroundColor=[UIColor clearColor];
    label.text=@"数量：";
    label.font=[UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    UIButton *minusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    minusBtn.frame=CGRectMake(50, 10, 30, 30);
    [minusBtn setTitle:@"-" forState:UIControlStateNormal];
    minusBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [minusBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    [minusBtn addTarget:self action:@selector(minusNum) forControlEvents:UIControlEventTouchUpInside];
    minusBtn.enabled=_isCanSelect;
    minusBtn.layer.borderWidth=1;
    minusBtn.layer.borderColor=[[NTColor colorWithHexString:@"#BBBBBB"] CGColor];
    [view addSubview:minusBtn];
    
    _selectNumLabel=[[UITextField alloc] initWithFrame:CGRectMake(90, 0, 50, 50)];
    _selectNumLabel.textAlignment=NSTextAlignmentCenter;
    _selectNumLabel.text=@"1";
    _selectNumLabel.keyboardType=UIKeyboardTypePhonePad;
    _selectNumLabel.font=[UIFont systemFontOfSize:15];
    _selectNumLabel.delegate=self;
    [view addSubview:_selectNumLabel];
    
    UIButton *addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame=CGRectMake(150,10, 30, 30);
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    addBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [addBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addNum) forControlEvents:UIControlEventTouchUpInside];
    addBtn.enabled=_isCanSelect;
    addBtn.layer.borderWidth=1;
    addBtn.layer.borderColor=[[NTColor colorWithHexString:@"#BBBBBB"] CGColor];
    [view addSubview:addBtn];
}

- (void)resetCalendar:(id)sender{
    UIButton *btn=(UIButton *)sender;
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    __weak typeof(self) __weakself=self;
    NSDictionary *dic=@{@"id":[NSNumber numberWithInteger:_productID]};
    [NTAsynService requestWithHead:getDateOrderBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            [self getTheDate:finishData];
            VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
            if (_selectDateLabel.text) {
                NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
                [inputFormatter setDateFormat:@"yyyy-MM-dd"];
                NSDate* inputDate = [inputFormatter dateFromString:_selectDateLabel.text];
                calendar.firstDate=inputDate;
            }
            calendar.delegate=self;
            UIViewController *viewcontroller=[[UIViewController alloc] init];
            [viewcontroller.view addSubview:calendar];
            
            _popoverView=[[UIPopoverController alloc] initWithContentViewController:viewcontroller];
            _popoverView.popoverContentSize = CGSizeMake(320, 400);
            _popoverView.delegate=self;
            [_popoverView presentPopoverFromRect:btn.bounds inView:btn permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
        else{
            __strong typeof(self) self=__weakself;
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
            }
            else{
                [self showEndViewWithText:@"网络请求失败！"];
            }
        }
    }];
    dic=nil;
}

- (void)resetHotListView{
    UIView *hotListView=[[UIView alloc] initWithFrame:CGRectMake(0, 780, ScreenWidth, 280)];
    [_scrollView addSubview:hotListView];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, 290, 40)];
    label.backgroundColor=[NTColor colorWithHexString:NTBlueColor];
    label.textColor=[NTColor whiteColor];
    label.text=@"看过这个的人还看过哪些";
    label.textAlignment=NSTextAlignmentCenter;
    [hotListView addSubview:label];
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(20, 39, ScreenWidth-20, 1)];
    line.backgroundColor=[NTColor colorWithHexString:NTGrayColor];
    [hotListView addSubview:line];
    
    UIScrollView *hotScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(20, 60, ScreenWidth-40, 210)];
    hotScrollView.scrollEnabled=YES;
    hotScrollView.showsHorizontalScrollIndicator=YES;
    [hotListView addSubview:hotScrollView];
    float xValue=0;
    int i=0;
    for (NSDictionary *dic in _hotListAry) {
        NTMemberView *menberView=[[NTMemberView alloc] initWithFrame:CGRectMake(xValue, 10, 190, 190)];
        menberView.delegate=self;
        menberView.tag=i;
        [menberView resetView];
        menberView.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [menberView reloadTheViewWithData:dic];
        [hotScrollView addSubview:menberView];
        xValue+=210;
        i++;
    }
    _heightValue+=250;
    CGSize size=CGSizeMake(ScreenWidth, _heightValue);
    [_scrollView setContentSize:size];
    [hotScrollView setContentSize:CGSizeMake(_hotListAry.count*210, 0)];
}

- (NSMutableArray *)GetTheVideo{
    
    return nil;
}

- (void)GetTheImage{
    _imageAry=[[_detailDic objectForKey:@"pics"] componentsSeparatedByString:@","];
}

#pragma  mark - selectAction

- (void)selectAction:(id)sender{
    if (![share()userIsLogin]) {
        [self showEndViewWithText:@"请登录账号！"];
        return;
    }
    if (_isPerson&&!_selectDateLabel.text.length>0) {
        [self showEndViewWithText:@"请选择档期"];
        return;
    }
    UIButton *btn=(UIButton *)sender;
    [self showWaitingViewWithText:@"正在加入购物车..."];
    __weak typeof(self) __weakself=self;
    NSString *num=_isPerson?@"1":_selectNumLabel.text;
    NSString *date=_isPerson?_selectDateLabel.text:@"0";
    NSDictionary *dic=@{@"uid":[share()userUid],
                        @"token":[share()userToken],
                        @"id":[NSNumber numberWithInteger:_productID],
                        @"price":[_detailDic objectForKey:@"price"],
                        @"pet":@"0",
                        @"num":num,
                        @"parameters":date,
                        @"sort":_currentType};
    [NTAsynService requestWithHead:addItemBaseURL WithBody:dic completionHandler:^(BOOL success, id finishData, NSError *connectionError) {
        if (success) {
            __strong typeof(self) self=__weakself;
            btn.enabled=NO;
            [btn setBackgroundColor:[NTColor lightGrayColor]];
            [btn setTitle:@"已预订" forState:UIControlStateNormal];
            [self hideWaitingView];
        }
        else{
            __strong typeof(self) self=__weakself;
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
            }
            else{
                [self showEndViewWithText:@"网络请求失败！"];
            }
        }
        finishData=nil;
    }];
    dic=nil;
}

- (void)contentInfoselect:(id)sender{
    UIButton *btn=(UIButton *)sender;
    switch (btn.tag) {
        case 0:
        {
            if (!_contenInfoView) {
                _contenInfoView=[[UIView alloc] initWithFrame:CGRectMake(20, 500, ScreenWidth-40, 250)];
                UILabel *contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth-40, 200)];
                contentLabel.text=_contentStr;
                contentLabel.backgroundColor=[NTColor clearColor];
                contentLabel.font=[UIFont systemFontOfSize:15];
                contentLabel.lineBreakMode=NSLineBreakByTruncatingTail;
                contentLabel.numberOfLines=0;
                [_contenInfoView addSubview:contentLabel];
                UIFont *dateFont = [UIFont systemFontOfSize:15];
                CGSize dateStringSize = [_contentStr sizeWithFont:dateFont constrainedToSize:CGSizeMake(ScreenWidth-40, 1000) lineBreakMode:contentLabel.lineBreakMode];
                CGRect dateFrame = CGRectMake(0, 0, ScreenWidth-40, dateStringSize.height);
                contentLabel.frame = dateFrame;
                
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
            _contentBtn.selected=YES;
            _commentBtn.selected=NO;
            _imageViewBtn.selected=NO;
            _videoBtn.selected=NO;
        }
            break;
        case 1:
        {
            if (!_imageInfoView) {
                _imageInfoView=[[UIScrollView alloc] initWithFrame:CGRectMake(20, 500, ScreenWidth-40, 225)];
                _imageInfoView.backgroundColor=[NTColor whiteColor];
                int i=0;
                for (NSString *imagePath in _imageAry) {
                    NTButton *imageBtn=[NTButton buttonWithType:UIButtonTypeCustom];
                    imageBtn.frame=CGRectMake(i*(285+40), 20, 285, 185);
                    [imageBtn sd_setImageWithURL:[NSURL URLWithString:imagePath] forState:UIControlStateNormal placeholderImage:[NTImage imageWithFileName:@"picple.png"]];
                    [imageBtn addTarget:self action:@selector(imageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                    imageBtn.tag=i;
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
            _contentBtn.selected=NO;
            _commentBtn.selected=NO;
            _imageViewBtn.selected=YES;
            _videoBtn.selected=NO;
        }
            break;
        case 2:
        {
            if (!_videoInfoView) {
                _videoInfoView=[[UIScrollView alloc] initWithFrame:CGRectMake(20, 500, ScreenWidth-40, 200)];
                _videoInfoView.backgroundColor=[NTColor whiteColor];
                [_scrollView addSubview:_videoInfoView];
                int i=0;
                for (NSString *videoPath in _videoAry) {
                    NTButton *imageBtn=[NTButton buttonWithType:UIButtonTypeCustom];
                    [imageBtn setImage:[NTImage imageWithFileName:@"picple.png"] forState:UIControlStateNormal];
                    imageBtn.frame=CGRectMake(i*(285+40), 20, 285, 185);
                    [imageBtn addTarget:self action:@selector(videoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                    imageBtn.tag=i;
                    imageBtn.frame=CGRectMake(i*(285+40), 20, 285, 185);
                    [_videoInfoView addSubview:imageBtn];
                    i++;
                }
                [_videoInfoView setContentSize:CGSizeMake([_videoAry count]*325, 225)];
                
            }
            _contenInfoView.hidden=YES;
            _imageInfoView.hidden=YES;
            _videoInfoView.hidden=NO;
            _commentInfoView.hidden=YES;
            _contentBtn.selected=NO;
            _commentBtn.selected=NO;
            _imageViewBtn.selected=NO;
            _videoBtn.selected=YES;
        }
            break;
        case 3:
        {
            if (!_commentInfoView) {
                if (!_commentAry||[_commentAry count]<1) {
                    [self showWaitingViewWithText:nil];
                    [self getCommentAction];
                }
                _commentInfoView=[[UIView alloc] initWithFrame:CGRectMake(20, 500, ScreenWidth-40, 250)];
                _commentInfoView.backgroundColor=[NTColor clearColor];
                [_scrollView addSubview:_commentInfoView];
                NSInteger value=[_commentAry count]>2?2:[_commentAry count];
                for (int i=0; i<value; i++) {
                    _firCommentView=[[NTCommentBodyView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_commentInfoView.frame), 100)];
                    [_firCommentView resetView];
                    if (_commentAry&&_commentAry.count>=1) {
                        [_firCommentView  reloadTheViewWithData:_commentAry[0]];
                    }
                    [_commentInfoView addSubview:_firCommentView];
                    CALayer *bottomBorder = [CALayer layer];
                    float height1=_firCommentView.frame.size.height-0.5f;
                    float width1=_firCommentView.frame.size.width;
                    bottomBorder.frame = CGRectMake(0.0f, height1, width1, 0.5f);
                    bottomBorder.backgroundColor = [UIColor blackColor].CGColor;
                    [_firCommentView.layer addSublayer:bottomBorder];
                    if (i==1) {
                        _secCommentView=[[NTCommentBodyView alloc] initWithFrame:CGRectMake(0, 125, CGRectGetWidth(_commentInfoView.frame), 100)];
                        [_secCommentView resetView];
                        if (_commentAry&&_commentAry.count>=2) {
                          [_secCommentView  reloadTheViewWithData:_commentAry[1]];
                        }
                        [_commentInfoView addSubview:_secCommentView];
                        CALayer *bottomBorder = [CALayer layer];
                        float height1=_firCommentView.frame.size.height-0.5f;
                        float width1=_firCommentView.frame.size.width;
                        bottomBorder.frame = CGRectMake(0.0f, height1, width1, 0.5f);
                        bottomBorder.backgroundColor = [UIColor blackColor].CGColor;
                        [_secCommentView.layer addSublayer:bottomBorder];
                    }
                }
                UIButton *showAllBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(_commentInfoView.frame)-150, CGRectGetHeight(_commentInfoView.frame)-40, 150, 30)];
                [showAllBtn setTitle:@"查看更多信息 >" forState:UIControlStateNormal];
                [showAllBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
                showAllBtn.titleLabel.font=[UIFont systemFontOfSize:15];
                showAllBtn.tag=2;
                [showAllBtn addTarget:self action:@selector(showTextView:) forControlEvents:UIControlEventTouchUpInside];
                [_commentInfoView addSubview:showAllBtn];
                
            }
            _contenInfoView.hidden=YES;
            _imageInfoView.hidden=YES;
            _videoInfoView.hidden=YES;
            _commentInfoView.hidden=NO;
            _contentBtn.selected=NO;
            _commentBtn.selected=YES;
            _imageViewBtn.selected=NO;
            _videoBtn.selected=NO;
        }
            break;
            
        default:
            break;
    }
}

- (void)flattenHTML:(NSString *)html {
    
    _contentStr=[NSMutableString string];
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:nil];
    
    for (HTMLNode *node in [[parser body] children])
    {
        if ([node.tagName isEqualToString:@"a"]) {
            if (!_videoAry) {
                _videoAry=[[NSMutableArray alloc] init];
            }
            [_videoAry addObject:node.allContents];
        }
        else
            [_contentStr appendString:node.allContents];
    }
}

#pragma  mark - selectNumAction

- (void)minusNum{
    if (_selectNum>1) {
        _selectNum--;
    }
    else
        _selectNum=1;
    _selectNumLabel.text=[NSString stringWithFormat:@"%d",_selectNum];
}

- (void)addNum{
    _selectNum++;
    _selectNumLabel.text=[NSString stringWithFormat:@"%d",_selectNum];
}

#pragma mark - calendarDelegate

- (void)getTheDate:(NSArray*)dateAry{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    for (NSString *str in dateAry) {
        if (str == [NSNull null]) {
            return;
        }
        NSArray *ary=[str componentsSeparatedByString:@"-"];
        if ([[dic allKeys] containsObject:ary[0]]) {
            if ([[dic[ary[0]] allKeys] containsObject:ary[1]]) {
                NSMutableArray *iary=[[NSMutableArray alloc] initWithArray:[[dic objectForKey:ary[0]] objectForKey:ary[1]]];
                [iary addObject:[NSNumber numberWithInt:[ary[2] intValue]]];
                NSMutableDictionary *jdic=[[NSMutableDictionary alloc] init];
                [jdic setObject:iary forKey:ary[1]];
                [dic setObject:jdic forKey:ary[0]];
                jdic=nil;
                iary=nil;
            }
            else{
                NSMutableDictionary *idic=[[NSMutableDictionary alloc] initWithDictionary:dic[ary[0]]];
                NSArray *iary=[NSArray arrayWithObjects:[NSNumber numberWithInt:[[ary objectAtIndex:2]intValue]], nil];
                [idic setObject:iary forKey:ary[1]];
                [dic setObject:idic forKey:ary[0]];
                idic=nil;
                iary=nil;
            }
        }
        else{
            NSArray *iary=[NSArray arrayWithObjects:[NSNumber numberWithInt:[[ary objectAtIndex:2]intValue]], nil];
            [dic setValue:@{ary[1]:iary} forKey:ary[0]];
            iary=nil;
        }
        ary=nil;
    }
    _dateDic=dic;
}

- (void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated{
    NSString *year=[NSString stringWithFormat:@"%d",[calendarView.currentMonth year]];
    NSString *imonth=[NSString stringWithFormat:@"%d",[calendarView.currentMonth month]];
    if ([_dateDic objectForKey:year]) {
        if ([[_dateDic objectForKey:year] objectForKey:imonth]) {
            [calendarView markDates:[[_dateDic objectForKey:year] objectForKey:imonth]];
        }
    }
}

- (void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date{
    if ([date compare:[NSDate date]] == NSOrderedAscending) {
        [self showEndViewInWindownWithText:@"请选择正确的时间！"];
        return;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    _selectDateLabel.text=[formatter stringFromDate:date];
    [_popoverView dismissPopoverAnimated:YES];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    [_popoverView.contentViewController removeFromParentViewController];
    _popoverView=nil;
}

#pragma mark - showDetailView

- (void)imageBtnAction:(id)sender{
    NTButton *btn=(NTButton *)sender;
    NTShowDetailVIew *detailView=[[NTShowDetailVIew alloc] initWithFrame:self.view.frame];
    [detailView showImageWithArray:_imageAry withIndex:btn.tag];
}

- (void)videoBtnAction:(id)sender{
    NTButton *btn=(NTButton *)sender;
    NSURL * movieurl = [NSURL URLWithString:[_videoAry objectAtIndex:btn.tag]];
    MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:movieurl];
    [self presentMoviePlayerViewControllerAnimated:player];
}

- (void)showTextView:(id)sender{
    UIButton *btn=(UIButton*)sender;
    NTShowDetailVIew *detailView=[[NTShowDetailVIew alloc] initWithFrame:self.view.frame];
    if(btn.tag==1){
       [detailView showLeftTextWithString:_contentStr];
    }
    else{
        [detailView showTableViewWithData:_commentAry];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _selectNum=[textField.text intValue];
}

#pragma mark - showHotListMember
- (void)memberSelectAction:(id)sender{
    NTButton *btn=(NTButton *)sender;
    NTContentViewController *viewController=[[NTContentViewController alloc] init];
    viewController.title = btn.keyWord;
    viewController.productID=btn.tag;
    viewController.isCanSelect=NO;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)backBtnAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
