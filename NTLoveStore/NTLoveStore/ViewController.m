//
//  ViewController.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/1.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "ViewController.h"
#import "NTUserDefaults.h"
#import "NTLoginViewController.h"
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
    if (![NTUserDefaults GetTheDataForKey:@"login"])
    {
        NTLoginViewController *viewController=[[NTLoginViewController alloc] init];
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

#pragma mark - ResetView

- (void)ResetView{
    
}

- (void)ResetFunctionView{
    
}

- (void)ResetFunctionButtonWithData:(NSDictionary *)data{
    UIButton *funButton=[UIButton buttonWithType:UIButtonTypeCustom];
    funButton.backgroundColor=[UIColor clearColor];
    funButton.tag=[[data objectForKey:@"id"] integerValue];
//    funButton.frame=CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
    [self.view addSubview:funButton];
}


@end
