//
//  ViewController.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/1.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "ViewController.h"
#import "NTLoginViewController.h"
#import "NTReadConfiguration.h"
#import "NTUserDefaults.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ResetView];
    if (![NTUserDefaults getTheDataForKey:@"login"])
    {
        NTLoginViewController *viewController=[[NTLoginViewController alloc] init];
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - ResetView

- (void)ResetView{
    functionBtnXValue=0;
    functionBtnYValue=ScreenHeight-(ScreenWidth/6*3+64);
    [self ResetScrollImageView];
    [self ResetFunctionView];
}

- (void)ResetScrollImageView{
    EGOImageView *imageView=[[EGOImageView alloc] initWithPlaceholderImage:nil];
    imageView.frame=CGRectMake(0, 0, ScreenWidth, functionBtnYValue);
    imageView.backgroundColor=[NTColor yellowColor];
    [imageView setImageURL:[NSURL URLWithString:@"http://hunhuiwang.xmbt21.com/uploadfile/2015/0113/20150113094734766.jpg"]];
    [self.view addSubview:imageView];
}

- (void)ResetFunctionView{
    NSArray *functionArray=[NTReadConfiguration getConfigurationWithKey:@"functionData"];
    if (functionArray)
    {
        for (NSDictionary *dic in functionArray) {
            [self ResetFunctionButtonWithData:dic];
        }
    }
}

- (void)ResetFunctionButtonWithData:(NSDictionary *)data{
    float width=ScreenWidth/6;
    UIButton *funButton=[UIButton buttonWithType:UIButtonTypeCustom];
    funButton.backgroundColor=[UIColor clearColor];
    funButton.tag=[[data objectForKey:@"id"] integerValue];
    [funButton setTitle:[data objectForKey:@"name"] forState:UIControlStateNormal];
    funButton.frame=CGRectMake(functionBtnXValue, functionBtnYValue, width*[[data objectForKey:@"width"] integerValue], width);
    [funButton setBackgroundColor:[NTColor colorWithHexString:[data objectForKey:@"color"]]];
    [self.view addSubview:funButton];
    if (functionBtnXValue+funButton.frame.size.width<ScreenWidth) {
        functionBtnXValue+=funButton.frame.size.width;
    }
    else{
        functionBtnXValue=0;
        functionBtnYValue+=width;
    }
}



@end
