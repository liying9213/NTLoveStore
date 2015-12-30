//
//  NTFunction.h
//  NTLoveStore
//
//  Created by NTTian on 15/7/2.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTFunction : NSObject <NSCoding>

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *name;
@property (nonatomic)int theID;
@property (nonatomic)int parentID;

@end
