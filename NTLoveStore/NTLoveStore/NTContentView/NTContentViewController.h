//
//  NTContentViewController.h
//  NTLoveStore
//
//  Created by NTTian on 15/6/13.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import "NTParentViewController.h"
#import "VRGCalendarView.h"
#import "NTCommentBodyView.h"
@interface NTContentViewController : NTParentViewController<VRGCalendarViewDelegate,UIPopoverControllerDelegate,UITextFieldDelegate>

@property (nonatomic, strong)NSDictionary *contentDic;

@property (nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic, strong)UIView *contenInfoView;

@property (nonatomic, strong)UIScrollView *imageInfoView;

@property (nonatomic, strong)UIScrollView *videoInfoView;

@property (nonatomic, strong)UIView *commentInfoView;

@property (nonatomic, strong)NTCommentBodyView *firCommentView;

@property (nonatomic, strong)NTCommentBodyView *secCommentView;

@property (nonatomic, strong)UILabel *selectDateLabel;

@property (nonatomic, strong)UITextField *selectNumLabel;

@property (nonatomic, strong)UIButton *contentBtn;

@property (nonatomic, strong)UIButton *imageViewBtn;

@property (nonatomic, strong)UIButton *videoBtn;

@property (nonatomic, strong)UIButton *commentBtn;

@property (nonatomic, strong)UIPopoverController *popoverView;

@property (nonatomic, assign)NSInteger productID;

@property (nonatomic, strong)NSDictionary *detailDic;

@property (nonatomic, strong)NSArray *hotListAry;

@property (nonatomic, strong)NSArray *imageAry;

@property (nonatomic, strong)NSMutableArray *videoAry;

@property (nonatomic, strong)NSMutableString *contentStr;

@property (nonatomic, strong)NSString *currentType;

@property (nonatomic, copy) NSArray *commentAry;

@property (nonatomic, copy) NSMutableDictionary *dateDic;

@property (nonatomic) BOOL isPerson;

@property (nonatomic) float heightValue;

@property (nonatomic) BOOL isCanSelect;

@property (nonatomic) int selectNum;

@end
