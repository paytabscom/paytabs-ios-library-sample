//
//  BIBatchHelpers.m
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIBatchHelpers.h"

BOOL BIDisplayShouldFetchBatch(BIScrollDirection scrollDirection,
                               CGRect bounds,
                               CGSize contentSize,
                               CGPoint targetOffset,
                               CGFloat leadingScreens) {
    
    // only Up and Left scrolls are currently supported (tail loading)
    if (scrollDirection != BIScrollDirectionLeft && scrollDirection != BIScrollDirectionUp) {
        return NO;
    }
    
    // no fetching for null states
    if (leadingScreens <= 0.0 ||
        CGRectEqualToRect(bounds, CGRectZero)) {
        return NO;
    }
    
    CGFloat viewLength, offset, contentLength;
    
    if (scrollDirection == BIScrollDirectionUp) {
        viewLength = bounds.size.height;
        offset = targetOffset.y;
        contentLength = contentSize.height;
    } else { // horizontal
        viewLength = bounds.size.width;
        offset = targetOffset.x;
        contentLength = contentSize.width;
    }
    
    // target offset will always be 0 if the content size is smaller than the viewport
    BOOL hasSmallContent = offset == 0.0 && contentLength < viewLength;
    
    CGFloat triggerDistance = viewLength * leadingScreens;
    CGFloat remainingDistance = contentLength - viewLength - offset;
    
    return hasSmallContent || remainingDistance <= triggerDistance;
}

const CGFloat kBIDefaultInfiniteScrollingLeadingScreens = .5f;
const CGFloat kBITableFooterViewAnimationDuration = .25f;
