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
#import "NTMemberView.h"
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
                [self showEndViewWithText:@"网路请求失败！"];
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
                        @"id":[NSNumber numberWithInteger:_productID]};
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
                [self showEndViewWithText:@"网路请求失败！"];
            }
        }
    }];
    dic=nil;
}

#pragma mark - resetView

- (void)resetView{
    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight-64)];
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
        else if ([self GetTheVideo]&&i==2){
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
    minusBtn.layer.masksToBounds=YES;
    minusBtn.layer.cornerRadius=15;
    minusBtn.layer.borderWidth=1;
    minusBtn.layer.borderColor=[[NTColor colorWithHexString:@"#BBBBBB"] CGColor];
    [view addSubview:minusBtn];
    
    _selectNumLabel=[[UILabel alloc] initWithFrame:CGRectMake(90, 0, 50, 50)];
    _selectNumLabel.textAlignment=NSTextAlignmentCenter;
    _selectNumLabel.text=@"1";
    _selectNumLabel.font=[UIFont systemFontOfSize:15];
    [view addSubview:_selectNumLabel];
    
    UIButton *addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame=CGRectMake(150,10, 30, 30);
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    addBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [addBtn setTitleColor:[NTColor blackColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addNum) forControlEvents:UIControlEventTouchUpInside];
    addBtn.layer.masksToBounds=YES;
    addBtn.layer.cornerRadius=16;
    addBtn.layer.borderWidth=1;
    addBtn.layer.borderColor=[[NTColor colorWithHexString:@"#BBBBBB"] CGColor];
    [view addSubview:addBtn];
}

- (void)resetCalendar:(id)sender{
    UIButton *btn=(UIButton *)sender;
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
            [self hideWaitingView];
        }
        else{
            __strong typeof(self) self=__weakself;
            if (![share()userIsLogin]) {
                [self showEndViewWithText:@"请登录账号！"];
            }
            else{
                [self showEndViewWithText:@"网路请求失败！"];
            }
        }
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
                _videoInfoView.backgroundColor=[NTColor orangeColor];
                [_scrollView addSubview:_videoInfoView];
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

- (void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated{
    NSDictionary  *dic=@{@"2015":@{@"7":@[@11,@22,@25,@28],@"9":@[@03,@10,@19]},@"2016":@{@"1":@[@18,@21,@22,@27],@"2":@[@13,@13,@19]}};
    NSString *year=[NSString stringWithFormat:@"%d",[calendarView.currentMonth year]];
    NSString *imonth=[NSString stringWithFormat:@"%d",[calendarView.currentMonth month]];
    if ([dic objectForKey:year]) {
        if ([[dic objectForKey:year] objectForKey:imonth]) {
            [calendarView markDates:[[dic objectForKey:year] objectForKey:imonth]];
        }
    }
}

- (void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date{
    NSLog(@"====%@",date);
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

#pragma mark - showHotListMember
- (void)memberSelectAction:(id)sender{
    UIButton *btn=(UIButton *)sender;
    NTContentViewController *viewController=[[NTContentViewController alloc] init];
    viewController.productID=btn.tag;
    viewController.isCanSelect=NO;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
