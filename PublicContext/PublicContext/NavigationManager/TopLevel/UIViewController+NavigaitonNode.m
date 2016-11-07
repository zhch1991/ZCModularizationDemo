//
//  UIViewController+NavigaitonNode.m
//  NavigationManager-OC
//
//  Created by zhangchu on 16/7/29.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import "UIViewController+NavigaitonNode.h"
#import <objc/runtime.h>
static const NSString *nodekey=@"navigationNodeKey";
@implementation UIViewController (NavigaitonNode)


-(void)setNode:(NavigationNode *)node
{
    objc_setAssociatedObject(self, &nodekey, node, OBJC_ASSOCIATION_ASSIGN);
}
-(NavigationNode *)node
{
    return objc_getAssociatedObject(self, &nodekey);
}

@end
