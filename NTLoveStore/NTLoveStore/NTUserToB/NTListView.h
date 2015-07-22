//
//  NTListView.h
//  NTLoveStore
//
//  Created by liying on 15/7/22.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTListView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonnull, strong) NSMutableArray *listAry;

@end
