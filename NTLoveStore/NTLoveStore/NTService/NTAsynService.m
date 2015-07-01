//
//  NTAsynService.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/8.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTAsynService.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
@implementation NTAsynService

+ (void)requestWithHead:(NSString *)head WithBody:(NSDictionary *)bodyDic completionHandler:(void (^)(BOOL success, NSDictionary *finishDic, NSError* connectionError)) handler{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:head parameters:bodyDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        __block NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        if (!error) {
            handler(YES,dic,nil);
        }
        else{
            handler(NO,nil,error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         handler(NO,nil,error);
    }];
}

@end
