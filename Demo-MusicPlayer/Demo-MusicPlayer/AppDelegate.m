//
//  AppDelegate.m
//  Demo-MusicPlayer
//
//  Created by Aspmcll on 16/1/7.
//  Copyright © 2016年 Aspmcll. All rights reserved.
//

#import "AppDelegate.h"
#import "CLCurrentPlayControl.h"
#import "CLOnlieMusicControl.h"
#import "CLGroupControl.h"
#import "CLSettingContro.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
   //    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
//    
//    UINavigationController *myMusic=[[UINavigationController alloc] initWithRootViewController:[[CLGroupControl alloc] init]];
//    
//    UINavigationController *playMuisc=[[UINavigationController alloc] initWithRootViewController:[[CLOnlieMusicControl alloc] init]];
//    
//    UINavigationController *setMusic=[[UINavigationController alloc] initWithRootViewController:[[CLSettingContro alloc] init]];
//    
//    UITabBarController *tab=[[UITabBarController alloc] init];
//    
//    tab.viewControllers=@[myMusic,playMuisc,setMusic];
//    self.window.rootViewController=tab;
//    [self.window makeKeyAndVisible];
    NSDictionary *arrtributeDic = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                    
                                    };
    [[UITabBarItem appearance] setTitleTextAttributes:arrtributeDic forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:arrtributeDic forState:UIControlStateSelected];
    
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

@end
