//
//  UINavigationController+HookPushMethod.m
//  NavigationManager-OC
//
//  Created by zhangchu on 16/8/10.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import "UINavigationController+HookPushMethod.h"
#import "NavigationManager.h"
#import <objc/runtime.h>
@implementation UINavigationController (HookPushMethod)

+(void)load
{
    //第一组
    SEL originalSelectorPush = @selector(pushViewController:animated:);
    SEL swizzledSelectorPush = @selector(hook_pushViewController:animated:);
    
    Method originalMethodPush = class_getInstanceMethod([self class], originalSelectorPush);
    Method swizzledMethodPush = class_getInstanceMethod([self class], swizzledSelectorPush);
    
    
    method_exchangeImplementations(originalMethodPush, swizzledMethodPush);
    
    //第二组
    SEL originalSelectorPop = @selector(popViewControllerAnimated:);
    SEL swizzledSelectorPop = @selector(hook_popViewControllerAnimated:);
    
    Method originalMethodPop = class_getInstanceMethod([self class], originalSelectorPop);
    Method swizzledMethodPop = class_getInstanceMethod([self class], swizzledSelectorPop);
    
    
    method_exchangeImplementations(originalMethodPop, swizzledMethodPop);
    
    //第三组
    SEL originalSelectorPopToRoot = @selector(popToRootViewControllerAnimated:);
    SEL swizzledSelectorPopToRoot = @selector(hook_popToRootViewControllerAnimated:);
    
    Method originalMethodPopToRoot = class_getInstanceMethod([self class], originalSelectorPopToRoot);
    Method swizzledMethodPopToRoot = class_getInstanceMethod([self class], swizzledSelectorPopToRoot);
    
    
    method_exchangeImplementations(originalMethodPopToRoot, swizzledMethodPopToRoot);
    
    //第四组
    SEL originalSelectorPopToVC = @selector(popToViewController:animated:);
    SEL swizzledSelectorPopToVC = @selector(hook_popToViewController:animated:);
    
    Method originalMethodPopToVC = class_getInstanceMethod([self class], originalSelectorPopToVC);
    Method swizzledMethodPopToVC = class_getInstanceMethod([self class], swizzledSelectorPopToVC);
    
    
    method_exchangeImplementations(originalMethodPopToVC, swizzledMethodPopToVC);
    
    //第五组
    SEL originalSelectorSetVCsA = @selector(setViewControllers:animated:);
    SEL swizzledSelectorSetVCsA = @selector(hook_setViewControllers:animated:);
    
    Method originalMethodSetVCsA = class_getInstanceMethod([self class], originalSelectorSetVCsA);
    Method swizzledMethodSetVCsA = class_getInstanceMethod([self class], swizzledSelectorSetVCsA);
    
    
    method_exchangeImplementations(originalMethodSetVCsA, swizzledMethodSetVCsA);
    
    //第六组
    SEL originalSelectorSetVCs = @selector(setViewControllers:);
    SEL swizzledSelectorSetVCs = @selector(hook_setViewControllers:);
    
    Method originalMethodSetVCs = class_getInstanceMethod([self class], originalSelectorSetVCs);
    Method swizzledMethodSetVCs = class_getInstanceMethod([self class], swizzledSelectorSetVCs);
    
    
    method_exchangeImplementations(originalMethodSetVCs, swizzledMethodSetVCs);
}
- (void)hook_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //钩出原始push方法，将当前跳转的VC，做成node，存入manager缓存
    if (self.topViewController.node) {
        NavigationNode *node = [[NavigationNode alloc]initWithViewController:viewController identifier:self.topViewController.node.identifier];
        viewController.node = node;
        node.previousNode = self.topViewController.node;
        
        [[NavigationManager manager] setNavigationNode:node];
    }
    [self hook_pushViewController:viewController animated:animated];
}

- (UIViewController *)hook_popViewControllerAnimated:(BOOL)animated
{
    if (self.topViewController.node.previousNode) {
        [[NavigationManager manager] setNavigationNode:self.topViewController.node.previousNode];
    }
    return [self hook_popViewControllerAnimated:animated];
}

- (NSArray <__kindof UIViewController *> *)hook_popToRootViewControllerAnimated:(BOOL)animated
{
    if ([self.viewControllers firstObject].node) {
         [[NavigationManager manager] setNavigationNode:[self.viewControllers firstObject].node];
    }
    return [self hook_popToRootViewControllerAnimated:animated];
}

- (void)hook_popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController.node) {
        [[NavigationManager manager] setNavigationNode:viewController.node];
    }
    
    return [self hook_popToViewController:viewController animated:animated];
}

-(void)hook_setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
    UIViewController *prevVC=nil;
    for (UIViewController *vc in viewControllers) {
        NavigationNode *node = [[NavigationNode alloc]initWithViewController:vc identifier:self.topViewController.node.identifier];
        vc.node = node;
        node.previousNode = prevVC.node;
        [[NavigationManager manager] setNavigationNode:node];
        prevVC=vc;
    }
    [self hook_setViewControllers:viewControllers animated:animated];
}
-(void)hook_setViewControllers:(NSArray *)viewControllers
{
    UIViewController *prevVC=nil;
    for (UIViewController *vc in viewControllers) {
        NavigationNode *node = [[NavigationNode alloc]initWithViewController:vc identifier:self.topViewController.node.identifier];
        vc.node = node;
        node.previousNode = prevVC.node;
        [[NavigationManager manager] setNavigationNode:node];
        prevVC=vc;
    }
    [self hook_setViewControllers:viewControllers];
}
@end
