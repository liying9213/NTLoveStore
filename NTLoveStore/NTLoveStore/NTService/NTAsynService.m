//
//  NTAsynService.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/8.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTAsynService.h"
#import "NTUserDefaults.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
@implementation NTAsynService

+ (void)requestWithHead:(NSString *)head WithBody:(NSDictionary *)bodyDic completionHandler:(void (^)(BOOL success, id finishData, NSError* connectionError)) handler{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval=15;
    [manager POST:head parameters:bodyDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        __block id data=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        if (data&&[[data class]isSubclassOfClass:[NSDictionary class]]&&[data allKeys]&&[[data allKeys] count]==1&&!error) {
            if ([[[data allKeys] objectAtIndex:0] isEqualToString:@"status"]&&[[data objectForKey:@"status"] intValue]!=1) {
                [NTUserDefaults writeTheData:@"0" ForKey:@"status"];
                handler(NO,nil,error);
            }
            else{
                handler(YES,data,nil);
            }
        }
        else{
            if (!error) {
                handler(YES,data,nil);
            }
            else{
                handler(NO,nil,error);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         handler(NO,nil,error);
    }];
}

@end
