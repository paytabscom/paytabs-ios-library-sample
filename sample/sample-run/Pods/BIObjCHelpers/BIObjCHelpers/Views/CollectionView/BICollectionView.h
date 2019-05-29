//
//  BICollectionView.h
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIScrollDetails.h"

#import <UIKit/UIKit.h>

@class BIDatasourceCollectionView;
@class BIHandlerCollectionView;
@class BIScrollAdditionalViewBase;

/*!
 @brief CollectionView with infinite scrolling support.
 */
@interface BICollectionView : UICollectionView

/*!
 @brief Specifies whether to trigger the pullToRefresCallback block or not, when a pull-to-refresh gesture for the collectionView is made. Default is NO.
 */
@property (nonatomic, assign, getter=isPullToRefreshEnabled) BOOL pullToRefreshEnabled;

/*!
 @brief Used to notify the datasource to reload.
 */
@property (nonatomic, copy, nullable) void (^pullToRefreshCallback)();

/*!
 @brief Represents the view that is displayed on top of the collectionView when the pull-to-refresh gesture is made.
 */
@property (nonatomic, strong, nullable, readonly) UIRefreshControl *pullToRefreshControl;


/*!
 @brief Specifies whether the scrolling of the collectionView is infinite or not. If it is set to NO, no other batches are fetched. Default is YES.
 */
@property (nonatomic, assign) BOOL enableInfiniteScrolling __deprecated_msg("Use infiniteScrollingEnabled instead");

/*!
 @brief Specifies whether the scrolling of the collectionView is infinite or not. If it is set to NO, no other batches are fetched. Default is NO
 */
@property (nonatomic, assign, getter=isInfiniteScrollingEnabled) BOOL infiniteScrollingEnabled;

/*!
 @brief Used to notify dataSource to fetch the next batch
 */
@property (nonatomic, copy, nullable) void (^infiniteScrollingCallback)();

/*!
 @brief Represents the number of screens left to scroll before triggering the fetch of the next batch. Default is 0.5f (half of screen)
 */
@property (nonatomic, assign) CGFloat leadingScreens __deprecated_msg("Use infiniteScrollingLeadingScreens instead");

/*!
 @brief Represents the number of screens left to scroll before triggering the fetch of the next batch. Default is 0.5f (half of screen)
 */
@property (nonatomic, assign) CGFloat infiniteScrollingLeadingScreens;

/*!
 @brief The current state of the infinite scrolling view.
 */
@property (nonatomic, assign) BIInfiniteScrollingState infiniteScrollingState;

/*!
 @brief Collection view's datasource. Valid only if a BIDatasourceCollectionView type was created with a reference to this collection view.
 */
@property (nonatomic, weak, nullable, readonly) BIDatasourceCollectionView *datasource;

/*!
 @brief collection view's handler. Valid only if a BIHandlerCollectionView type was created with a reference to this collection view.
 */
@property (nonatomic, weak, nullable, readonly) BIHandlerCollectionView *handler;

/*!
 Manual trigger pull to refresh.
 */
- (void)triggerPullToRefresh;

/*!
 Manual trigger the infinite scrolling.
 */
- (void)triggerInfiniteScrolling;

@end
