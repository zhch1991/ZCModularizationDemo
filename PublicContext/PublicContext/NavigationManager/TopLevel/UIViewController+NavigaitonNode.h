//
//  UIViewController+NavigaitonNode.h
//  NavigationManager-OC
//
//  Created by zhangchu on 16/7/29.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationNode.h"

@interface UIViewController (NavigaitonNode)

//给VC增加了一个node属性而已
@property(nonatomic,strong)NavigationNode *node;
@end


