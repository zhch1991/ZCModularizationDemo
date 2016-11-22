//
//  AppDelegate.m
//  MainProject
//
//  Created by zhangchu on 16/8/15.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import "AppDelegate.h"
#import "PublicContext.h"
#import "ZCTabBarController.h"
#import "ZCConfigViewController.h"
#import "p1.h"
#import "p2.h"
#import "p3.h"
@interface AppDelegate ()<UITabBarControllerDelegate>
@property (nonatomic, strong) UINavigationController *nav;
@property (nonatomic, strong) UINavigationController *nav2;
@property (nonatomic, strong) UINavigationController *nav3;

@property (nonatomic, strong) P1ViewController *vc;
@property (nonatomic, strong) P2ViewController *vc2;
@property (nonatomic, strong) P3ViewController *vc3;
@property (nonatomic, strong) ZCTabBarController *tab;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _vc=[[P1ViewController alloc]init];
    _vc2=[[P2ViewController alloc]init];
    _vc3 =[[P3ViewController alloc]init];

    _nav=[[UINavigationController alloc]initWithRootViewController:_vc];
    _nav2=[[UINavigationController alloc]initWithRootViewController:_vc2];
    _nav3=[[UINavigationController alloc]initWithRootViewController:_vc3];
    [_nav setTabBarItem:[[UITabBarItem alloc]initWithTitle:@"第一页" image:nil selectedImage:nil]];
    [_nav2 setTabBarItem:[[UITabBarItem alloc]initWithTitle:@"第二页" image:nil selectedImage:nil]];
    [_nav3 setTabBarItem:[[UITabBarItem alloc]initWithTitle:@"第三页" image:nil selectedImage:nil]];
    _tab=[[ZCTabBarController alloc]init];
    _tab.delegate = self;
    [_tab setViewControllers:@[_nav,_nav2,_nav3]];
    [[NavigationManager manager] configWithTabBarController:_tab];
    self.window=[[UIWindow alloc]init];
    self.window.rootViewController=_tab;
    [self.window makeKeyAndVisible];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 50, 50);
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    _vc.navigationItem.rightBarButtonItem = btnItem;
    
    return YES;
}


- (void)mode1
{
    [_tab setViewControllers:@[_nav,_nav2,_nav3]];
    [[NavigationManager manager] configWithTabBarController:_tab];
    self.window.rootViewController=_tab;
    [self.window makeKeyAndVisible];
}

-(void)mode2
{
    [_tab setViewControllers:@[_nav]];
    [[NavigationManager manager] configWithTabBarController:_tab];
    self.window.rootViewController=_tab;
    [self.window makeKeyAndVisible];
}

-(void)mode3
{
    [_tab setViewControllers:@[_nav,_nav3]];
    [[NavigationManager manager] configWithTabBarController:_tab];
    self.window.rootViewController=_tab;
    [self.window makeKeyAndVisible];
}

-(void)mode4
{
    [_tab setViewControllers:@[_nav,_nav2]];
    [[NavigationManager manager] configWithTabBarController:_tab];
    self.window.rootViewController=_tab;
    [self.window makeKeyAndVisible];
}

- (void)btnClicked:(UIButton *)btn
{
    ZCConfigViewController *configVC = [[ZCConfigViewController alloc] init];
    [_vc.navigationController pushViewController:configVC animated:YES];
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

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
