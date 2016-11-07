//
//  NavigationManager.m
//  NavigationManager-OC
//
//  Created by zhangchu on 16/7/29.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import "NavigationManager.h"
#import "UINavigationController+HookPushMethod.h"

#define tabChildViewControllerIdentifier @"tab"
#define navigationConfig @[@"ViewController=>ViewController1=>ViewController1",@"ViewController2=>ViewController4"]

@implementation NavigationManager
{
    NSMutableDictionary<NSString *, NavigationNode*> *_nodeDictionary;
}
-(instancetype)init
{
    self=[super init];
    
    if (self) {
        _nodeDictionary=[[NSMutableDictionary alloc]init];;
    }
    return self;
}
+(instancetype)manager
{
    static NavigationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    
    return manager;
}

//注册功能
-(void)configWithTabBarController:(UITabBarController *)tabBarController
{
    //将每个tab中的导航栏中的栈顶VC，都创建为导航节点，存至路由管理器的字典中
    for (UINavigationController *navViewController in tabBarController.viewControllers) {
        if ([navViewController isKindOfClass:[UINavigationController class]]) {
            UIViewController *vc=navViewController.topViewController;
            NavigationNode *node=[[NavigationNode alloc]initWithViewController:vc identifier:[NSString stringWithFormat:@"%@%u",tabChildViewControllerIdentifier,[tabBarController.viewControllers indexOfObject:navViewController]]];
   
            [_nodeDictionary setObject:node forKey:node.identifier];
            
        }
    }
}
-(void)setNavigationNode:(NavigationNode *)node
{
    if (node) {
        [_nodeDictionary setObject:node forKey:node.identifier];
    }
}

-(void)configNavigationPathWithString:(NSString *)path identifier:(NSString *)identifier
{
    NavigationNode *node=_nodeDictionary[identifier];
    node.nextNodePath=path;
}

//向后跳转
-(void)pushWithViewIdentifier:(NSString *)identifier animated:(BOOL)animated
{
    NavigationNode *node=_nodeDictionary[identifier];
    if (!node.nextNodePath||[node.nextNodePath isEqualToString:@"=>"]) {
        //这里是默认的预设跳转路径配置，如果传入的node没有next节点，且满足预设跳转路径中的一环，则按照预设跳转路径跳转，如果二者都不满足，则不做任何操作
        //a=>b=>c
        for (NSString *configString in navigationConfig) {
            NSMutableArray *array= [NSMutableArray arrayWithArray:[configString componentsSeparatedByString:@"=>"]];
            for (int i=0 ; i<array.count ;) {
                    NSString *className=array[i];
                [array removeObjectAtIndex:0];
                //a=>b=>c,如果传入的是nodeA，则nodeA.nextNodePath变为 =>b=>c
                //如果路径配置数组中的类，是当前传入参数node对应的VC，则将当前传入参数node中nextNodePath属性赋值为（=>）
                if ([className isEqualToString:NSStringFromClass([node getViewController].class)]) {
                    node.nextNodePath=[NSString stringWithFormat:@"=>%@",[array componentsJoinedByString:@"=>"]];
                    break;
                }
                
            }
            
        }
    }
    //获取到b的node：nodeB
    if ([node getNextNode]) {
        NavigationNode *nextNode=[node getNextNode];
        [_nodeDictionary setObject:nextNode forKey:nextNode.identifier];
        //真正的跳转，有nodeA的VC，跳转到nodeB的VC
        [[node getViewController].navigationController hook_pushViewController:[nextNode getViewController] animated:animated];
        NSLog(@"%@",nextNode.description);
    }
    
}

//向前跳转至某个类
-(void)popWithIdentifier:(NSString *)identifier to:(NSString *)className animated:(BOOL)animated
{
    NavigationNode *node=_nodeDictionary[identifier];
    if (node.previousNode&&[node getViewController]) {
        if (className.length>0) {
            //如果指定跳到哪个类
            //向跳转链的前面循环，直至找到要跳转到的那个className所对应的node
            node=node.previousNode;
            while  (![className isEqualToString:NSStringFromClass([node getViewController].class)]&&node.previousNode)   {
                node=node.previousNode;
            }
            //缓存这个实例化过的node
            [_nodeDictionary setObject:node forKey:node.identifier];
            _nodeDictionary[node.identifier]=node;
            NSLog(@"%@",node.description);
            //正常的pop跳转
            [[node getViewController].navigationController hook_popToViewController:[node getViewController] animated:animated];
        }else{
            //如果没有指定跳到哪个类，就跳向前一个node
            [_nodeDictionary setObject:node.previousNode forKey:node.previousNode.identifier];
            NSLog(@"%@",node.previousNode.description);
            
            [[node getViewController].navigationController hook_popViewControllerAnimated:animated];
        }
    }
}
@end
