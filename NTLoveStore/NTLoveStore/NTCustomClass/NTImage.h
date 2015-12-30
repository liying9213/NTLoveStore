//
//  NTImage.h
//
//  Created by NTTian on 15/3/17.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTImage : UIImage

+ (UIImage *)imageWithFileName:(NSString *)name;

+ ( UIImage  *)imageWithColor:( UIColor  *)color size:( CGSize )size;
@end
