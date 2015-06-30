//
//  NTHeadSelectView.h
//  NTLoveStore
//
//  Created by 李莹 on 15/6/10.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NTHeadSelectView;

@protocol NTHeadSelectViewDelegate <NSObject>

@required

- (void)headSelectAction:(id)sender;

@end


@interface NTHeadSelectView : UIView

@property (nonatomic, assign)id delegate;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSArray *selectData;
@property (nonatomic, strong)UIView *selcetBackGroundView;
@property (nonatomic, assign)NSInteger selectTag;
- (id)initWithFrame:(CGRect)frame;
- (void)creatHeadSelectView;
- (void)selectTheTag:(NSInteger)tag;

@end
