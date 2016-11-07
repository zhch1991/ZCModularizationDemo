//
//  ServiceWithDataDelegate.h
//  NavigationManager-OC
//
//  Created by zhangchu on 16/8/8.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServiceWithDataDelegate <NSObject>
@required
-(NSDictionary *)callService:(NSDictionary *)dic;
@optional
-(void)cancelService;
@end
