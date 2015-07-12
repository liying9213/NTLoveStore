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

- (void)leftViewActionWithCategory:(NSString *)category WithOrder:(NSInteger)orderID;

@required

- (void)memberSelectAction:(id)sender;

@optional

- (void)showResult:(id)sender;

@end

@interface NTFunctionView : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id delegate;

@property (nonatomic, strong) NSArray *leftAry;

@property (nonatomic, strong) NSMutableArray *functionAry;

@property (nonatomic, strong) UITableView *leftView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic) NSInteger orderID;

@property (nonatomic) NSInteger selectID;

@property (nonatomic) BOOL isTheme;

@property (nonatomic) float thePrice;

@property (nonatomic) float theTuanPrice;

@property (nonatomic, strong)NSDictionary *resultDic;

- (void)resetView;

- (void)reloadLeftViewWithData:(NSArray *)leftAry;

- (void)reloadFunctionViewWithData:(NSArray *)functionAry;

@end
