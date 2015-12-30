//
//  NTUserDefaults.m
//  NTLoveStore
//
//  Created by NTTian on 15/6/2.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import "NTUserDefaults.h"
#import "NTFunction.h"
#import "NTReadConfiguration.h"
@implementation NTUserDefaults


+ (void)writeTheData:(id)data ForKey:(NSString *)key{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:key];
    data=nil;
}

+ (id)getTheDataForKey:(NSString *)key{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    id data = [defaults valueForKey:key];
    return data;
}

+ (void) writeTheFunctionData:(NSArray *)functionData{
    for (NSDictionary *dic in functionData) {
        if ([dic objectForKey:@"child"]) {
            [self writeTheData:[dic objectForKey:@"child"] ForKey:[dic objectForKey:@"id"]];
        }
    }
    functionData=nil;
}

+ (void)writeTheAdData:(NSArray *)adData{
    if (nil==adData||!adData.count>0) {
        return;
    }
    NSMutableArray *adAry=[[NSMutableArray alloc] init];
    NSMutableArray *homeAry=[[NSMutableArray alloc] init];
    for (NSDictionary *dic in adData) {
        if ([[dic objectForKey:@"place"] intValue]==1) {
            [adAry addObject:dic];
        }
        else{
            [homeAry addObject:dic];
        }
    }
    [self writeTheData:adAry ForKey:@"scrollADData"];
    [self writeHomeData:homeAry];
    adData=nil;
    adAry=nil;
    homeAry=nil;
}

+ (void)writeHomeData:(NSArray*)homeData{
    if (nil==homeData||!homeData.count>0) {
        return;
    }
    NSMutableArray *functionArray=[[NSMutableArray alloc] initWithArray:[NTReadConfiguration getConfigurationWithKey:@"homeViewData"]];
    for (NSDictionary *dic in homeData) {
        if ([[dic objectForKey:@"place"] intValue]==2) {
            NSMutableDictionary *mdic=[[NSMutableDictionary alloc] initWithDictionary:dic];
            [mdic setObject:[NSNumber numberWithInt:2] forKey:@"width"];
            [mdic setObject:[NSNumber numberWithInt:2] forKey:@"height"];
            [mdic setObject:[NSNumber numberWithInt:0] forKey:@"type"];
            [functionArray replaceObjectAtIndex:3 withObject:mdic];
        }
        else if ([[dic objectForKey:@"place"] intValue]==3){
            NSMutableDictionary *mdic=[[NSMutableDictionary alloc] initWithDictionary:dic];
            [mdic setObject:[NSNumber numberWithInt:3] forKey:@"width"];
            [mdic setObject:[NSNumber numberWithInt:1] forKey:@"height"];
            [mdic setObject:[NSNumber numberWithInt:0] forKey:@"type"];
            [functionArray replaceObjectAtIndex:1 withObject:mdic];
        }
        else{
            NSMutableDictionary *mdic=[[NSMutableDictionary alloc] initWithDictionary:dic];
            [mdic setObject:[NSNumber numberWithInt:2] forKey:@"width"];
            [mdic setObject:[NSNumber numberWithInt:1] forKey:@"height"];
            [mdic setObject:[NSNumber numberWithInt:0] forKey:@"type"];
            [functionArray replaceObjectAtIndex:8 withObject:mdic];
        }
    }
    [self writeTheData:functionArray ForKey:@"homeData"];
    homeData=nil;
    functionArray=nil;
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
