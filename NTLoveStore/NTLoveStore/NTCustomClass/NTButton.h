//
//  NTButton.h
//  NTLoveStore
//
//  Created by NTTian on 15/6/10.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTButton : UIButton

@property (nonatomic, strong) NSString *keyWord;
@property (nonatomic) NSInteger section;
@property (nonatomic, copy) NSString*contentPath;
@end
