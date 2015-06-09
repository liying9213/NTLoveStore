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
    self.view.backgroundColor=[NTColor lightGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![NTUserDefaults getTheDataForKey:@"login"])
    {
        NTLoginViewController *viewController=[[NTLoginViewController alloc] init];
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

#pragma mark - ResetView

- (void)ResetView{
    
}

- (void)ResetFunctionView{
    NSArray *functionArray=[NTReadConfiguration getConfigurationWithKey:@"functionData"];
    if (!functionArray)
    {
        for (NSDictionary *dic in functionArray) {
            [self ResetFunctionButtonWithData:dic];
        }
    }
}

- (void)ResetFunctionButtonWithData:(NSDictionary *)data{
    float width=(ScreenWidth-20)/6;
    UIButton *funButton=[UIButton buttonWithType:UIButtonTypeCustom];
    funButton.backgroundColor=[UIColor clearColor];
    funButton.tag=[[data objectForKey:@"id"] integerValue];
//    funButton.frame=CGRectMake(<#CGFloat x#>, <#CGFloat y#>, width*[[data objectForKey:@"width"] integerValue], 100);
    [self.view addSubview:funButton];
}

@end
