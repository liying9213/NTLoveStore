//
//  NTFInishView.h
//  NTLoveStore
//
//  Created by NTTian on 15/7/11.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NTFInishView : UIView<UIGestureRecognizerDelegate>
typedef void (^Close)();
@property (nonatomic , strong) Close closeBlock;
- (void) showTheFinishView;

@end
