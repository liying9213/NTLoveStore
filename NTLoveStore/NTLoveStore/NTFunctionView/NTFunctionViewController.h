//
//  NTFunctionViewController.h
//  NTLoveStore
//
//  Created by 李莹 on 15/6/10.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTParentViewController.h"
#import "NTHeadSelectView.h"
@interface NTFunctionViewController : NTParentViewController<NTHeadSelectViewDelegate>

@property (nonatomic, assign)NSInteger currentID;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIView *leftView;

@end
