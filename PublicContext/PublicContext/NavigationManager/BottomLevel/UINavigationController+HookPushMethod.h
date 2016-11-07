//
//  UINavigationController+HookPushMethod.h
//  NavigationManager-OC
//
//  Created by zhangchu on 16/8/10.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (HookPushMethod)
//导航栏类目，load自动执行，使用运行时交换消息传递
- (void)hook_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController *)hook_popViewControllerAnimated:(BOOL)animated;
- (void)hook_popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
-(void)hook_setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated;
-(void)hook_setViewControllers:(NSArray *)viewControllers;
@end
