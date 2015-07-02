//
//  NTShowDetailVIew.h
//  NTLoveStore
//
//  Created by liying on 15/6/30.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EGOImageView.h>

@interface NTShowDetailVIew : UIView

@property (nonatomic, strong)EGOImageView *showImageView;

- (void)showImageWithArray:(NSArray *)imageArray;

- (void)showTextWithString:(NSString *)string;

@end