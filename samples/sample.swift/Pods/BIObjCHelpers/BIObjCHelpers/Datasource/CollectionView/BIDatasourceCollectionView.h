//
//  BIDatasourceCollectionView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceBase.h"

#import <UIKit/UIKit.h>

typedef void(^BIDatasourceCollectionViewConfigureCell)(id __nonnull cell, NSIndexPath * __nonnull indexPath);

@interface BIDatasourceCollectionView : BIDatasourceBase<UICollectionViewDataSource>

+ (nonnull instancetype)datasourceWithCollectionView:(nonnull UICollectionView *)collectionView;
- (nonnull instancetype)initWithCollectionView:(nonnull UICollectionView *)collectionView;
- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

@property (nonatomic, readonly, strong, nonnull) UICollectionView *collectionView;
@property (nonatomic, copy, nullable) NSString *cellIdentifier;
@property (nonatomic, strong, nullable) Class cellClass;
@property (nonatomic, strong, nullable) UINib *cellNib;
@property (nonatomic, copy, nullable) BIDatasourceCollectionViewConfigureCell configureCellBlock;

- (void)configureCell:(nonnull UICollectionViewCell *)cell atIndexPath:(nonnull NSIndexPath *)indexPath;

/*!
 * @brief Remove items at a given paths. Use this method instead of collectionView's similar one in
 * order to better manipulate its stored data.
 * @param indexPath Specifies items that need removing.
 */
- (void)deleteItemsAtIndexPaths:(nonnull NSArray *)indexPaths;

/*!
 * @brief Insert items at a given indexPaths with a given model objects.
 * Use this method instead of collectionView's similar one in order to better manipulate its stored data.
 * @param indexPath Specifies where items need to be inserted.
 * @param models Model for the cell.
 */
- (void)insertItemsAtIndexPaths:(nonnull NSArray *)indexPaths
                         models:(nonnull NSArray *)models;
@end
