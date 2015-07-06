//
//  AppDelegate.m
//  NTLoveStore
//
//  Created by 李莹 on 15/6/1.
//  Copyright (c) 2015年 liying. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NTLoginViewController.h"
static id<NTShare> _share = nil;

id<NTShare> share(void)
{
    return _share;
}

@interface AppDelegate ()

@end

@implementation AppDelegate
-(id)init
{
    self = [super init];
    if (self) {
        _share = self;
    }
    return  self;
}

- (void)setRootViewController{
    ViewController *viewController=[[ViewController alloc] init];
    UINavigationController *rootView=[[UINavigationController alloc] initWithRootViewController:viewController];    
    self.window.rootViewController=rootView;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    if ([self userIsLogin]) {
        [self setRootViewController];
    }
    else{
        NTLoginViewController *rootViewController=[[NTLoginViewController alloc] init];
        self.window.rootViewController=rootViewController;
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - NTShare

- (BOOL)userIsLogin{
    BOOL login=[[NTUserDefaults getTheDataForKey:@"status"] boolValue];
    return login;
}

- (NSString *)userToken{
    NSString * token=[NTUserDefaults getTheDataForKey:@"token"];
    return token;
}

- (NSString *)userUid{
    NSString * token=[NTUserDefaults getTheDataForKey:@"uid"];
    return token;
}


@end
