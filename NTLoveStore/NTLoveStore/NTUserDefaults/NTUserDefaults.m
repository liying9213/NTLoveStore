//
//  NTUserDefaults.m
//  NTLoveStore
//
//  Created by liying on 15/6/2.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTUserDefaults.h"
#import "NTFunction.h"
@implementation NTUserDefaults


+ (void)writeTheData:(id)data ForKey:(NSString *)key{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:key];
}

+ (id)getTheDataForKey:(NSString *)key{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    id data = [defaults valueForKey:key];
    return data;
}

+ (void) writeTheFunctionData:(NSArray *)functionData{
    for (NSDictionary *dic in functionData) {
        if ([dic objectForKey:@"child"]) {
            NSMutableArray *array=[[NSMutableArray alloc] init];
            for (NSDictionary *idic in [dic objectForKey:@"child"]) {
                [array addObject:[self getFunctionWithData:idic]];
            }
            [self writeTheData:array ForKey:[dic objectForKey:@"id"]];
        }
    }
}

+ (NTFunction *)getFunctionWithData:(NSDictionary *)dic{
    __block NTFunction *function=[[NTFunction alloc] init];
    function.title=[dic objectForKey:@"title"];
    function.name=[dic objectForKey:@"name"];
    function.theID=[[dic objectForKey:@"id"] intValue];
    function.parentID=[[dic objectForKey:@"pid"] intValue];
    return function;
}

@end
