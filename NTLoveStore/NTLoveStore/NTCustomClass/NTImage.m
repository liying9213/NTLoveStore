//
//  NTImage.m
//
//  Created by 李莹 on 15/3/17.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTImage.h"
#import "NTdefine.h"
@implementation NTImage

+ (UIImage *)imageWithFileName:(NSString *)name{
    
    UIImage *image=[UIImage imageWithContentsOfFile:[LOCAL_PATH_PUBLIC stringByAppendingPathComponent:name]];
    return image;
    
}

@end
