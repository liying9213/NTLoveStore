//
//  NTWebViewController.m
//  NTLoveStore
//
//  Created by liying on 15/6/17.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "NTWebViewController.h"

@interface NTWebViewController ()

@end

@implementation NTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - resetView

- (void)resetView{
    _webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(self.view.frame))];
    _webView.delegate=self;
    _webView.scalesPageToFit=YES;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlPath]]];
    [self.view addSubview:_webView];
}

#pragma mark - webViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self showWaitingViewWithText:@"正在加载..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self hideWaitingView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self showEndViewWithText:error.localizedFailureReason];
}

- (void)backBtnAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
