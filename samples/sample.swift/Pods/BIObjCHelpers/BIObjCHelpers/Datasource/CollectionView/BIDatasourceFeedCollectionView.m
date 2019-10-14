//
//  BIDatasourceFeedCollectionView.m
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIDatasourceFeedCollectionView.h"
#import "BICollectionViewActivityIndicatorReusableView.h"
#import "BIBatchRequest.h"
#import "BIBatchResponse.h"
#import "_BICollectionView+Internal.h"
#import "BIScrollAdditionalViewBase.h"
#import "UIScrollView+BIBatching.h"

@interface BIDatasourceFeedCollectionView ()

@property (nonatomic, strong, nullable, readwrite) BIBatchRequest *currentBatchRequest;

@end

@implementation BIDatasourceFeedCollectionView

@dynamic collectionView;
@synthesize cellClass = _cellClass;

#pragma mark - Factory methods

+ (nonnull instancetype)datasourceWithBICollectionView:(nonnull BICollectionView *)collectionView {
    return [[self alloc] initWithBICollectionView:collectionView];
}

#pragma mark - Init methods

- (nonnull instancetype)initWithBICollectionView:(nonnull BICollectionView *)collectionView {
    return [super initWithCollectionView:collectionView];
}

#pragma mark - BIDatasourceBase methods

- (void)load {
    [super load];
    __weak typeof(self) weakself = self;
    [self.collectionView setInfiniteScrollingCallback:^{
        BIBatchRequest *batch = [weakself createNextBatch];
        batch.insertPosition = BIBatchInsertPositionBottom;
        [weakself fetchBatchRequest:batch];
    }];
    [self.collectionView setPullToRefreshCallback:^{
        BIBatchRequest *batch = [weakself createPullToRefreshBatchRequest];
        batch.insertPosition = BIBatchInsertPositionTop;
        [weakself fetchBatchRequest:batch];
    }];
}

- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [UICollectionViewCell class];
    }
    return _cellClass;
}

#pragma mark - Public methods

- (nonnull BIBatchRequest *)createNextBatch {
    NSUInteger lastSectionIndex = [self.collectionView numberOfSections] - 1;
    NSUInteger batchSize = kDefaultBatchRequestSize;
    __weak typeof(self) weakself = self;
    BIBatchRequestCompletionBlock completionBlock = ^(BIBatchResponse *batchResponse) {
        [weakself handleFetchBatchResponse:batchResponse];
    };
    BIBatchRequest *batch = [[BIBatchRequest alloc] initWithSection:lastSectionIndex
                                                          batchSize:batchSize
                                                    completionBlock:completionBlock];
    return batch;
}

- (nonnull BIMutableBatchRequest *)createBatchRequest {
    __weak typeof(self) weakself = self;
    BIBatchRequestCompletionBlock completionBlock = ^(BIBatchResponse *batchResponse) {
        [weakself handleFetchBatchResponse:batchResponse];
    };
    BIMutableBatchRequest *mutableBatch = [[BIMutableBatchRequest alloc] initWithCompletionBlock:completionBlock];
    mutableBatch.batchSize = kDefaultBatchRequestSize;
    return mutableBatch;
}

- (nonnull BIMutableBatchRequest *)createInitialBatchRequest {
    BIMutableBatchRequest *mutableBatch = [self createBatchRequest];
    mutableBatch.options |= BIBatchRequestOptionInitialRequest;
    mutableBatch.insertPosition = BIBatchInsertPositionBottom;
    return mutableBatch;
}

- (nonnull BIMutableBatchRequest *)createPullToRefreshBatchRequest {
    BIMutableBatchRequest *mutableBatch = [self createBatchRequest];
    mutableBatch.options |= BIBatchRequestOptionPullToRefreshRequest;
    mutableBatch.insertPosition = BIBatchInsertPositionTop;
    return mutableBatch;
}

- (nonnull BIMutableBatchRequest *)createInfiniteScrollingBatchRequest {
    BIMutableBatchRequest *mutableBatch = [self createBatchRequest];
    mutableBatch.options |= BIBatchRequestOptionInfiniteScrollingRequest;
    mutableBatch.insertPosition = BIBatchInsertPositionBottom;
    return mutableBatch;
}

- (nonnull BIMutableBatchRequest *)createErrorNoContentTapToRetryBatchRequest {
    BIMutableBatchRequest *mutableBatch = [self createBatchRequest];
    mutableBatch.options |= BIBatchRequestOptionErrorTapToRetry;
    mutableBatch.insertPosition = BIBatchInsertPositionBottom;
    return mutableBatch;
}

- (nonnull BIMutableBatchRequest *)createReloadRequest {
    BIMutableBatchRequest *mutableBatch = [self createBatchRequest];
    mutableBatch.options |= BIBatchRequestOptionReload;
    mutableBatch.insertPosition = BIBatchInsertPositionBottom;
    return mutableBatch;
}

- (void)fetchBatchRequest:(nonnull BIBatchRequest *)batchRequest {
    NSAssert(!self.currentBatchRequest, @"Another batch request is in progress!");
    self.currentBatchRequest = batchRequest;
    [self updateCollectionViewForFetchBatchRequest:batchRequest];
}

- (void)updateCollectionViewForFetchBatchRequest:(nonnull BIBatchRequest *)batchRequest {
    [self updateCollectionViewAdditionalViewsForFetchBatchRequest:batchRequest];
    BOOL noItemsDisplayed = [self BI_areNoItemsDisplayedForBatchRequest:batchRequest];
    
    if (noItemsDisplayed) {
        self.collectionView.BI_pullToRefreshEnabled = NO;
        if (!self.collectionView.visibleAdditionalView) { // If we don't have an additional view visible
            self.fetchingState = BIDatasourceCollectionViewFetchingStateInfiniteScrolling;
            [self.collectionView BI_startInfiniteScrolling];
        }
    } else if (batchRequest.isInfiniteScrollingRequest) {
        self.collectionView.BI_pullToRefreshEnabled = NO;
        if (!self.collectionView.visibleAdditionalView) { // If we don't have an additional view visible
            self.fetchingState = BIDatasourceCollectionViewFetchingStateInfiniteScrolling;
            self.collectionView.infiniteScrollingState = BIInfiniteScrollingStateLoading;
        }
    } else if (batchRequest.isPullToRefreshRequest) {
        self.collectionView.BI_infiniteScrollingEnabled = NO;
        self.fetchingState = BIDatasourceCollectionViewFetchingStatePullToRefresh;
        [self.collectionView.pullToRefreshControl beginRefreshing];
    }
}

- (void)updateCollectionViewAdditionalViewsForFetchBatchRequest:(nonnull BIBatchRequest *)batchRequest {
    BOOL noItemsDisplayed = [self BI_areNoItemsDisplayedForBatchRequest:batchRequest];
    if (noItemsDisplayed) {
        [self.collectionView addAdditionalLoadingContentView];
    }
}

- (void)handleFetchBatchResponse:(nonnull BIBatchResponse *)batchResponse {
    if (batchResponse.error) {
        [self handleFetchBatchResponseWithFailure:batchResponse];
    } else {
        [self handleFetchBatchResponseWithSuccess:batchResponse];
    }
}

- (void)handleFetchBatchResponseWithFailure:(nonnull BIBatchResponse *)batchResponse {
    [self handleFetchBatchResponseCommon:batchResponse];
}

- (void)handleFetchBatchResponseWithSuccess:(nonnull BIBatchResponse *)batchResponse {
    NSArray *newIndexPaths = batchResponse.indexPaths;
    if (newIndexPaths.count) {
        __weak typeof(self) weakself = self;

        if (self.collectionView.visibleAdditionalView.type == BITableAdditionalTypeLoadingContentView) {
            // Removing the loading view before inserting items
            // Otherwise we get a nasty flicker
            [self.collectionView removeVisibleAdditionalView];
        }

        [self.collectionView performBatchUpdates:^{
            if (batchResponse.addedSectionsIndexSet.count) {
                [weakself.collectionView insertSections:batchResponse.addedSectionsIndexSet];
            }

            [weakself.collectionView insertItemsAtIndexPaths:newIndexPaths];
        } completion:^(BOOL finished) {
            [weakself handleFetchBatchResponseCommon:batchResponse];
        }];
    } else {
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self handleFetchBatchResponseCommon:batchResponse];
    }
}

- (void)handleFetchBatchResponseCommon:(nonnull BIBatchResponse *)batchResponse {
    self.currentBatchRequest = nil;
    self.fetchingState = BIDatasourceCollectionViewFetchingStateNone;
    [self updateCollectionViewForBatchResponse:batchResponse];
}

- (void)updateCollectionViewForBatchResponse:(nonnull BIBatchResponse *)batchResponse {
    [self updateCollectionAdditionalViewsForBatchResponse:batchResponse];
    
    self.currentBatchRequest = nil;

    // Internal flags
    if (batchResponse.batchRequest.isInitialRequest) {
        self.collectionView.BI_pullToRefreshEnabled = NO;
        self.collectionView.BI_infiniteScrollingEnabled = NO;
    }
    if (batchResponse.batchRequest.isInfiniteScrollingRequest) {
        self.collectionView.BI_pullToRefreshEnabled = YES;
    }
    if (batchResponse.batchRequest.isPullToRefreshRequest) {
        [self.collectionView.pullToRefreshControl endRefreshing];
        self.collectionView.BI_infiniteScrollingEnabled = YES;
        self.collectionView.infiniteScrollingState = BIInfiniteScrollingStateStopped;
    }
    
    // Batch response flags
    if (batchResponse.shouldStopInfiniteScrolling || batchResponse.batchRequest.isInfiniteScrollingRequest) {
        self.collectionView.infiniteScrollingState = BIInfiniteScrollingStateStopped;
    }
    if (batchResponse.shouldStopPullToRefresh || batchResponse.batchRequest.isPullToRefreshRequest) {
        [self.collectionView.pullToRefreshControl endRefreshing];
    }
    if (batchResponse.shouldDisablePullToRefresh) {
        self.collectionView.pullToRefreshEnabled = NO;
    }
    if (batchResponse.shouldDisableInfiniteScrolling) {
        self.collectionView.infiniteScrollingEnabled = NO;
    }
    
    if (self.collectionView.infiniteScrollingState != BIInfiniteScrollingStateStopped) {
        self.collectionView.infiniteScrollingState = BIInfiniteScrollingStateStopped;
    }
}

- (void)updateCollectionAdditionalViewsForBatchResponse:(nonnull BIBatchResponse *)batchResponse {
    BOOL noItemsDisplayed = [self BI_areNoItemsDisplayedForBatchRequest:batchResponse.batchRequest];
    if (noItemsDisplayed) {
        BOOL isBatchFailed = batchResponse.error ? YES : NO;
        BOOL isEmptyResponse = batchResponse.indexPaths.count == 0 ? YES : NO;
        if (isBatchFailed) {
            [self.collectionView addAdditionalErrorNoContentView];
        } else if (isEmptyResponse) {
            [self.collectionView addAdditionalNoContentView];
        } else {
            [self.collectionView removeVisibleAdditionalView];
        }
        if (self.collectionView.visibleAdditionalView.type == BITableAdditionalTypeLoadingContentView) {
            [self.collectionView removeVisibleAdditionalView];
        }
    }
}

- (void)tableViewDidTriggerPullToRefreshAction {
    if (self.fetchingState != BIDatasourceCollectionViewFetchingStateNone) {
        return;
    }
    BIMutableBatchRequest *batchRequest = [self createPullToRefreshBatchRequest];
    [self fetchBatchRequest:batchRequest];
}

- (void)tableViewDidTriggerInfiniteScrollingAction {
    if (self.fetchingState != BIDatasourceCollectionViewFetchingStateNone) {
        return;
    }
    BIMutableBatchRequest *batchRequest = [self createInfiniteScrollingBatchRequest];
    [self fetchBatchRequest:batchRequest];
}

- (void)triggerInitialRequest {
    if (self.fetchingState != BIDatasourceCollectionViewFetchingStateNone) {
        return;
    }
    BIMutableBatchRequest *batchRequest = [self createInitialBatchRequest];
    [self fetchBatchRequest:batchRequest];
}

- (void)triggerErrorNoContentTapToRetryRequest {
    if (self.fetchingState != BIDatasourceCollectionViewFetchingStateNone) {
        return;
    }
    BIMutableBatchRequest *batchRequest = [self createErrorNoContentTapToRetryBatchRequest];
    [self fetchBatchRequest:batchRequest];
}

- (void)triggerReloadRequest {
    if (self.fetchingState != BIDatasourceCollectionViewFetchingStateNone) {
        return;
    }
    BIMutableBatchRequest *batchRequest = [self createReloadRequest];
    [self fetchBatchRequest:batchRequest];
}

#pragma mark - Property methods

- (void)setFetchingState:(BIDatasourceCollectionViewFetchingState)fetchingState {
    NSAssert(_fetchingState ==  BIDatasourceCollectionViewFetchingStateNone || fetchingState ==  BIDatasourceCollectionViewFetchingStateNone, @"Trying to change the fetching state while another operation is in progress");
    _fetchingState = fetchingState;
}

#pragma mark - Private methods

- (BOOL)BI_areNoItemsDisplayedForBatchRequest:(nonnull BIBatchRequest *)batchRequest {
    BOOL noItemsDisplayed = batchRequest.isInitialRequest ||
    batchRequest.isNoContentRequest ||
    batchRequest.isErrorNoContentTapToRetryRequest;
    return noItemsDisplayed;
}

@end
