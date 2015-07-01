//
//  NTShare.h
//  NTLoveStore
//
//  Created by liying on 15/6/28.
//  Copyright (c) 2015年 liying. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol NTShare <NSObject>

- (BOOL)userIsLogin;

- (NSString *)userToken;

- (NSString *)userUid;

@end
#ifdef __cplusplus
extern "C" {
#endif
    id<NTShare> share(void);
    
#ifdef __cplusplus
}
#endif
