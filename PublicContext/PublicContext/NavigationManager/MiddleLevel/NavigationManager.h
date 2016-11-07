//
//  NavigationManager.h
//  NavigationManager-OC
//
//  Created by zhangchu on 16/7/29.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NavigationNode.h"
#import "UIViewController+NavigaitonNode.h"

@interface NavigationManager : NSObject
//实例化方法
+(instancetype)manager;
//注册功能
-(void)configWithTabBarController:(UITabBarController *)tabBarController;
//
-(void)setNavigationNode:(NavigationNode *)node;
-(void)configNavigationPathWithString:(NSString *)path identifier:(NSString *)identifier;
-(void)pushWithViewIdentifier:(NSString *)identifier animated:(BOOL)animated;
-(void)popWithIdentifier:(NSString *)identifier to:(NSString *)className animated:(BOOL)animated;
@end
