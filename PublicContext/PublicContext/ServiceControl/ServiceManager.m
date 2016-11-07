//
//  ServiceManager.m
//  NavigationManager-OC
//
//  Created by zhangchu on 16/8/5.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import "ServiceManager.h"
#import "CommonServiceOperation.h"
#import "ServiceWithDataOperation.h"
#import "NoService.h"
@interface ServiceManager ()
@property(nonatomic, strong) NSOperationQueue *serviceQueue;
@end
@implementation ServiceManager

//析构方法，中断所有线程
- (void)dealloc
{
    [_serviceQueue cancelAllOperations];
}

//初始化方法，初始化线程队列，并行数5
- (instancetype)init
{
    self = [super init];

    if (self) {
        _serviceQueue = [[NSOperationQueue alloc]init];
        _serviceQueue.maxConcurrentOperationCount = 5;
    }

    return self;
}

//单例
+ (ServiceManager *)manager
{
    static dispatch_once_t  once;
    static ServiceManager   *manager;

    dispatch_once(&once, ^{
        manager = [self new];
    });
    return manager;
}

//加载服务，无参
+ (void)loadService:(NSString *)serviceName withCallBack:(void (^)())block
{
    [self loadService:serviceName withParams:nil withCallBack:block synchronous:NO];
}

//加载服务，有参
+(void)loadService:(NSString *)serviceName withParams:(NSDictionary *)params withCallBack:(void(^)(NSDictionary *result))block synchronous:(BOOL)isSynchronous
{
    __kindof NSOperation * operation = [self createOperationWithServiceName:serviceName];

    if ([operation isKindOfClass:[CommonServiceOperation class]]) {
        CommonServiceOperation *commonServiceOperation = operation;
        commonServiceOperation.completeBlock = block;
        commonServiceOperation.synchronous=isSynchronous;

    } else if ([operation isKindOfClass:[ServiceWithDataOperation class]])
    {
        ServiceWithDataOperation *serviceWithDataOperation = operation;
        serviceWithDataOperation.params = params;
        serviceWithDataOperation.completeBlock = block;
        serviceWithDataOperation.synchronous=isSynchronous;

    }
    if (isSynchronous) {
        [operation start];
    }else
    {
        [[self manager].serviceQueue addOperation:operation];
        NSLog(@"service count:%lu",(unsigned long)[[self manager].serviceQueue operationCount]);
    }
    
    
}

+ (NSDictionary *)syncServiceData:(NSString *)serviceName withParams:(NSDictionary *)params
{
    __kindof NSOperation *operation = [self createOperationWithServiceName:serviceName];
    if ([operation isKindOfClass:[CommonServiceOperation class]]) {
        CommonServiceOperation *commonServiceOperation = operation;
        [commonServiceOperation syncService];
    } else if ([operation isKindOfClass:[ServiceWithDataOperation class]])
    {
        ServiceWithDataOperation *serviceWithDataOperation = operation;
        serviceWithDataOperation.params = params;
        return [serviceWithDataOperation syncService];
    }
    return  nil;
}

//根据创建一个任务节点
+ (__kindof NSOperation *)createOperationWithServiceName:(NSString *)serviceName
{
    id service = [NSClassFromString(serviceName) new];

    if (service) {
        if ([service conformsToProtocol:@protocol(CommonServiceDelegate)]) {
            CommonServiceOperation *operation = [[CommonServiceOperation alloc]initWithService:service];
            return operation;
        } else if ([service conformsToProtocol:@protocol(ServiceWithDataDelegate)]) {
            ServiceWithDataOperation *operation = [[ServiceWithDataOperation alloc]initWithService:service];
            return operation;
        }
    }
    return [[ServiceWithDataOperation alloc]initWithService:[NoService new]];
    
}

@end
