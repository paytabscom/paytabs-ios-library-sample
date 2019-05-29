//
//  BIDatasourceCollectionView.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceCollectionView.h"
#import "_BICollectionView+Internal.h"

@interface BIDatasourceCollectionView ()

@property (nonatomic, readwrite, strong, nonnull) UICollectionView *collectionView;

@end


@implementation BIDatasourceCollectionView

#pragma mark - Init methods

+ (instancetype)datasourceWithCollectionView:(UICollectionView *)collectionView {
    return [[[self class] alloc] initWithCollectionView:collectionView];
}

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    NSParameterAssert(collectionView);
    if (self) {
        self.collectionView = collectionView;
        self.collectionView.dataSource = self;
        if ([self.collectionView isKindOfClass:[BICollectionView class]]) {
            BICollectionView *biCollectionView = (BICollectionView *)self.collectionView;
            biCollectionView.datasource = self;
        }
    }
    return self;
}

#pragma mark - Property methods

- (NSString *)cellIdentifier {
    if (!_cellIdentifier) {
        _cellIdentifier = [NSUUID UUID].UUIDString;
    }
    return _cellIdentifier;
}

- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [UICollectionViewCell class];
    }
    return _cellClass;
}

#pragma mark - Public methods

- (void)load {
    [super load];
    NSParameterAssert(self.cellIdentifier.length);
    NSParameterAssert([self.cellClass isSubclassOfClass:[UICollectionViewCell class]]);
    
    if (self.cellNib) {
        [self.collectionView registerNib:self.cellNib forCellWithReuseIdentifier:self.cellIdentifier];
    } else if (self.cellClass) {
        [self.collectionView registerClass:self.cellClass forCellWithReuseIdentifier:self.cellIdentifier];
    }
}

- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, indexPath);
    }
}

- (void)deleteItemsAtIndexPaths:(nonnull NSArray *)indexPaths {
    [self.collectionView deleteItemsAtIndexPaths:indexPaths];
}

- (void)insertItemsAtIndexPaths:(nonnull NSArray *)indexPaths
                         models:(nonnull NSArray *)models {
    [self.collectionView insertItemsAtIndexPaths:indexPaths];
}

#pragma mark - UICollectionViewDatasource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

@end
