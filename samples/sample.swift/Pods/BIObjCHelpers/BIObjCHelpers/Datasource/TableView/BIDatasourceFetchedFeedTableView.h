//
//  BIDatasourceFetchedFeedTableView.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 6/10/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import "BIDatasourceFetchedTableView.h"
#import "BITableView.h"
#import "BITableViewUtils.h"

@class BIBatchRequest;
@class BIMutableBatchRequest;
@class BIBatchResponse;

@interface BIDatasourceFetchedFeedTableView : BIDatasourceFetchedTableView

/*!
 * @brief Factory method for creating a feed table view datasource.
 * @param tableView The table view.
 */
+ (nonnull instancetype)datasourceWithBITableView:(nonnull BITableView *)tableView;

/*!
 * @brief Factory method for creating a feed table view datasource.
 * @param tableView The table view.
 */
- (nonnull instancetype)initWithBITableView:(nonnull BITableView *)tableView NS_DESIGNATED_INITIALIZER;

+ (nonnull instancetype)datasourceWithTableView:(nonnull UITableView *)tableView NS_UNAVAILABLE;
- (nonnull instancetype)initWithTableView:(nonnull UITableView *)tableView NS_UNAVAILABLE;

/*!
 * @brief Current batch that is being loaded.
 */
@property (nonatomic, strong, nullable, readonly) BIBatchRequest *currentBatchRequest;

/*!
 * @brief The tableview for whom is handling the data.
 */
@property (nonatomic, strong, readonly, nonnull) BITableView *tableView;

/*!
 * @brief Current fetching status.
 */
@property (nonatomic, assign, readonly) BIDatasourceTableViewFetchingState fetchingState;

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
 * Create a mutable batch request when the table view has no content in it.
 * @return New batch.
 */
- (nonnull BIMutableBatchRequest *)createInitialBatchRequest;

/*!
 * Create a mutable batch request driven by a pull to refresh gesture.
 * @return New batch.
 */
- (nonnull BIMutableBatchRequest *)createPullToRefreshBatchRequest;

/*!
 * Create a mutable batch request driven by a scroll down in the table view.
 * @return New batch.
 */
- (nonnull BIMutableBatchRequest *)createInfiniteScrollingBatchRequest;

/*!
 * Create a mutable batch request driven by a tap to retry on a error no content case.
 * @return New batch.
 */
- (nonnull BIMutableBatchRequest *)createErrorNoContentTapToRetryBatchRequest;

/*!
 * Create a mutable batch request driven by a tap to retry on a no content case.
 * @return New batch.
 */
- (nonnull BIMutableBatchRequest *)createNoContentTapToRetryBatchRequest;

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
 * @brief Update table view before fetching a batch request.
 * @param batchRequest The batch request that triggered the update.
 */
- (void)updateTableViewForFetchBatchRequest:(nonnull BIBatchRequest *)batchRequest;

/*!
 * @brief Update table additional views before fetching a batch request.
 * @param batchRequest The batch request that triggered the update.
 */
- (void)updateTableAdditionalViewsForFetchBatchRequest:(nonnull BIBatchRequest *)batchRequest;

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
 * @brief Update table view for a given batch response.
 * @param batchResponse Batch response to handle.
 */
- (void)updateTableViewForBatchResponse:(nonnull BIBatchResponse *)batchResponse;

/*!
 * Called by table view after a pull to refresh action.
 * Call this method for a simulated pull to refresh action.
 */
- (void)tableViewDidTriggerPullToRefreshAction;

/*!
 * Called by table view for fetching the next batch of data.
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
 * Manually trigger the tap on no content case.
 */
- (void)triggerNoContentTapToRetryRequest;

/*!
 * Manually trigger a reload request.
 */
- (void)triggerReloadRequest;

@end
