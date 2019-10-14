//
//  BICollectionView+Internal.h
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BICollectionView.h"

@interface BICollectionView (Internal)

@property (nonatomic, weak, nullable, readwrite) BIDatasourceCollectionView *datasource;
@property (nonatomic, weak, nullable, readwrite) BIHandlerCollectionView *handler;

@property (nonatomic, assign, getter=BI_isPullToRefreshEnabled) BOOL BI_pullToRefreshEnabled;
@property (nonatomic, assign, getter=BI_isInfiniteScrollingEnabled) BOOL BI_infiniteScrollingEnabled;

/*!
 Method for starting the loading spinner
 This method will start loading the spinner even if infiniteScrollingEnabled is NO
 */
- (void)BI_startInfiniteScrolling;

@end
