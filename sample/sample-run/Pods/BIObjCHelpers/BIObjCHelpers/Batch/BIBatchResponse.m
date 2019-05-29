//
//  BIBatchResponse.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 08/09/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIBatchResponse.h"
#import "BIBatchRequest.h"

@interface BIBatchResponse ()

@property (nonatomic, strong, nullable, readwrite) NSError *error;
@property (nonatomic, copy,   nullable, readwrite) NSArray *indexPaths;
@property (nonatomic, copy,   nullable, readwrite) NSIndexSet *addedSectionsIndexSet;
@property (nonatomic, strong, nullable, readwrite) BIBatchRequest *batchRequest;
@property (nonatomic, assign, readwrite) BIBatchResponseOptions options;

@end

@implementation BIBatchResponse

#pragma mark - NSCopying methods

- (nonnull BIBatchResponse *)copyWithZone:(NSZone *)zone {
    BIBatchResponse *copy = [[BIBatchResponse allocWithZone:zone] init];

    copy.error = [self.error copy];
    copy.indexPaths = self.indexPaths;
    copy.options = self.options;
    copy.batchRequest = [self.batchRequest copy];
    copy.addedSectionsIndexSet = self.addedSectionsIndexSet;
    
    return copy;
}

#pragma mark - NSMutableCopying methods

- (nonnull instancetype)mutableCopyWithZone:(NSZone *)zone {
    BIMutableBatchResponse *mutableCopy = [[BIMutableBatchResponse allocWithZone:zone] initWithBatchRequest:self.batchRequest];

    mutableCopy.error = self.error;
    mutableCopy.indexPaths = self.indexPaths;
    mutableCopy.options = self.options;
    mutableCopy.addedSectionsIndexSet = self.addedSectionsIndexSet;
    
    return mutableCopy;
}

#pragma mark - NSObject methods

- (nonnull BIBatchResponse *)copy {
    return [super copy];
}

- (nonnull BIMutableBatchResponse *)mutableCopy {
    return [super mutableCopy];
}

#pragma mark - Property methods

- (BOOL)shouldStopPullToRefresh {
    return (self.options & BIBatchResponseOptionStopPullToRefresh) > 0;
}

- (BOOL)shouldStopInfiniteScrolling {
    return (self.options & BIBatchResponseOptionStopInfiniteScrolling) > 0;
}

- (BOOL)shouldDisablePullToRefresh {
    return (self.options & BIBatchResponseOptionDisablePullToRefresh) > 0;
}

- (BOOL)shouldDisableInfiniteScrolling {
    return (self.options & BIBatchResponseOptionDisableInfiniteScrolling) > 0;
}

@end


@implementation BIMutableBatchResponse

@dynamic error;
@dynamic indexPaths;
@dynamic batchRequest;
@dynamic options;
@dynamic addedSectionsIndexSet;

#pragma mark - Factory methods

+ (nonnull instancetype)batchResponseForRequest:(nonnull BIBatchRequest *)batch {
    return [[self alloc] initWithBatchRequest:batch];
}

#pragma mark - Init methods

- (nonnull instancetype)initWithBatchRequest:(nonnull BIBatchRequest *)batch {
    self = [super init];
    if (self) {
        self.batchRequest = batch;
    }
    return self;
}

#pragma mark - Public methods

- (void)createIndexPaths:(NSUInteger)countNewItems
       countSectionItems:(NSUInteger)countSectionItems {
    NSUInteger sectionIndex = self.batchRequest.sectionIndex;
    NSUInteger newRowIndex = 0;
    switch (self.batchRequest.insertPosition) {
        case BIBatchInsertPositionTop:
            newRowIndex = 0;
            break;
        case BIBatchInsertPositionBottom:
            newRowIndex = countSectionItems;
            break;
        default:
            newRowIndex = self.batchRequest.insertPosition;
            break;
    }
    
    NSUInteger lastRowIndex = newRowIndex + countNewItems;
    NSMutableArray *mutableArray = [NSMutableArray new];
    for (NSUInteger index = newRowIndex; index < lastRowIndex; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:sectionIndex];
        [mutableArray addObject:indexPath];
    }
    self.indexPaths = [mutableArray copy];
}

@end
