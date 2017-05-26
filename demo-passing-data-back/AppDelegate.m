//
//  AppDelegate.m
//  demo-passing-data-back
//
//  Created by shoshino21 on 5/26/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

#import "AppDelegate.h"

#import "DelegateMainViewController.h"
#import "BlockMainViewController.h"
#import "NotificationMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.

  DelegateMainViewController *dmvc = [DelegateMainViewController new];
  UINavigationController *dnc = [[UINavigationController alloc] initWithRootViewController:dmvc];
  dnc.tabBarItem = [[UITabBarItem alloc] initWithTitle:kTabTitle1 image:nil tag:0];

  BlockMainViewController *bmvc = [BlockMainViewController new];
  UINavigationController *bnc = [[UINavigationController alloc] initWithRootViewController:bmvc];
  bnc.tabBarItem = [[UITabBarItem alloc] initWithTitle:kTabTitle2 image:nil tag:0];

  NotificationMainViewController *nmvc = [NotificationMainViewController new];
  UINavigationController *nnc = [[UINavigationController alloc] initWithRootViewController:nmvc];
  nnc.tabBarItem = [[UITabBarItem alloc] initWithTitle:kTabTitle3 image:nil tag:0];

  UITabBarController *tbc = [UITabBarController new];
  tbc.viewControllers = @[ dnc, bnc, nnc ];
  tbc.selectedViewController = dnc;
  [UITabBar appearance].tintColor = [UIColor redColor];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.window.rootViewController = tbc;
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
