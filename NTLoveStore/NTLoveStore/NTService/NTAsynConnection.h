//
//  NTAsynConnection.h
//  NTLoveStore
//
//  Created by 李莹 on 15/6/8.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NTAsynConnection;
@protocol NTAsynConnectionDelegate <NSObject>

@optional
- (void)requestSuccessWithData:(NSDictionary *)dic;

@optional
- (void)requestFailWithData:(NSDictionary *)dic;

@end

@interface NTAsynConnection : NSObject

@property (nonatomic, assign)id delegate;

+ (void)requestWithHead:(NSString *)head WithBody:(NSDictionary *)bodyDic;

@end
