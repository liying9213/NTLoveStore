//
//  NTReadConfiguration.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/9.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTReadConfiguration.h"
#import "NTdefine.h"
@implementation NTReadConfiguration

+ (id)getConfigurationWithKey:(NSString *)key{
    NSString *path=[LOCAL_PATH_PUBLIC stringByAppendingPathComponent:@"applicationConfig.plist"];
    __autoreleasing NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    return [dic objectForKey:key];
}

@end
