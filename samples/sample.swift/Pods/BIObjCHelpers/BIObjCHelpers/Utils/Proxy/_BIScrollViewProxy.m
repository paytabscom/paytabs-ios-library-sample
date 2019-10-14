//
//  _BIScrollViewProxy.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 24/07/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "_BIScrollViewProxy.h"

@interface _BIScrollViewProxy ()

@property (nonatomic, weak, nullable, readwrite) id target;
@property (nonatomic, weak, nullable, readwrite) UIScrollView *interceptor;

@end


@implementation _BIScrollViewProxy

- (nonnull instancetype)initWithTarget:(nullable id)target interceptor:(nonnull UIScrollView *)interceptor {
    self.target = target;
    self.interceptor = interceptor;

    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    NSParameterAssert(self.interceptor);

    BOOL responds = [self.interceptor respondsToSelector:aSelector] || [self.target respondsToSelector:aSelector];
    return responds;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSParameterAssert(self.interceptor);
  
    if ([self.interceptor respondsToSelector:aSelector]) {
        return self.interceptor;
    }

    return [self.target respondsToSelector:aSelector] ? self.target : nil;
}

@end
