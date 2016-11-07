//
//  ServiceWithDataOperation.m
//  NavigationManager-OC
//
//  Created by zhangchu on 16/8/8.
//  Copyright © 2016年 CZ. All rights reserved.
//

#import "ServiceWithDataOperation.h"
@interface ServiceWithDataOperation ()
{
    BOOL                            _isExecuting;
    BOOL                            _isFinished;
    id <ServiceWithDataDelegate>    _service;
}
@end
@implementation ServiceWithDataOperation
- (void)main
{
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];

    [self handleService];
    
}

- (BOOL)isConcurrent
{
    if (self.synchronous) {
        return NO;
    } else {
        return YES;
    }
}

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

- (void)cancel
{
    [super cancel];

    if (!self.synchronous && _service) {
        if ([_service respondsToSelector:@selector(cancelService)]) {
            [_service cancelService];
        }
    }

    [self finish];
}

- (instancetype)initWithService:(id <ServiceWithDataDelegate>)service
{
    self = [super init];

    if (self) {
        _service = service;
    }

    return self;
}

- (void)handleService
{
    if (self.isCancelled) {
        [self cancel];
    }

    if (!_service) {
        [self finish];
        return;
    }

    if ([_service respondsToSelector:@selector(callService:)]) {
        id result=[_service callService:self.params];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.completeBlock) {
                self.completeBlock(result);
            }
        });
        
    }
}

- (NSDictionary *)syncService
{
    if (self.isCancelled) {
        [self cancel];
    }

    if (!_service) {
        [self finish];
        return nil;
    }

    if ([_service respondsToSelector:@selector(callService:)]) {
        return [_service callService:self.params];
    } else {
        return nil;
    }
}

@end