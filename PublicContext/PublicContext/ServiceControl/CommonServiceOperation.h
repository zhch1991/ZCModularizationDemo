//
//  ServiceOperation.h
//  NavigationManager-OC
//
//  Created by CZ on 16/8/8.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonServiceDelegate.h"

typedef void (^ ServiceCompleteBlock)();

@interface CommonServiceOperation : NSOperation
@property(nonatomic,assign)BOOL synchronous;
@property(nonatomic,copy,nullable)ServiceCompleteBlock completeBlock;

-(nullable instancetype )initWithService:(nonnull id<CommonServiceDelegate>)service;

//如果想在当前线程里手动执行，调用这个方法
- (void)syncService;
@end
