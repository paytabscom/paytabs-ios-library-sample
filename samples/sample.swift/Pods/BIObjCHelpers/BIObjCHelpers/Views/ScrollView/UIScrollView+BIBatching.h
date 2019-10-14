//
//  UIScrollView+BIBatching.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 22/02/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import "BIScrollAdditionalViewBase.h"

#import <UIKit/UIKit.h>

/*!
 @brief Category for handling additional views such as loading, error or no content.
 */
@interface UIScrollView (BIBatching) <BIScrollAdditionalViewBaseListener>

/*!
 @brief Currently used additional view when scroll view is empty(no data to show).
 */
@property (nonatomic, strong, nullable, readonly) BIScrollAdditionalViewBase *additionalNoContentView;

/*!
 @brief Currently used additional view when scroll view is empty due to a failed operation. Can be used
 to reload scroll view content with a simple tap gesture.
 */
@property (nonatomic, strong, nullable, readonly) BIScrollAdditionalViewBase *additionalErrorNoContentView;

/*!
 @brief Currently used additional view when scroll view is loading the initial data on first request, or after a failed initial request.
 */
@property (nonatomic, strong, nullable, readonly) BIScrollAdditionalViewBase *additionalLoadingContentView;

/*!
 @brief Currently visible additional view.
 */
@property (nonatomic, strong, nullable, readonly) BIScrollAdditionalViewBase *visibleAdditionalView;

/*!
 @brief Callback to create an no content additional view.
 */
@property (nonatomic, copy, nullable) BIScrollAdditionalViewBase * _Nullable (^createAdditionalNoContentViewCallback)(void);

/*!
 @brief Callback to create an error no content additional view.
 */
@property (nonatomic, copy, nullable) BIScrollAdditionalViewBase * _Nullable (^createAdditionalErrorNoContentViewCallback)(void);

/*!
 @brief Callback to create an loading additional view.
 */
@property (nonatomic, copy, nullable) BIScrollAdditionalViewBase * _Nullable (^createAdditionalLoadingContentViewCallback)(void);

/*!
 @brief Method to create an no content additional view.
 @return Additional view to show, or nil otherwise.
 */
- (nullable BIScrollAdditionalViewBase *)createAdditionalNoContentView;

/*!
 @brief Method to create an error no content additional view.
 @return Additional view to show, or nil otherwise.
 */
- (nullable BIScrollAdditionalViewBase *)createAdditionalErrorNoContentView;

/*!
 @brief Method to create an loading additional view.
 @return Additional view to show, or nil otherwise.
 */
- (nullable BIScrollAdditionalViewBase *)createAdditionalLoadingContentView;

/*!
 @brief Add any additional view to the scroll. Will disable scroll view scrolling.
 @param additionalView View to add.
 */
- (void)addGeneralAdditionalView:(nonnull BIScrollAdditionalViewBase *)additionalView;

/*!
 @brief Create and add an no content additional view to the scroll. Will disable scroll view scrolling.
 Will remove any previous additional view.
 */
- (void)addAdditionalNoContentView;

/*!
 @brief Create and add an error no content additional view to the scroll. Will disable scroll view scrolling.
 Will remove any previous additional view.
 */
- (void)addAdditionalErrorNoContentView;

/*!
 @brief Create and add an loading additional view to the scroll. Will disable scroll view scrolling.
 Will remove any previous additional view.
 */
- (void)addAdditionalLoadingContentView;

/*!
 @brief Remove a given additional view from the scroll. Will enable scroll view scrolling.
 @param additionalView View to remove.
 */
- (void)removeGeneralAdditionalView:(nonnull BIScrollAdditionalViewBase *)additionalView;

/*!
 @brief Remove currently visible additional view from the scroll. Will enable scroll view scrolling.
 */
- (void)removeVisibleAdditionalView;

/*!
 @brief Layout currently visible additional view.
 */
- (void)layoutAdditionalView;

@end
