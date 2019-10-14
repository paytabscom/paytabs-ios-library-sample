//
//  BITableView+Internal.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 17/08/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BITableView.h"

@interface BITableView (Internal)

@property (nonatomic, weak, nullable, readwrite) BIDatasourceTableView *datasource;
@property (nonatomic, weak, nullable, readwrite) BIHandlerTableView *handler;

@property (nonatomic, assign, getter=BI_isPullToRefreshEnabled) BOOL BI_pullToRefreshEnabled;
@property (nonatomic, assign, getter=BI_isInfiniteScrollingEnabled) BOOL BI_infiniteScrollingEnabled;

/*!
 Method for starting the loading spinner
 This method will start loading the spinner even if infiniteScrollingEnabled is NO
 */
- (void)BI_startInfiniteScrolling;

@end
