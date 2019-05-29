//
//  BICollectionViewActivityIndicatorReusableView.m
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BICollectionViewActivityIndicatorReusableView.h"

@interface BICollectionViewActivityIndicatorReusableView ()

@property (nonatomic, strong, nonnull) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation BICollectionViewActivityIndicatorReusableView

#pragma mark - Init methods

- (nonnull instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.activityIndicatorView];
        self.hidden = NO;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGPoint center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds) / 2.f);
    self.activityIndicatorView.center = center;
}

#pragma mark - UIView methods

- (void)setHidden:(BOOL)hidden {
    hidden? [self.activityIndicatorView stopAnimating] : [self.activityIndicatorView startAnimating];
    [super setHidden:hidden];
}

#pragma mark - Properties

- (UIActivityIndicatorView * __nonnull)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activityIndicatorView startAnimating];
    }
    return _activityIndicatorView;
}

@end
