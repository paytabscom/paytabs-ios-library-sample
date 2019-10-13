//
//  BIBatchRequest.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 08/09/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BIBatchRequest.h"

const NSInteger kDefaultBatchRequestSize = 3;

@interface BIBatchRequest ()

@property (nonatomic, assign, readwrite) NSUInteger batchSize;
@property (nonatomic, assign, readwrite) NSUInteger sectionIndex;
@property (nonatomic, copy, nullable, readwrite) BIBatchRequestCompletionBlock completionBlock;
@property (nonatomic, assign, readwrite) BIBatchRequestOptions options;

@end


@implementation BIBatchRequest

#pragma mark - Init methods

- (instancetype)initWithSection:(NSUInteger)sectionIndex
                      batchSize:(NSUInteger)batchSize
                completionBlock:(BIBatchRequestCompletionBlock)completionBlock {
    self = [super init];
    if (self) {
        self.sectionIndex = sectionIndex;
        self.batchSize = batchSize;
        self.completionBlock = completionBlock;
        self.insertPosition = BIBatchInsertPositionBottom;
    }
    return self;
}

- (instancetype)initWithCompletionBlock:(BIBatchRequestCompletionBlock)completionBlock {
    return [self initWithSection:0
                       batchSize:kDefaultBatchRequestSize
                 completionBlock:completionBlock];
}

#pragma mark - Public methods

- (BOOL)isEqualToRequest:(nonnull BIBatchRequest *)anotherRequest {
    BOOL isBatchSizeEqual = self.batchSize == anotherRequest.batchSize;
    BOOL isSectionIndexEqual = self.sectionIndex == anotherRequest.sectionIndex;
    BOOL isInsertPositionEqual = self.insertPosition == anotherRequest.insertPosition;
    BOOL areOptionsEqual = self.options == anotherRequest.options;
    return isBatchSizeEqual && isSectionIndexEqual && isInsertPositionEqual && areOptionsEqual;
}

#pragma mark - NSCopying methods

- (id)copyWithZone:(nullable NSZone *)zone {
    BIBatchRequest *copy = [[BIBatchRequest allocWithZone:zone] initWithCompletionBlock:self.completionBlock];
    copy.batchSize = self.batchSize;
    copy.sectionIndex = self.sectionIndex;
    copy.insertPosition = self.insertPosition;
    copy.options = self.options;
    return copy;
}

#pragma mark - NSMutableCopying methods

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    BIMutableBatchRequest *mutableCopy = [[BIMutableBatchRequest allocWithZone:zone] initWithCompletionBlock:self.completionBlock];
    mutableCopy.batchSize = self.batchSize;
    mutableCopy.sectionIndex = self.sectionIndex;
    mutableCopy.insertPosition = self.insertPosition;
    mutableCopy.options = self.options;
    return mutableCopy;
}

#pragma mark - NSObject methods

- (nonnull BIBatchRequest *)copy {
    return [super copy];
}

- (nonnull BIMutableBatchRequest *)mutableCopy {
    return [super mutableCopy];
}

#pragma mark - Property methods

- (BOOL)isInitialRequest {
    return (self.options & BIBatchRequestOptionInitialRequest) > 0;
}

- (BOOL)isPullToRefreshRequest {
    return (self.options & BIBatchRequestOptionPullToRefreshRequest) > 0;
}

- (BOOL)isInfiniteScrollingRequest {
    return (self.options & BIBatchRequestOptionInfiniteScrollingRequest) > 0;
}

- (BOOL)isErrorNoContentTapToRetryRequest {
    return (self.options & BIBatchRequestOptionErrorTapToRetry) > 0;
}

- (BOOL)isNoContentRequest {
    return (self.options & BIBatchRequestOptionNoContent) > 0;
}

- (BOOL)isReloadRequest {
    return (self.options & BIBatchRequestOptionReload) > 0;
}

@end

@implementation BIMutableBatchRequest

@dynamic batchSize;
@dynamic sectionIndex;
@dynamic completionBlock;
@dynamic options;

#pragma mark - Init methods

- (nonnull instancetype)initWithSection:(NSUInteger)sectionIndex
                              batchSize:(NSUInteger)batchSize
                        completionBlock:(nullable BIBatchRequestCompletionBlock)completionBlock {
    self = [super initWithSection:sectionIndex batchSize:batchSize completionBlock:completionBlock];
    return self;
}

@end
