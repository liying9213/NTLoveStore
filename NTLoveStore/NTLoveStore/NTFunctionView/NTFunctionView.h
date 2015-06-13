//
//  NTFunctionView.h
//  NTLoveStore
//
//  Created by 李莹 on 15/6/12.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NTFunctionView;

@protocol NTFunctionViewDelegate <NSObject>

@required

- (void)leftViewActionWithID:(int)keyID;

@required

- (void)memberSelectAction:(id)sender;

@end

@interface NTFunctionView : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id delegate;

@property (nonatomic, strong) NSArray *leftAry;

@property (nonatomic, strong) NSArray *functionAry;

@property (nonatomic, strong) UITableView *leftView;

@property (nonatomic, strong) UITableView *tableView;


- (void)resetView;

- (void)reloadLeftViewWithData:(NSArray *)leftAry;

- (void)reloadFunctionViewWithData:(NSArray *)functionAry;

@end
