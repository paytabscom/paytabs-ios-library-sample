//
//  BIActivityIndicatorContainerView.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 20/07/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIActivityIndicatorContainerView.h"

@interface BIActivityIndicatorContainerView ()

@property (nonatomic, strong, nonnull, readwrite) UIActivityIndicatorView *activityIndicatorView;

@end


@implementation BIActivityIndicatorContainerView

#pragma mark - Init methods

- (nonnull instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self BI_commonSetup];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self BI_commonSetup];
    }
    return self;
}

#pragma mark - UIView methods

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

#pragma mark - Property methods

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activityIndicatorView startAnimating];
    }
    return _activityIndicatorView;
}

#pragma mark - Private methods

- (void)BI_commonSetup {
    [self addSubview:self.activityIndicatorView];
}

@end
