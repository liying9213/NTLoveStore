//
//  NTUserInfoViewController.h
//  NTLoveStore
//
//  Created by NTTian on 15/6/23.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import "NTParentViewController.h"
#import "NTAsynService.h"
#import "NTListView.h"
#import "NTCommentView.h"
#import "NTFollowListView.h"
#import "NTHeadSelectView.h"
@interface NTUserInfoViewController : NTParentViewController<UITableViewDataSource,UITableViewDelegate,UIPopoverControllerDelegate,NTHeadSelectViewDelegate>

@property (nonatomic, strong) NSArray *leftAry;

@property (nonatomic, strong) NTHeadSelectView *headSelectView;

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

@property (weak, nonatomic) IBOutlet UIView *rightContentView;

@property (nonatomic, strong) NTListView *listView;

@property (nonatomic, strong) NTCommentView *commentView;

@property (nonatomic, strong) NTFollowListView *followListView;

@property (nonatomic, strong) UIView *normalView;

@property (nonatomic) NSInteger selectType;

@property (nonatomic) BOOL isFollow;

@property (nonatomic) BOOL isComment;


@end
