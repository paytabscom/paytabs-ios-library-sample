//
//  BIDatasourceFeedTableView.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceFeedTableView.h"
#import "BIBatchRequest.h"
#import "BIBatchResponse.h"
#import "BITableViewCell.h"
#import "_BITableView+Internal.h"
#import "BIScrollAdditionalViewBase.h"
#import "UIScrollView+BIBatching.h"

@interface BIDatasourceFeedTableView ()

@property (nonatomic, strong, nullable, readwrite) BIBatchRequest *currentBatchRequest;

@property (nonatomic, assign, readwrite) BIDatasourceTableViewFetchingState fetchingState;

@end


@implementation BIDatasourceFeedTableView

@dynamic tableView;
@synthesize cellClass = _cellClass;

#pragma mark - Factory methods

+ (nonnull instancetype)datasourceWithBITableView:(nonnull BITableView *)tableView {
    return [[self alloc] initWithBITableView:tableView];
}

#pragma mark - Init methods

- (nonnull instancetype)initWithBITableView:(nonnull BITableView *)tableView  {
    self = [super initWithTableView:tableView];
    if (self) {
        self.cellClass = [BITableViewCell class];
        _fetchingState = BIDatasourceTableViewFetchingStateNone;
    }
    return self;
}

#pragma mark - BIDatasourceBase methods

- (void)load {
    [super load];
    __weak typeof(self) weakself = self;
    [self.tableView setInfiniteScrollingCallback:^{
        [weakself tableViewDidTriggerInfiniteScrollingAction];
    }];
    [self.tableView setPullToRefreshCallback:^{
        [weakself tableViewDidTriggerPullToRefreshAction];
    }];
}

#pragma mark - Public methods

- (nonnull BIBatchRequest *)createNextBatch {
    NSUInteger lastSectionIndex = [self.tableView numberOfSections] - 1;
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

- (nonnull BIMutableBatchRequest *)createNoContentTapToRetryBatchRequest {
    BIMutableBatchRequest *mutableBatch = [self createBatchRequest];
    mutableBatch.options |= BIBatchRequestOptionNoContent;
    mutableBatch.options |= BIBatchRequestOptionReload;
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
    [self updateTableViewForFetchBatchRequest:batchRequest];
}

- (void)updateTableViewForFetchBatchRequest:(nonnull BIBatchRequest *)batchRequest {
    [self updateTableAdditionalViewsForFetchBatchRequest:batchRequest];
    BOOL noItemsDisplayed = [self BI_areNoItemsDisplayedForBatchRequest:batchRequest];
    
    if (noItemsDisplayed) {
        self.tableView.BI_pullToRefreshEnabled = NO;
        if (!self.tableView.visibleAdditionalView) { // If we don't have an additional view visible
            self.fetchingState = BIDatasourceTableViewFetchingStateInfiniteScrolling;
            [self.tableView BI_startInfiniteScrolling];
        }
    } else if (batchRequest.isInfiniteScrollingRequest) {
        self.tableView.BI_pullToRefreshEnabled = NO;
        if (!self.tableView.visibleAdditionalView) { // If we don't have an additional view visible
            self.fetchingState = BIDatasourceTableViewFetchingStateInfiniteScrolling;
            self.tableView.infiniteScrollingState = BIInfiniteScrollingStateLoading;
        }
    } else if (batchRequest.isPullToRefreshRequest) {
        self.tableView.BI_infiniteScrollingEnabled = NO;
        self.fetchingState = BIDatasourceTableViewFetchingStatePullToRefresh;
        [self.tableView.pullToRefreshControl beginRefreshing];
    }
}

- (void)updateTableAdditionalViewsForFetchBatchRequest:(nonnull BIBatchRequest *)batchRequest {
    BOOL noItemsDisplayed = [self BI_areNoItemsDisplayedForBatchRequest:batchRequest];
    if (noItemsDisplayed) {
        [self.tableView addAdditionalLoadingContentView];
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
    if (batchResponse.indexPaths.count) {
        [self.tableView beginUpdates];
        if (batchResponse.addedSectionsIndexSet.count) {
            [self.tableView insertSections:batchResponse.addedSectionsIndexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        [self.tableView insertRowsAtIndexPaths:batchResponse.indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }
    [self handleFetchBatchResponseCommon:batchResponse];
}

- (void)handleFetchBatchResponseCommon:(nonnull BIBatchResponse *)batchResponse {
    self.currentBatchRequest = nil;
    self.fetchingState = BIDatasourceTableViewFetchingStateNone;
    [self updateTableViewForBatchResponse:batchResponse];
}

- (void)updateTableViewForBatchResponse:(nonnull BIBatchResponse *)batchResponse {
    [self updateTableAdditionalViewsForBatchResponse:batchResponse];
    
    // Internal flags
    if (batchResponse.batchRequest.isInitialRequest) {
        self.tableView.BI_pullToRefreshEnabled = YES;
        self.tableView.BI_infiniteScrollingEnabled = NO;
    }
    if (batchResponse.batchRequest.isInfiniteScrollingRequest) {
        self.tableView.BI_pullToRefreshEnabled = YES;
    }
    if (batchResponse.batchRequest.isPullToRefreshRequest) {
        self.tableView.BI_infiniteScrollingEnabled = YES;
        self.tableView.infiniteScrollingState = BIInfiniteScrollingStateStopped;
    }
    
    // Batch response flags
    if (batchResponse.shouldStopInfiniteScrolling || batchResponse.batchRequest.isInfiniteScrollingRequest) {
        self.tableView.infiniteScrollingState = BIInfiniteScrollingStateStopped;
    }
    if (batchResponse.shouldStopPullToRefresh || batchResponse.batchRequest.isPullToRefreshRequest) {
        [self.tableView.pullToRefreshControl endRefreshing];
    }
    if (batchResponse.shouldDisablePullToRefresh) {
        self.tableView.pullToRefreshEnabled = NO;
    }
    if (batchResponse.shouldDisableInfiniteScrolling) {
        self.tableView.infiniteScrollingEnabled = NO;
    }
}

- (void)updateTableAdditionalViewsForBatchResponse:(nonnull BIBatchResponse *)batchResponse {
    BOOL noItemsDisplayed = [self BI_areNoItemsDisplayedForBatchRequest:batchResponse.batchRequest];
    if (noItemsDisplayed) {
        // BI_pullToRefreshEnabled is set to NO for some batch requests types(when noItemsDisplayed is YES).
        // Not resetting it here will disable pull to refresh for all types of requests(cases when noItemsDisplayed is NO).
        self.tableView.BI_pullToRefreshEnabled = YES;

        BOOL isBatchFailed = batchResponse.error ? YES : NO;
        BOOL isEmptyResponse = batchResponse.indexPaths.count == 0 ? YES : NO;
        if (isBatchFailed) {
            [self.tableView addAdditionalErrorNoContentView];
        } else if (isEmptyResponse) {
            [self.tableView addAdditionalNoContentView];
        } else {
            [self.tableView removeVisibleAdditionalView];
        }
        if (self.tableView.visibleAdditionalView.type == BITableAdditionalTypeLoadingContentView) {
            [self.tableView removeVisibleAdditionalView];
        }
    }
}

- (void)tableViewDidTriggerPullToRefreshAction {
    if (self.fetchingState != BIDatasourceTableViewFetchingStateNone) {
        return;
    }
    BIMutableBatchRequest *batchRequest = [self createPullToRefreshBatchRequest];
    [self fetchBatchRequest:batchRequest];
}

- (void)tableViewDidTriggerInfiniteScrollingAction {
    if (self.fetchingState != BIDatasourceTableViewFetchingStateNone) {
        return;
    }
    BIMutableBatchRequest *batchRequest = [self createInfiniteScrollingBatchRequest];
    [self fetchBatchRequest:batchRequest];
}

- (void)triggerInitialRequest {
    if (self.fetchingState != BIDatasourceTableViewFetchingStateNone) {
        return;
    }
    BIMutableBatchRequest *batchRequest = [self createInitialBatchRequest];
    [self fetchBatchRequest:batchRequest];
}

- (void)triggerErrorNoContentTapToRetryRequest {
    if (self.fetchingState != BIDatasourceTableViewFetchingStateNone) {
        return;
    }
    BIMutableBatchRequest *batchRequest = [self createErrorNoContentTapToRetryBatchRequest];
    [self fetchBatchRequest:batchRequest];
}

- (void)triggerNoContentTapToRetryRequest {
    if (self.fetchingState != BIDatasourceTableViewFetchingStateNone) {
        return;
    }
    BIMutableBatchRequest *batchRequest = [self createNoContentTapToRetryBatchRequest];
    [self fetchBatchRequest:batchRequest];
}

- (void)triggerReloadRequest {
    if (self.fetchingState != BIDatasourceTableViewFetchingStateNone) {
        return;
    }
    BIMutableBatchRequest *batchRequest = [self createReloadRequest];
    [self fetchBatchRequest:batchRequest];
}

#pragma mark - Property methods

- (void)setFetchingState:(BIDatasourceTableViewFetchingState)fetchingState {
    NSAssert(_fetchingState ==  BIDatasourceTableViewFetchingStateNone || fetchingState ==  BIDatasourceTableViewFetchingStateNone, @"Trying to change the fetching state while another operation is in progress");
    _fetchingState = fetchingState;
}

#pragma mark - Private methods

- (BOOL)BI_areNoItemsDisplayedForBatchRequest:(nonnull BIBatchRequest *)batchRequest {
    BOOL noItemsDisplayed = batchRequest.isInitialRequest ||
                            batchRequest.isNoContentRequest ||
                            batchRequest.isErrorNoContentTapToRetryRequest ||
                            batchRequest.isReloadRequest;
    return noItemsDisplayed;
}

@end
