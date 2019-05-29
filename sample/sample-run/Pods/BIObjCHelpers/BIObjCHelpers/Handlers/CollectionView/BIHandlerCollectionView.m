//
//  BIHandlerCollectionView.m
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIHandlerCollectionView.h"
#import "_BICollectionView+Internal.h"
#import "BIDatasourceFeedCollectionView.h"

@interface BIHandlerCollectionView ()

@property (nonatomic, readwrite, strong, nonnull) UICollectionView *collectionView;

@end

@implementation BIHandlerCollectionView

#pragma mark - Init Methods

+ (nonnull instancetype)handlerWithCollectionView:(nonnull UICollectionView *)collectionView {
    return [[[self class] alloc] initWithCollectionView:collectionView];
}

- (nonnull instancetype)initWithCollectionView:(nonnull UICollectionView *)collectionView {
    NSParameterAssert(collectionView);
    self = [super init];
    if (self) {
        self.collectionView = collectionView;
        if ([self.collectionView isKindOfClass:[BICollectionView class]]) {
            BICollectionView *biCollectionView = (BICollectionView *)self.collectionView;
            biCollectionView.handler = self;
        }
        self.collectionView.delegate = self;
    }
    return self;
}

#pragma mark - UICollectionViewDelegate Methods


#pragma mark - UICollectionViewDelegateFlowLayout Methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if ([collectionView isKindOfClass:[BICollectionView class]]) {
        BICollectionView *biCollectionView = (BICollectionView *)collectionView;
        if (biCollectionView.infiniteScrollingState == BIInfiniteScrollingStateStopped) {
            return CGSizeMake(0.01f, 0.01f);
        }
        CGSize size = CGSizeMake(CGRectGetWidth(collectionView.frame), 44.f);
        return size;
    }
    return CGSizeZero;
}

@end
