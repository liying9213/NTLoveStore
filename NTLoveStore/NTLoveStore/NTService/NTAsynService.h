//
//  NTAsynService.h
//  NTLoveStore
//
//  Created by 李莹 on 15/6/8.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTAsynService : NSObject

+ (void)requestWithHead:(NSString *)head WithBody:(NSDictionary *)bodyDic completionHandler:(void (^)(BOOL success, id finishData, NSError* connectionError)) handler;

@end
