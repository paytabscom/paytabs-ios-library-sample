//
//  _BIScrollViewProxy.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 24/07/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface _BIScrollViewProxy : NSProxy

- (nonnull instancetype)initWithTarget:(nullable id<NSObject>)target interceptor:(nonnull UIScrollView *)interceptor;

@property (nonatomic, weak, nullable, readonly) id target;
@property (nonatomic, weak, nullable, readonly) UIScrollView *interceptor;

@end
