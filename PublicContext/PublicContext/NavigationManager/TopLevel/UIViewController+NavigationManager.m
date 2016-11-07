//
//  UIViewController+NavigationManager.m
//  NavigationManager-OC
//
//  Created by zhangchu on 16/8/8.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import "UIViewController+NavigationManager.h"
#import "NavigationManager.h"
#import "UIViewController+NavigaitonNode.h"
@implementation UIViewController (NavigationManager)
-(void)nextViewController
{
    [[NavigationManager manager] pushWithViewIdentifier:self.node.identifier animated:YES];
}
-(void)previousViewController
{
    [[NavigationManager manager] popWithIdentifier:self.node.identifier to:nil animated:YES];
}
-(void)pushWithPath:(NSString *)path
{
    [[NavigationManager manager] configNavigationPathWithString:path identifier:self.node.identifier];
    [self nextViewController];
}
-(void)popWithClassName:(NSString *)VCName
{
    [[NavigationManager manager] popWithIdentifier:self.node.identifier to:VCName animated:YES];
}
-(void)pushOrPopWithClassName:(NSString *)VCName
{
    NavigationNode *node=self.node.previousNode;
    while  (![VCName isEqualToString:NSStringFromClass([node getViewController].class)]&&node.previousNode){
        node=node.previousNode;
    }
    if ([VCName isEqualToString:NSStringFromClass([node getViewController].class)]) {
        [self popWithClassName:VCName];
    }else
    {
        [self pushWithPath:[NSString stringWithFormat:@"=>%@",VCName]];
    }
}

@end
