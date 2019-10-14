//
//  BIDatasourceFeedCollectionView.h
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIDatasourceCollectionView.h"
#import "BICollectionView.h"

@class BIBatchRequest;
@class BIBatchResponse;
@class BIMutableBatchRequest;

typedef NS_ENUM(NSUInteger, BIDatasourceCollectionViewFetchingState) {
    BIDatasourceCollectionViewFetchingStateNone = 0,
    BIDatasourceCollectionViewFetchingStatePullToRefresh,
    BIDatasourceCollectionViewFetchingStateInfiniteScrolling
};

@interface BIDatasourceFeedCollectionView : BIDatasourceCollectionView

+ (nonnull instancetype)datasourceWithBICollectionView:(nonnull BICollectionView *)collectionView;
- (nonnull instancetype)initWithBICollectionView:(nonnull BICollectionView *)collectionView NS_DESIGNATED_INITIALIZER;
+ (nonnull instancetype)datasourceWithCollectionView:(nonnull UICollectionView *)collectionView NS_UNAVAILABLE;
- (nonnull instancetype)initWithCollectionView:(nonnull UICollectionView *)collectionView NS_UNAVAILABLE;

/*!
 * @brief Current batch that is being loaded.
 */
@property (nonatomic, strong, nullable, readonly) BIBatchRequest *currentBatchRequest;

/*!
 * @brief The collection view for whom is handling the data.
 */
@property (nonatomic, strong, nonnull, readonly) BICollectionView *collectionView;

/*!
 * @brief Current fetching status.
 */
@property (nonatomic, assign, readonly) BIDatasourceCollectionViewFetchingState fetchingState;

/*!
 * Create a new batch for fetching.
 * @return New batch.
 */
- (nonnull BIBatchRequest *)createNextBatch;

/*!
 * Create a mutable batch request.
 * @return New batch.
 */
- (nonnull BIMutableBatchRequest *)createBatchRequest;

/*!
 * Create a mutable batch request when the collection view has no content in it.
 * @return New batch.
 */
- (nonnull BIMutableBatchRequest *)createInitialBatchRequest;

/*!
 * Create a mutable batch request driven by a pull to refresh gesture.
 * @return New batch.
 */
- (nonnull BIMutableBatchRequest *)createPullToRefreshBatchRequest;

/*!
 * Create a mutable batch request driven by a scroll down in the collection view.
 * @return New batch.
 */
- (nonnull BIMutableBatchRequest *)createInfiniteScrollingBatchRequest;

/*!
 * Create a mutable batch request driven by a tap to retry on a error no content case.
 * @return New batch.
 */
- (nonnull BIMutableBatchRequest *)createErrorNoContentTapToRetryBatchRequest;

/*!
 * Create a mutable batch request for reloading the content.
 * @return New batch.
 */
- (nonnull BIMutableBatchRequest *)createReloadRequest;

/*!
 * Fetches a given batch.
 * @param batch Given batch.
 */
- (void)fetchBatchRequest:(nonnull BIBatchRequest *)batchRequest;

/*!
 * @brief Update collection view before fetching a batch request.
 * @param batchRequest The batch request that triggered the update.
 */
- (void)updateCollectionViewForFetchBatchRequest:(nonnull BIBatchRequest *)batchRequest;

/*!
 * @brief Update collection additional views before fetching a batch request.
 * @param batchRequest The batch request that triggered the update.
 */
- (void)updateCollectionViewAdditionalViewsForFetchBatchRequest:(nonnull BIBatchRequest *)batchRequest;

/*!
 * @brief Handle a batch response.
 * @param batchResponse Batch response to handle.
 */
- (void)handleFetchBatchResponse:(nonnull BIBatchResponse *)batchResponse;

/*!
 * @brief Handle a batch response that failed.
 * @param batchResponse Batch response to handle.
 */
- (void)handleFetchBatchResponseWithFailure:(nonnull BIBatchResponse *)batchResponse;

/*!
 * @brief Handle a batch response that succeeded.
 * @param batchResponse Batch response to handle.
 */
- (void)handleFetchBatchResponseWithSuccess:(nonnull BIBatchResponse *)batchResponse;

/*!
 * @brief Handle a batch response .
 * @param batchResponse Batch response to handle.
 */
- (void)handleFetchBatchResponseCommon:(nonnull BIBatchResponse *)batchResponse;

/*!
 * @brief Update collection view for a given batch response.
 * @param batchResponse Batch response to handle.
 */
- (void)updateCollectionViewForBatchResponse:(nonnull BIBatchResponse *)batchResponse;

/*!
 * Called by collection view after a pull to refresh action.
 * Call this method for a simulated pull to refresh action.
 */
- (void)tableViewDidTriggerPullToRefreshAction;

/*!
 * Called by collection view for fetching the next batch of data.
 * Call this method for a simulated action.
 */
- (void)tableViewDidTriggerInfiniteScrollingAction;

/*!
 * Manually trigger the first batch request for data.
 */
- (void)triggerInitialRequest;

/*!
 * Manually trigger the tap to retry error no content case.
 */
- (void)triggerErrorNoContentTapToRetryRequest;

/*!
 * Manually trigger a reload request.
 */
- (void)triggerReloadRequest;

@end
