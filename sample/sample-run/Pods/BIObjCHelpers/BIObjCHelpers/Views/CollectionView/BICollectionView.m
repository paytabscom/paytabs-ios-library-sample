//
//  BICollectionView.m
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 8/31/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import "BICollectionView.h"
#import "BIActivityIndicatorContainerView.h"
#import "_BIScrollViewProxy.h"
#import "BIBatchHelpers.h"
#import "BIScrollAdditionalViewBase.h"
#import "BIDatasourceFeedCollectionView.h"
#import "UIScrollView+InfiniteScroll.h"
#import "UIScrollView+BIBatching.h"

@interface BICollectionView () <UICollectionViewDelegate>

@property (nonatomic, strong, nullable, readwrite) _BIScrollViewProxy *proxyDelegate;
@property (nonatomic, weak, nullable,   readwrite) BIDatasourceCollectionView *datasource;
@property (nonatomic, weak, nullable,   readwrite) BIHandlerCollectionView *handler;
@property (nonatomic, strong, nullable, readwrite) UIRefreshControl *pullToRefreshControl;

@property (nonatomic, assign, getter=BI_isPullToRefreshEnabled) BOOL BI_pullToRefreshEnabled;
@property (nonatomic, assign, getter=BI_isInfiniteScrollingEnabled) BOOL BI_infiniteScrollingEnabled;

@end

@implementation BICollectionView

CGFloat const kBIActivityIndicatorViewHeight = 44.f;

#pragma mark - Init methods

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self BI_setupCollectionView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self BI_setupCollectionView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self BI_setupCollectionView];
    }
    return self;
}

#pragma mark - Dealloc method

- (void)dealloc {
    [self.visibleAdditionalView unregisterAdditionalViewListeners:self];
}

#pragma mark - UIView methods

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutAdditionalView];
}

#pragma mark - UICollectionViewDelegate methods

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    /*!
     By setting the delegate to nil in a dealloc method causes a crash in the proxy class.
     Fix it by nilling the proxy in case delegate is nil.
     */
    if (!delegate) {
        [super setDelegate:nil];
        _proxyDelegate = nil;
        return;
    }
    self.proxyDelegate = [[_BIScrollViewProxy alloc] initWithTarget:delegate interceptor:self];
    [super setDelegate:(id<UICollectionViewDelegate>)self.proxyDelegate];
}

- (id<UICollectionViewDelegate>)delegate {
    id<UICollectionViewDelegate> validDelegate = self.proxyDelegate.target;
    return validDelegate;
}

- (void)insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [super insertItemsAtIndexPaths:indexPaths];
    if ([self BI_totalNumberOfRows] != 0 && self.visibleAdditionalView) {
        [self removeVisibleAdditionalView];
    }
}

- (void)deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [super deleteItemsAtIndexPaths:indexPaths];
    if ([self BI_totalNumberOfRows] == 0 && !self.visibleAdditionalView) {
        [self addAdditionalNoContentView];
    }
}

#pragma mark - Public methods

- (void)triggerPullToRefresh {
    [self BI_createPullToRefreshControl];
    [self.pullToRefreshControl beginRefreshing];
    if (self.pullToRefreshCallback) {
        self.pullToRefreshCallback();
    }
}

- (void)triggerInfiniteScrolling {
    [self triggerInfiniteScrollingNotifyListeners:YES];
}

- (void)triggerInfiniteScrollingNotifyListeners:(BOOL)notifyListeners {
    self.infiniteScrollingState = BIInfiniteScrollingStateLoading;
    if (notifyListeners && self.infiniteScrollingCallback) {
        self.infiniteScrollingCallback();
    }
}

#pragma mark - Batch Fetching

- (void)scrollViewWillEndDragging:(nonnull UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout nonnull CGPoint *)targetContentOffset {
    // Call the method on the delegate class
    if ([self.proxyDelegate.target respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.proxyDelegate.target scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
    
    if (!self.infiniteScrollingEnabled || self.infiniteScrollingState == BIInfiniteScrollingStateLoading) {
        return;
    }
    [self handleFetchBatchForTargetOffset:*targetContentOffset];
}

- (void)handleFetchBatchForTargetOffset:(CGPoint)targetOffset {
    if (BIDisplayShouldFetchBatch([self BI_scrollDirection], self.bounds, self.contentSize, targetOffset, self.infiniteScrollingLeadingScreens)) {
        [self triggerInfiniteScrolling];
    }
}

#pragma mark - Getters and Setters

- (void)setPullToRefreshEnabled:(BOOL)pullToRefreshEnabled {
    _pullToRefreshEnabled = pullToRefreshEnabled;
    if (_pullToRefreshEnabled) {
        [self BI_createPullToRefreshControl];
        self.alwaysBounceVertical = YES;
        [self addSubview:self.pullToRefreshControl];
    } else {
        [self.pullToRefreshControl removeFromSuperview];
        self.pullToRefreshControl = nil;
    }
}

- (void)setInfiniteScrollingEnabled:(BOOL)infiniteScrollingEnabled {
    _infiniteScrollingEnabled = infiniteScrollingEnabled;
    [self BI_configureInfiniteScrolling];
}

- (void)setInfiniteScrollingState:(BIInfiniteScrollingState)infiniteScrollingState {
    _infiniteScrollingState = infiniteScrollingState;
    switch (_infiniteScrollingState) {
        case BIInfiniteScrollingStateStopped:
            [self finishInfiniteScroll];
            break;
        default:
            break;
    }
}

#pragma mark - BIScrollAdditionalViewBaseListener methods

- (void)didTapTableAdditionalView:(nonnull BIScrollAdditionalViewBase *)additionalView {
    if ([self.datasource isKindOfClass:[BIDatasourceFeedCollectionView class]]) {
        switch (additionalView.type) {
            case BITableAdditionalTypeErrorNoContentView: {
                BIDatasourceFeedCollectionView *feedDatasource = (BIDatasourceFeedCollectionView *)self.datasource;
                [feedDatasource triggerErrorNoContentTapToRetryRequest];
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark - UIScrollView+BIBatching methods

#pragma mark - Private properties methods

- (void)setBI_infiniteScrollingEnabled:(BOOL)BI_infiniteScrollingEnabled {
    _BI_infiniteScrollingEnabled = BI_infiniteScrollingEnabled;
    [self BI_configureInfiniteScrolling];
}

- (void)setBI_pullToRefreshEnabled:(BOOL)BI_pullToRefreshEnabled {
    _BI_pullToRefreshEnabled = BI_pullToRefreshEnabled;
    if (!_BI_pullToRefreshEnabled) {
        [self.pullToRefreshControl removeFromSuperview];
        self.pullToRefreshControl = nil;
    } else if (_BI_pullToRefreshEnabled && self.pullToRefreshEnabled && !self.pullToRefreshControl) {
        [self BI_createPullToRefreshControl];
        self.alwaysBounceVertical = YES;
        [self addSubview:self.pullToRefreshControl];
    }
}

#pragma mark - Action methods

- (void)BI_handlePullToRefreshAction:(UIRefreshControl *)sender {
    if (self.pullToRefreshCallback) {
        self.pullToRefreshCallback();
    }
}

#pragma mark - Private Methods

- (void)BI_startInfiniteScrolling {
    [self triggerInfiniteScrolling];
}

- (BIScrollDirection)BI_scrollDirection {
    CGPoint scrollVelocity = [self.panGestureRecognizer velocityInView:self.superview];
    BIScrollDirection direction = BIScrollDirectionNone;
    if (scrollVelocity.y > 0) {
        direction = BIScrollDirectionDown;
    } else {
        direction = BIScrollDirectionUp;
    }
    return direction;
}

- (void)BI_setupCollectionView {
    self.proxyDelegate = [[_BIScrollViewProxy alloc] initWithTarget:nil interceptor:self];
    [super setDelegate:(id<UICollectionViewDelegate>)self.proxyDelegate];
    self.BI_infiniteScrollingEnabled = YES;
    self.infiniteScrollingEnabled = NO;
    self.pullToRefreshEnabled = YES;
    self.infiniteScrollingLeadingScreens = kBIDefaultInfiniteScrollingLeadingScreens;
}

- (void)BI_createPullToRefreshControl {
    if (!_pullToRefreshControl) {
        _pullToRefreshControl = [UIRefreshControl new];
        [_pullToRefreshControl addTarget:self action:@selector(BI_handlePullToRefreshAction:) forControlEvents:UIControlEventValueChanged];
    }
}

- (void)BI_configureInfiniteScrolling {
    if ((self.BI_infiniteScrollingEnabled && self.isInfiniteScrollingEnabled)) {
        [self addInfiniteScrollWithHandler:^(__kindof UIScrollView * _Nonnull scrollView) {
            
        }];
    } else {
        [self removeInfiniteScroll];
    }
}

- (NSInteger)BI_totalNumberOfRows {
    NSInteger numberOfSections = 1;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        numberOfSections = [self.dataSource numberOfSectionsInCollectionView:self];
    }
    
    NSInteger totalNumberOfRows = 0;
    for (NSInteger sectionIndex = 0; sectionIndex < numberOfSections; sectionIndex++) {
        totalNumberOfRows += [self.dataSource collectionView:self numberOfItemsInSection:sectionIndex];
    }
    return totalNumberOfRows;
}

@end
