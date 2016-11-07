//
//  UIViewController+NavigationManager.h
//  NavigationManager-OC
//
//  Created by zhangchu on 16/8/8.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationManager)
//给VC增加了一系列管理方法而已
-(void)nextViewController;
-(void)previousViewController;
-(void)pushWithPath:(NSString *)path;
-(void)popWithClassName:(NSString *)VCName;
-(void)pushOrPopWithClassName:(NSString *)VCName;
@end
