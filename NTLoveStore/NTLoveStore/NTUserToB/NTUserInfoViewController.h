//
//  NTUserInfoViewController.h
//  NTLoveStore
//
//  Created by 李莹 on 15/6/23.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTParentViewController.h"
#import "NTAsynService.h"
#import "NTListView.h"
@interface NTUserInfoViewController : NTParentViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *leftAry;

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

@property (weak, nonatomic) IBOutlet UIView *rightContentView;

@property (nonatomic, strong) NTListView *listView;

@property (nonatomic) NSInteger selectType;

@end
