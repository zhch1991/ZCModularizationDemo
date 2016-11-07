//
//  ServiceManager.h
//  NavigationManager-OC
//
//  Created by zhangchu on 16/8/5.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonServiceOperation.h"
#import "ServiceWithDataOperation.h"
@interface ServiceManager : NSObject

//无参带回调加载方法
+(void)loadService:(NSString *)serviceName withCallBack:(void(^)())block;
//有参带回调加载方法
+(void)loadService:(NSString *)serviceName withParams:(NSDictionary *)params withCallBack:(void(^)(NSDictionary *result))block synchronous:(BOOL)isSynchronous;
//同步方法，暂时没用到
+(NSDictionary *)syncServiceData:(NSString *)serviceName withParams:(NSDictionary *)params;
@end
