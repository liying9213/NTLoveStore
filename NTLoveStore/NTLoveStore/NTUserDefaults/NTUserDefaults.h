//
//  NTUserDefaults.h
//  NTLoveStore
//
//  Created by liying on 15/6/2.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTUserDefaults : NSObject

+ (void)writeTheData:(id)data ForKey:(NSString *)key;

+ (id)getTheDataForKey:(NSString *)key;

+ (void) writeTheFunctionData:(NSArray *)functionData;

@end
