//
//  NTUserDefaults.m
//  NTLoveStore
//
//  Created by liying on 15/6/2.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTUserDefaults.h"

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

@end
