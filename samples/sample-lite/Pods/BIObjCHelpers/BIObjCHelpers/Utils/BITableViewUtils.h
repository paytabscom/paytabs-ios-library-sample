//
//  BITableViewUtils.h
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 6/10/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

typedef NS_ENUM(NSUInteger, BIDatasourceTableViewFetchingState) {
    BIDatasourceTableViewFetchingStateNone = 0,
    BIDatasourceTableViewFetchingStatePullToRefresh,
    BIDatasourceTableViewFetchingStateInfiniteScrolling
};
