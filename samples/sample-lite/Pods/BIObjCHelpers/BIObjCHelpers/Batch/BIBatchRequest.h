//
//  BIBatchRequest.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 08/09/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT const NSInteger kDefaultBatchRequestSize;

@class BIBatchResponse;
@class BIMutableBatchRequest;

typedef void(^BIBatchRequestCompletionBlock)(BIBatchResponse * __nonnull response);

/*!
 @brief Helper values for batch insert position.
 */
typedef NS_ENUM(NSUInteger, BIBatchInsertPosition) {
    /*!
     * @brief insert new elements at the beggining.
     */
    BIBatchInsertPositionTop = 0,
    /*!
     * @brief insert new elements at the end.
     */
    BIBatchInsertPositionBottom = UINT_MAX
};

/*!
 * @brief Extra options for a batch request.
 */
typedef NS_OPTIONS(NSUInteger, BIBatchRequestOptions) {
    /*!
     * @brief No option.
     */
    BIBatchRequestOptionNone                      = 1 << 0,
    /*!
     * @brief The first request on the target.
     */
    BIBatchRequestOptionInitialRequest            = 1 << 1,
    /*!
     * @brief Request triggered by a pull to refresh.
     */
    BIBatchRequestOptionPullToRefreshRequest      = 1 << 2,
    /*!
     * @brief Request triggered by a scroll.
     */
    BIBatchRequestOptionInfiniteScrollingRequest  = 1 << 3,
    /*!
     * @brief Request triggered after an error occured and there is no content.
     */
    BIBatchRequestOptionErrorTapToRetry           = 1 << 4,
    /*!
     * @brief Request triggered from a no content state.
     */
    BIBatchRequestOptionNoContent                 = 1 << 5,
    /*!
     * @brief Request triggered for a reload content case.
     */
    BIBatchRequestOptionReload                    = 1 << 6
};

/*!
 * @brief Defines a set of data request values.
 * Mostly used in table and collection views for inserting sets of data.
 */
@interface BIBatchRequest : NSObject <NSCopying, NSMutableCopying>

- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

/*!
 * @brief Designated initializer for a table view batch.
 * @param sectionIndex The index of the section where to fetch data.
 * @param batchSize The size of the batch to fetch.
 * @param completionBlock Code block to be called when fetching is done or in case of error.
 */
- (nonnull instancetype)initWithSection:(NSUInteger)sectionIndex
                              batchSize:(NSUInteger)batchSize
                        completionBlock:(nullable BIBatchRequestCompletionBlock)completionBlock NS_DESIGNATED_INITIALIZER;

/*!
 * @brief Convenience kDefaultTableViewBatchSize for a table view batch.
 * @discussion Fetches kCardDefaultBatchSize elements in section index 0.
 * @param completionBlock Code block to be called when fetching is done or in case of error.
 */
- (nonnull instancetype)initWithCompletionBlock:(nullable BIBatchRequestCompletionBlock)completionBlock;

/*!
 * @brief Size of the batch that is fetching.
 */
@property (nonatomic, assign, readonly) NSUInteger batchSize;

/*!
 * @brief Section index for which data is fetching.
 */
@property (nonatomic, assign, readonly) NSUInteger sectionIndex;

/*!
 * @brief Code block to be called when fetching is done or in case of error.
 */
@property (nonatomic, copy, nullable, readonly) BIBatchRequestCompletionBlock completionBlock;

/*!
 * @brief Specify an index from where to start inserting the new elements that will be fetched.
 * Defaults to BIBatchInsertPositionBottom;
 */
@property (nonatomic, assign, readwrite) NSUInteger insertPosition;

/*!
 * @brief Additional flags that can be set for a batch request.
 */
@property (nonatomic, assign, readonly) BIBatchRequestOptions options;

/*!
 * @brief True if options contain BIBatchRequestOptionInitialRequest flag.
 */
@property (nonatomic, assign, readonly) BOOL isInitialRequest;

/*!
 * @brief True if options contain BIBatchRequestOptionPullToRefreshRequest flag.
 */
@property (nonatomic, assign, readonly) BOOL isPullToRefreshRequest;

/*!
 * @brief True if options contain BIBatchRequestOptionInfiniteScrollingRequest flag.
 */
@property (nonatomic, assign, readonly) BOOL isInfiniteScrollingRequest;

/*!
 * @brief True if options contain BIBatchRequestOptionErrorTapToRetry flag.
 */
@property (nonatomic, assign, readonly) BOOL isErrorNoContentTapToRetryRequest;

/*!
 * @brief True if options contain BIBatchRequestOptionNoContent flag.
 */
@property (nonatomic, assign, readonly) BOOL isNoContentRequest;

/*!
 * @brief True if options contain BIBatchRequestOptionReload flag.
 */
@property (nonatomic, assign, readonly) BOOL isReloadRequest;

/*!
 * @brief Overriden method for returning the exact class type for a copied object.
 */
- (nonnull BIBatchRequest *)copy;

/*!
 * @brief Overriden method for returning the exact class type for a mutable copy.
 */
- (nonnull BIMutableBatchRequest *)mutableCopy;

/*!
 * @brief Compare two requests.
 * @param anotherRequest To whom to compare.
 * @return YES if objects are equal, NO otherwise.
 */
- (BOOL)isEqualToRequest:(nonnull BIBatchRequest *)anotherRequest;

@end


/*!
 * Mutable version of a batch request.
 */
@interface BIMutableBatchRequest : BIBatchRequest

/*!
 * @brief Size of the batch that is fetching.
 */
@property (nonatomic, assign, readwrite) NSUInteger batchSize;

/*!
 * @brief Section index for which data is fetching.
 */
@property (nonatomic, assign, readwrite) NSUInteger sectionIndex;

/*!
 * @brief Code block to be called when fetching is done or in case of error.
 */
@property (nonatomic, copy, nullable, readwrite) BIBatchRequestCompletionBlock completionBlock;

/*!
 * @brief Additional flags that can be set for a batch request.
 */
@property (nonatomic, assign, readwrite) BIBatchRequestOptions options;

@end
