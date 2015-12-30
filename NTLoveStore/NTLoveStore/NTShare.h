//
//  NTShare.h
//  NTLoveStore
//
//  Created by NTTian on 15/6/28.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol NTShare <NSObject>

- (BOOL)userIsLogin;

- (NSString *)userToken;

- (NSString *)userUid;

- (void)setRootViewController;

@end
#ifdef __cplusplus
extern "C" {
#endif
    id<NTShare> share(void);
    
#ifdef __cplusplus
}
#endif
