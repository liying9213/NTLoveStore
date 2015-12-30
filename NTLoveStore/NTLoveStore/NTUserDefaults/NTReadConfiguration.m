//
//  NTReadConfiguration.m
//  NTLoveStore
//
//  Created by NTTian on 15/6/9.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import "NTReadConfiguration.h"
#import "NTdefine.h"
@implementation NTReadConfiguration

+ (id)getConfigurationWithKey:(NSString *)key{
    NSString *path=[LOCAL_PATH_PUBLIC stringByAppendingPathComponent:@"NTConfigurationFile.plist"];
    __autoreleasing NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    return [dic objectForKey:key];
}

@end
