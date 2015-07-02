//
//  NTFunction.h
//  NTLoveStore
//
//  Created by 李莹 on 15/7/2.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTFunction : NSObject <NSCoding>

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *name;
@property (nonatomic)int theID;
@property (nonatomic)int parentID;

@end
