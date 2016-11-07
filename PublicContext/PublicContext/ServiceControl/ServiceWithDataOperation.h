//
//  ServiceWithDataOperation.h
//  NavigationManager-OC
//
//  Created by zhangchu on 16/8/8.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceWithDataDelegate.h"


typedef void (^ ServiceWithDataCompleteBlock)( NSDictionary * _Nullable result);

@interface ServiceWithDataOperation :NSOperation

@property(nonatomic,assign)BOOL synchronous;
@property(nonatomic,copy,nullable)ServiceWithDataCompleteBlock completeBlock;
@property(nonatomic,copy,nullable)NSDictionary *params;

-(nullable instancetype )initWithService:(nonnull id<ServiceWithDataDelegate>)service;
- (nullable NSDictionary *)syncService;
@end
