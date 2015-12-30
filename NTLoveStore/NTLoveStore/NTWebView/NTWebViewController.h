//
//  NTWebViewController.h
//  NTLoveStore
//
//  Created by NTTian on 15/6/17.
//  Copyright (c) 2015年 NTTian. All rights reserved.
//

#import "NTParentViewController.h"

@interface NTWebViewController : NTParentViewController<UIWebViewDelegate>

@property (nonatomic, strong) NSString *urlPath;

@property (nonatomic, strong) UIWebView *webView;

@end
