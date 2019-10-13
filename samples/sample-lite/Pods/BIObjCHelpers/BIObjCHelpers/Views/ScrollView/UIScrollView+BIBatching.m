//
//  UIScrollView+BIBatching.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 22/02/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import "UIScrollView+BIBatching.h"
#import "BIScrollAdditionalViewBase.h"

#import <objc/runtime.h>

@implementation UIScrollView (BIBatching)

static void *kBIScrollViewAdditionalNoContentViewKey;
static void *kBIScrollViewAdditionalErrorNoContentViewKey;
static void *kBIScrollViewAdditionalLoadingViewKey;
static void *kBIScrollViewVisibleAdditionalViewKey;
static void *kBIScrollViewAdditionalNoContentViewCallbackKey;
static void *kBIScrollViewAdditionalErrorNoContentViewCallbackKey;
static void *kBIScrollViewAdditionalLoadingViewCallbackKey;

#pragma mark - Public methods

- (nullable BIScrollAdditionalViewBase *)createAdditionalNoContentView {
    if (self.createAdditionalNoContentViewCallback) {
        return self.createAdditionalNoContentViewCallback();
    }
    return nil;
}

- (nullable BIScrollAdditionalViewBase *)createAdditionalErrorNoContentView {
    if (self.createAdditionalErrorNoContentViewCallback) {
        return self.createAdditionalErrorNoContentViewCallback();
    }
    return nil;
}

- (nullable BIScrollAdditionalViewBase *)createAdditionalLoadingContentView {
    if (self.createAdditionalLoadingContentViewCallback) {
        return self.createAdditionalLoadingContentViewCallback();
    }
    return nil;
}

- (void)addGeneralAdditionalView:(nonnull BIScrollAdditionalViewBase *)additionalView {
    if (self.visibleAdditionalView) {
        [self.visibleAdditionalView removeFromSuperview];
    }
    
    self.visibleAdditionalView = additionalView;
    [self layoutAdditionalView];
    [self addSubview:self.visibleAdditionalView];
    self.scrollEnabled = NO;
}

- (void)addAdditionalNoContentView {
    BIScrollAdditionalViewBase *noContentView = [self createAdditionalNoContentView];
    if (noContentView) {
        [noContentView registerAdditionalViewListeners:self];
        [self addGeneralAdditionalView:noContentView];
    }
}

- (void)addAdditionalErrorNoContentView {
    BIScrollAdditionalViewBase *errorNoContentView = [self createAdditionalErrorNoContentView];
    if (errorNoContentView) {
        [errorNoContentView registerAdditionalViewListeners:self];
        [self addGeneralAdditionalView:errorNoContentView];
    }
}

- (void)addAdditionalLoadingContentView {
    BIScrollAdditionalViewBase *loadingView = [self createAdditionalLoadingContentView];
    if (loadingView) {
        [self addGeneralAdditionalView:loadingView];
    }
}

- (void)removeGeneralAdditionalView:(nonnull BIScrollAdditionalViewBase *)additionalView {
    [additionalView removeFromSuperview];
    [additionalView unregisterAdditionalViewListeners:self];
    if (self.visibleAdditionalView == additionalView) {
        self.visibleAdditionalView = nil;
    }
    self.scrollEnabled = YES;
}

- (void)removeVisibleAdditionalView {
    if (self.visibleAdditionalView) {
        [self removeGeneralAdditionalView:self.visibleAdditionalView];
    }
}

- (void)layoutAdditionalView {
    if (self.visibleAdditionalView) {
        self.visibleAdditionalView.frame = self.bounds;
    }
}

#pragma mark - Property methods

- (void)setAdditionalNoContentView:(BIScrollAdditionalViewBase * _Nullable)additionalNoContentView {
    objc_setAssociatedObject(self, &kBIScrollViewAdditionalNoContentViewKey, additionalNoContentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BIScrollAdditionalViewBase *_Nullable)additionalNoContentView {
    return objc_getAssociatedObject(self, &kBIScrollViewAdditionalNoContentViewKey);
}

- (void)setAdditionalErrorNoContentView:(BIScrollAdditionalViewBase * _Nullable)additionalErrorNoContentView {
    objc_setAssociatedObject(self, &kBIScrollViewAdditionalErrorNoContentViewKey, additionalErrorNoContentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BIScrollAdditionalViewBase *)additionalErrorNoContentView {
    return objc_getAssociatedObject(self, &kBIScrollViewAdditionalErrorNoContentViewKey);
}

- (void)setAdditionalLoadingContentView:(BIScrollAdditionalViewBase * _Nullable)additionalLoadingContentView {
    objc_setAssociatedObject(self, &kBIScrollViewAdditionalLoadingViewKey, additionalLoadingContentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BIScrollAdditionalViewBase *)additionalLoadingContentView {
    return objc_getAssociatedObject(self, &kBIScrollViewAdditionalLoadingViewKey);
}

- (void)setVisibleAdditionalView:(BIScrollAdditionalViewBase * _Nullable)visibleAdditionalView {
    objc_setAssociatedObject(self, &kBIScrollViewVisibleAdditionalViewKey, visibleAdditionalView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BIScrollAdditionalViewBase *)visibleAdditionalView {
    return objc_getAssociatedObject(self, &kBIScrollViewVisibleAdditionalViewKey);
}

- (void)setCreateAdditionalNoContentViewCallback:(BIScrollAdditionalViewBase * _Nullable (^)(void))createAdditionalNoContentViewCallback {
    objc_setAssociatedObject(self, &kBIScrollViewAdditionalNoContentViewCallbackKey, createAdditionalNoContentViewCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BIScrollAdditionalViewBase * _Nullable (^)(void))createAdditionalNoContentViewCallback {
    return objc_getAssociatedObject(self, &kBIScrollViewAdditionalNoContentViewCallbackKey);
}


- (void)setCreateAdditionalErrorNoContentViewCallback:(BIScrollAdditionalViewBase * _Nullable (^)(void))createAdditionalErrorNoContentViewCallback {
    objc_setAssociatedObject(self, &kBIScrollViewAdditionalErrorNoContentViewCallbackKey, createAdditionalErrorNoContentViewCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BIScrollAdditionalViewBase * _Nullable (^)(void))createAdditionalErrorNoContentViewCallback {
    return objc_getAssociatedObject(self, &kBIScrollViewAdditionalErrorNoContentViewCallbackKey);
}

- (void)setCreateAdditionalLoadingContentViewCallback:(BIScrollAdditionalViewBase * _Nullable (^)(void))createAdditionalLoadingContentViewCallback {
    objc_setAssociatedObject(self, &kBIScrollViewAdditionalLoadingViewCallbackKey, createAdditionalLoadingContentViewCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BIScrollAdditionalViewBase * _Nullable (^)(void))createAdditionalLoadingContentViewCallback {
    return objc_getAssociatedObject(self, &kBIScrollViewAdditionalLoadingViewCallbackKey);
}

@end
