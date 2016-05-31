//
//  AppDelegate.m
//  Volunteers
//
//  Created by yuan on 16/5/26.
//  Copyright © 2016年 yuan. All rights reserved.
//

#import "AppDelegate.h"
#import "AppConfigure.h"
#import "NavigationBar.h"
#import "Constants.h"
#import "TaskViewController.h"
#import "FootprintTableViewController.h"
#import "FriendsTableViewController.h"
#import "PersonViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //第一步，创建4个uiviewcontroller
    TaskViewController* oneView=[[TaskViewController alloc]init];
    oneView.tabBarItem.title=@"任务";
    
    FootprintTableViewController* twoView=[[FootprintTableViewController alloc]init];
    twoView.tabBarItem.title=@"足迹";
    
    FriendsTableViewController* threeView=[[FriendsTableViewController alloc]init];
    threeView.tabBarItem.title=@"好友";
    
    PersonViewController* fourView=[[PersonViewController alloc]init];
    fourView.tabBarItem.title=@"我的";
    
    UINavigationController *personNavigationController = [self navigationController];
    [personNavigationController setViewControllers:@[fourView]];
    
    UITabBarController * tabBar=[[UITabBarController alloc]init];
    
    UITabBarItem* barItem1=[[UITabBarItem alloc]initWithTitle:@"任务" image:[UIImage imageNamed:@"tabbar_item_home"]selectedImage:[UIImage imageNamed:@"tabbar_item_home_selected"]];
    oneView.tabBarItem=barItem1;
    
    UITabBarItem* barItem2=[[UITabBarItem alloc]initWithTitle:@"足迹" image:[UIImage imageNamed:@"tabbar_item_thing"]selectedImage:[UIImage imageNamed:@"tabbar_item_thing_selected"]];
    twoView.tabBarItem=barItem2;
    
    UITabBarItem* barItem3=[[UITabBarItem alloc]initWithTitle:@"好友" image:[UIImage imageNamed:@"tabbar_item_reading"]selectedImage:[UIImage imageNamed:@"tabbar_item_reading_selected"]];
    threeView.tabBarItem=barItem3;
    
    UITabBarItem* barItem4=[[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"tabbar_item_person"]selectedImage:[UIImage imageNamed:@"tabbar_item_person_selected"]];
    fourView.tabBarItem=barItem4;
    [tabBar viewControllers];
    
    tabBar.viewControllers=@[oneView,twoView,threeView,personNavigationController];
    
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController=tabBar;

    return YES;
}

- (UINavigationController *)navigationController
{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[NavigationBar class] toolbarClass:nil];
    [navigationController.navigationBar setOpaque:YES];
    navigationController.navigationBar.tintColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:229 / 255.0];
    
    return navigationController;
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
