//
//  ServiceOperation.m
//  NavigationManager-OC
//
//  Created by CZ on 16/8/8.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import "CommonServiceOperation.h"

@interface CommonServiceOperation ()
{
    BOOL                        _isExecuting;
    BOOL                        _isFinished;
    id <CommonServiceDelegate>  _service;
}
@end
@implementation CommonServiceOperation

#pragma mark - 线程队列自动调用的入口方法（同步异步未知）
//自定义operation中先重写这个main方法，执行主任务
- (void)main
{
    //将线程的正在执行标志置位
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];
    //执行任务
    [self handleService];
}

#pragma mark - 系统方法
//系统方法，线程同步时候系统自动调用，作用是判断异步还是同步
//默认operation任务节点是在调用start的那个线程中同步执行
//NSOperation对象的isConcurrent方法会告诉我们这个操作相对于调用start方法的线程,是同步还是异步执行。isConcurrent方法默认返回NO,表示操作与调用线程同步执行
- (BOOL)isConcurrent
{
    //如果当前operation是同步执行的，就返回NO，异步执行的返回YES
    if (self.synchronous) {
        return NO;
    } else {
        return YES;
    }
}


//系统方法，作用是取消当前任务节点执行
- (void)cancel
{
    [super cancel];

    //如果任务异步执行，调用服务的取消回调（）
    if (!self.synchronous && _service) {
        if ([_service respondsToSelector:@selector(cancelService)]) {
            [_service cancelService];
        }
    }

    //调用完成方法
    [self finish];
}

#pragma mark - 传入任务初始化
- (instancetype)initWithService:(id <CommonServiceDelegate>)service
{
    self = [super init];

    if (self) {
        _service = service;
    }

    return self;
}

#pragma mark - 私有方法
- (void)handleService
{
    if (self.isCancelled) {
        [self cancel];
    }

    //如果没有服务执行，则直接返回
    if (!_service) {
        [self finish];
        return;
    }

    //如果有服务，则调用服务启动方法callService
    if ([_service respondsToSelector:@selector(callService)]) {
        [_service callService];
    }

    //如果有完成回调，执行
    if (self.completeBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completeBlock();
        });
        
    }
}

//私有方法，当前任务operation运行结束
- (void)finish
{
    if (_isFinished || !_isExecuting) {
        return;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    
    _isExecuting = NO;
    _isFinished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

#pragma mark - 公共方法
//公共方法，手动同步执行任务（异步可能有问题，留一个同步接口可以保证操作依赖顺序）
- (void)syncService
{
    //如果当前任务operation已经被取消
    //调用cancel方法
    if (self.isCancelled) {
        [self cancel];
    }

    //如果没有服务传入，直接finish
    if (!_service) {
        [self finish];
        return;
    }

    //如果有服务，则调用服务
    if ([_service respondsToSelector:@selector(callService)]) {
        [_service callService];
    }
}



@end
