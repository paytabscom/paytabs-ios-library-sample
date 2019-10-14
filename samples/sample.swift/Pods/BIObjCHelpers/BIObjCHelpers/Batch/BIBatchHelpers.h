//
//  BIBatchHelpers.h
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIScrollDetails.h"

#import <UIKit/UIKit.h>

/*!
 @abstract Determine if batch fetching should begin based on the state of the parameters.
 @param scrollDirection The current scrolling direction of the scroll view.
 @param bounds The bounds of the scrollview.
 @param contentSize The content size of the scrollview.
 @param targetOffset The offset that the scrollview will scroll to.
 @param leadingScreens How many screens in the remaining distance will trigger batch fetching.
 @return Whether or not the current state should proceed with batch fetching.
 @discussion This method is broken into a category for unit testing purposes and should be used with the BITableView and BICollectionView batch fetching API.
 */
extern BOOL BIDisplayShouldFetchBatch(BIScrollDirection scrollDirection,
                                      CGRect bounds,
                                      CGSize contentSize,
                                      CGPoint targetOffset,
                                      CGFloat leadingScreens);

extern const CGFloat kBIDefaultInfiniteScrollingLeadingScreens;
extern const CGFloat kBITableFooterViewAnimationDuration;
