//
//  BIBatchResponse.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 08/09/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 * @brief Extra options for a batch request.
 */
typedef NS_OPTIONS(NSUInteger, BIBatchResponseOptions) {
    /*!
     * @brief No option.
     */
    BIBatchResponseOptionNone                  = 1 << 0,
    /*!
     * @brief Specifies that pull to refresh should be stopped.
     */
    BIBatchResponseOptionStopPullToRefresh     = 1 << 1,
    /*!
     * @brief Specifies that inifinite scrolling should be stopped.
     */
    BIBatchResponseOptionStopInfiniteScrolling = 1 << 2,
    /*!
     * @brief Specifies that pull to refresh should be disabled.
     */
    BIBatchResponseOptionDisablePullToRefresh     = 1 << 3,
    /*!
     * @brief Specifies that inifinite scrolling should be stopped.
     */
    BIBatchResponseOptionDisableInfiniteScrolling = 1 << 4,
    /*!
     * @brief Specifies that table view should reload its content.
     */
    BIBatchResponseOptionReload = 1 << 5,
    /*!
     * @brief Specifies that table view should display no content.
     */
    BIBatchResponseOptionShowNoContent = 1 << 6
};

@class BIBatchRequest;

@interface BIBatchResponse : NSObject

@property (nonatomic, strong, nullable, readonly) NSError *error;
@property (nonatomic, copy,   nullable, readonly) NSArray *indexPaths;
@property (nonatomic, copy,   nullable, readonly) NSIndexSet *addedSectionsIndexSet;
@property (nonatomic, strong, nullable, readonly) BIBatchRequest *batchRequest;
/*!
 * Extra response values.
 */
@property (nonatomic, assign, readonly) BIBatchResponseOptions options;

/*!
 * @brief YES if options contain BIBatchResponseOptionStopPullToRefresh flag.
 */
@property (nonatomic, assign, readonly) BOOL shouldStopPullToRefresh;

/*!
 * @brief YES if options contain BIBatchResponseOptionStopInfiniteScrolling flag.
 */
@property (nonatomic, assign, readonly) BOOL shouldStopInfiniteScrolling;

/*!
 * @brief YES if options contain BIBatchResponseOptionDisablePullToRefresh flag.
 */
@property (nonatomic, assign, readonly) BOOL shouldDisablePullToRefresh;

/*!
 * @brief YES if options contain BIBatchResponseOptionDisableInfiniteScrolling flag.
 */
@property (nonatomic, assign, readonly) BOOL shouldDisableInfiniteScrolling;

@end

/*!
 * @brief Mutable version of a BIBatchRequest.
 */
@interface BIMutableBatchResponse : BIBatchResponse

/*!
 * @brief Factory method for creating a batch request.
 * @param batchRequest Batch request for which to create the response.
 */
+ (nonnull instancetype)batchResponseForRequest:(nonnull BIBatchRequest *)batchRequest;

/*!
 * @brief Designated initializer for creating a batch request.
 * @param batchRequest Batch request for which to create the response.
 */
- (nonnull instancetype)initWithBatchRequest:(nonnull BIBatchRequest *)batch NS_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

/*!
 * @brief Describes a possible problem that occured during the fetch.
 */
@property (nonatomic, strong, nullable, readwrite) NSError *error;

/*!
 * @brief Contains NSIndexPath type objects for defining where new objects should be inserted.
 * Not nil only if error is nil
 */
@property (nonatomic, copy,   nullable, readwrite) NSArray *indexPaths;

/*!
 * @brief Contains NSUINteger type objects for defining whether there are new sections to be inserted
 * Not nil only if error is nil
 */
@property (nonatomic, copy,   nullable, readwrite) NSIndexSet *addedSectionsIndexSet;

/*!
 * @brief Original request.
 */
@property (nonatomic, strong, nullable, readwrite) BIBatchRequest *batchRequest;

/*!
 * Extra request values.
 */
@property (nonatomic, assign, readwrite) BIBatchResponseOptions options;

/*!
 * @brief Fill indexPaths array with NSIndexPath type values based on the number of items to insert,
 * total number of section items and batchRequest insertPosition.
 * @param countNewItems Number of new items to be inserted.
 * @param countSectionItems Number of item in the section where the new elements will be inserted.
 */
- (void)createIndexPaths:(NSUInteger)countNewItems
       countSectionItems:(NSUInteger)countSectionItems;

@end
