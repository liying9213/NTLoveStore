//
//  NTPayCodeView.h
//  NTLoveStore
//
//  Created by NTTian on 15/8/2.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NTPayCodeView : UIView<UIGestureRecognizerDelegate>
typedef void (^Close)();
@property (nonatomic , strong) Close closeBlock;
@property (strong, nonatomic) IBOutlet UIImageView *payCodeImageView;
@property (nonatomic, strong) NSString *imagePath;
- (void) showThepayCodeView;

@end
