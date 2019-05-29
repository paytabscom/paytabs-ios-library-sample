//
//  BITableViewCell.m
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 7/17/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BITableViewCell.h"

const CGFloat kBIDefaultTableViewCellSeparatorViewHeight = 1.f;

@interface BITableViewCell ()

@property (nonatomic, strong, nonnull, readwrite) UIView *separatorView;

@end


@implementation BITableViewCell

#pragma mark - Init methods

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    
    if (self.separatorViewVisible) {
        self.separatorView.frame = [self BI_separatorViewFrame];
    }
}

#pragma mark - Property methods

- (void)setSeparatorViewVisible:(BOOL)separatorViewVisible {
    _separatorViewVisible = separatorViewVisible;
    if (_separatorViewVisible) {
        [self BI_addSeparatorView];
    } else {
        [_separatorView removeFromSuperview];
        _separatorView = nil;
    }
}

- (void)setSeparatorViewHeight:(CGFloat)separatorViewHeight {
    _separatorViewHeight = separatorViewHeight;
    if (self.separatorViewVisible) {
        [self setNeedsLayout];
    }
}

#pragma mark - Private methods

- (void)BI_commonSetup {
    self.separatorViewHeight = kBIDefaultTableViewCellSeparatorViewHeight;
    self.separatorViewVisible = NO;
}

- (void)BI_addSeparatorView {
    self.separatorView = [[UIView alloc] initWithFrame:[self BI_separatorViewFrame]];
    self.separatorView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.separatorView];
}

- (CGRect)BI_separatorViewFrame {

    return (CGRect){.0f,
        CGRectGetMaxY(self.contentView.bounds) - self.separatorViewHeight,
        CGRectGetWidth(self.contentView.bounds),
        self.separatorViewHeight};
}

@end
