//
//  NavigationNode.h
//  NavigationManager-OC
//
//  Created by zhangchu on 16/7/29.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NavigationNode : NSObject

//下游跳转链条描述（next链条描述，用于push）
@property(nonatomic,copy)NSString *nextNodePath;
//索引
@property(nonatomic,copy)NSString *identifier;
//上一个node（prev指针，用于pop）
@property(nonatomic,strong)NavigationNode *previousNode;

-(instancetype)initWithViewController:(UIViewController *)viewController identifier:(NSString *)identifier;
-(NavigationNode *)getNextNode;
-(UIViewController *)getViewController;
@end
