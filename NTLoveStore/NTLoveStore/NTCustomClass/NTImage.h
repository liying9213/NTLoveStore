//
//  NTImage.h
//
//  Created by 李莹 on 15/3/17.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTImage : UIImage

+ (UIImage *)imageWithFileName:(NSString *)name;

+ ( UIImage  *)imageWithColor:( UIColor  *)color size:( CGSize )size;
@end
