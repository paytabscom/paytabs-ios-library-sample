//
//  BIScrollAdditionalViewBase.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 18/01/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BIScrollAdditionalViewBase;

/*!
 * @brief Listener methods for a base table additional view.
 */
@protocol BIScrollAdditionalViewBaseListener <NSObject>

@optional

/*!
 * @brief Notify listener that user has tapped the additional view.
 * @param additionalView Tapped additional view.
 */
- (void)didTapTableAdditionalView:(nonnull BIScrollAdditionalViewBase *)additionalView;

@end


/*!
 * @brief Describe types of additional view.
 */
typedef NS_ENUM(NSUInteger, BITableAdditionalTypeView) {
    /*!
     * @brief View shown when table view is empty with no data to display.
     */
    BITableAdditionalTypeNoContentView = 0,
    /*!
     * @brief View shown when table view is empty due to an error.
     */
    BITableAdditionalTypeErrorNoContentView,
    /*!
     * @brief View shown when table view is loading its content for the first time.
     */
    BITableAdditionalTypeLoadingContentView
};

/*!
 * @brief Base class for additional views for a scroll view.
 * It has a tap gesture used in general for reloading.
 */
@interface BIScrollAdditionalViewBase : UIView <UIGestureRecognizerDelegate>

/*!
 * @brief Simple tap gesture.
 */
@property (nonatomic, strong, nullable, readonly) UITapGestureRecognizer *tapGestureRecognizer;

/*!
 * @brief Callback to be called when user taps the view.
 */
@property (nonatomic, copy, nullable) void(^didTapContentViewCallback)(void);

/*!
 * @brief Its listeners.
 */
@property (nonatomic, strong, nonnull, readonly) NSHashTable<BIScrollAdditionalViewBaseListener> *contentViewListeners;

/*!
 * @brief Additional view's type.
 */
@property (nonatomic, assign, readonly) BITableAdditionalTypeView type;

/*!
 * @brief Base setup method. Always call super for proper initialization.
 */
- (void)commonSetup;

/*!
 * @brief Register a listener.
 * @param listener Lister to register.
 */
- (void)registerAdditionalViewListeners:(nonnull id<BIScrollAdditionalViewBaseListener>)listener;

/*!
 * @brief Unregister a listener.
 * @param listener Lister to unregister.
 */
- (void)unregisterAdditionalViewListeners:(nonnull id<BIScrollAdditionalViewBaseListener>)listener;

/*!
 * @brief Called by the tap gesture. Notifies listeners.
 * @param tapGesture Gesture that triggered the vevent.
 */
- (void)handleAdditionalViewTapGesture:(nonnull UITapGestureRecognizer *)tapGesture;

/*!
 * @brief Notify listeners that a tap event has occurred.
 */
- (void)notifyAdditionalViewListenersOnDidTapEvent;

@end
