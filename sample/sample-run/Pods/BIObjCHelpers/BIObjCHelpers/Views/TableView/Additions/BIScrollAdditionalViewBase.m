//
//  BIScrollAdditionalViewBase.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 18/01/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import "BIScrollAdditionalViewBase.h"

@interface BIScrollAdditionalViewBase ()

@property (nonatomic, strong, nullable, readwrite) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong, nonnull, readwrite) NSHashTable<BIScrollAdditionalViewBaseListener> *contentViewListeners;
@property (nonatomic, assign, readwrite) BITableAdditionalTypeView type;

@end


@implementation BIScrollAdditionalViewBase

#pragma mark - Init methods

- (nonnull instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonSetup];
    }
    return self;
}

#pragma mark - Public methods

- (void)commonSetup {
    [self addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)registerAdditionalViewListeners:(nonnull id<BIScrollAdditionalViewBaseListener>)listener {
    [self.contentViewListeners addObject:listener];
}

- (void)unregisterAdditionalViewListeners:(nonnull id<BIScrollAdditionalViewBaseListener>)listener {
    [self.contentViewListeners removeObject:listener];
}

- (void)notifyAdditionalViewListenersOnDidTapEvent {
    if (self.didTapContentViewCallback) {
        self.didTapContentViewCallback();
    }
    
    for (id<BIScrollAdditionalViewBaseListener> listener in [self.contentViewListeners copy]) {
        if ([listener respondsToSelector:@selector(didTapTableAdditionalView:)]) {
            [listener didTapTableAdditionalView:self];
        }
    }
}

- (void)handleAdditionalViewTapGesture:(nonnull UITapGestureRecognizer *)tapGesture {
    [self notifyAdditionalViewListenersOnDidTapEvent];
}

#pragma mark - Property methods

- (UITapGestureRecognizer *)tapGestureRecognizer {
    if (!_tapGestureRecognizer) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleAdditionalViewTapGesture:)];
    }
    return _tapGestureRecognizer;
}

- (NSHashTable<BIScrollAdditionalViewBaseListener> *)contentViewListeners {
    if (!_contentViewListeners) {
        _contentViewListeners = (NSHashTable<BIScrollAdditionalViewBaseListener> *)[NSHashTable weakObjectsHashTable];
    }
    return _contentViewListeners;
}

@end
