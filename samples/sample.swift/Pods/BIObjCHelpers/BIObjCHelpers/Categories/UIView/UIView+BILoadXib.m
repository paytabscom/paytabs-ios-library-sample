//
//  UIView+BILoadXib.m
//  Pods
//
//  Created by Mihai Chifor on 7/16/15.
//
//  Copyright © 2015 iGama Apps. All rights reserved.

#import "UIView+BILoadXib.h"

@implementation UIView (BILoadXib)

+ (nonnull instancetype)viewFromXib {
    NSString *className = NSStringFromClass(self);
    UIView *view = [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil][0];

    NSAssert([view isKindOfClass:self], @"View class should match");
    
    return view;
}

@end
