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
    if (name) {
        UIImage *image=[UIImage imageWithContentsOfFile:[LOCAL_PATH_PUBLIC stringByAppendingPathComponent:name]];
        return image;
    }
    else
        return nil;
    
}

+ ( UIImage  *)imageWithColor:( UIColor  *)color size:( CGSize )size{
    @autoreleasepool  {
        
        CGRect  rect =  CGRectMake ( 0 ,  0 , size. width , size. height );
        
        UIGraphicsBeginImageContext (rect. size );
        
        CGContextRef  context =  UIGraphicsGetCurrentContext ();
        
        CGContextSetFillColorWithColor (context,
                                        
                                        color. CGColor );
        
        CGContextFillRect (context, rect);
        
        UIImage  *img =  UIGraphicsGetImageFromCurrentImageContext ();
        
        UIGraphicsEndImageContext ();
        
        
        
        return  img;
        
    }
    
}

@end
