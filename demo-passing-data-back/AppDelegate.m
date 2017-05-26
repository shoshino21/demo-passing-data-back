//
//  AppDelegate.m
//  demo-passing-data-back
//
//  Created by shoshino21 on 5/26/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  UIViewController *vc1 = [UIViewController new];
  UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:vc1];
  nc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"1" image:[UIImage imageNamed:@"home"] tag:0];

  UIViewController *vc2 = [UIViewController new];
  UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:vc2];
  nc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"2" image:[UIImage imageNamed:@"home"] tag:0];

  UITabBarController *tbc = [UITabBarController new];
  tbc.viewControllers = @[ nc1, nc2 ];
  tbc.selectedViewController = nc1;
  [UITabBar appearance].tintColor = [UIColor redColor];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.window.rootViewController = tbc;
  [self.window makeKeyAndVisible];


  MainViewController *mvc = [MainViewController new];
  mvc.view.backgroundColor = [UIColor whiteColor];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.window.rootViewController = mvc;
  [self.window makeKeyAndVisible];

  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
