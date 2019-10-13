//
//  BIDatasourceTableView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceBase.h"
#import "BITableView.h"

#import <UIKit/UIKit.h>

typedef void(^BIDatasourceTableViewConfigureCell)(id __nonnull cell, NSIndexPath * __nonnull indexPath);

@interface BIDatasourceTableView : BIDatasourceBase <UITableViewDataSource>

+ (nonnull instancetype)datasourceWithTableView:(nonnull UITableView *)tableView;
- (nonnull instancetype)initWithTableView:(nonnull UITableView *)tableView;
- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;


@property (nonatomic, strong, nonnull, readonly) UITableView *tableView;
@property (nonatomic, copy,   nullable) NSString *cellIdentifier;
@property (nonatomic, strong, nullable) Class cellClass;
@property (nonatomic, strong, nullable) UINib *cellNib;
@property (nonatomic, copy,   nullable) BIDatasourceTableViewConfigureCell configureCellBlock;
@property (nonatomic, copy,   nullable) NSInteger(^numberOfRowsInSectionCallback)(NSInteger section);

- (void)configureCell:(nonnull UITableViewCell *)cell atIndexPath:(nonnull NSIndexPath *)indexPath;

/*!
 * @brief Remove cells at a given paths. Use this method instead of tableView's similar one in
 * order to better manipulate its stored data.
 * @param indexPath Specifies cell that need removing.
 * @param animation How to animate the deletion.
 */
- (void)deleteRowsAtIndexPaths:(nonnull NSArray *)indexPaths
              withRowAnimation:(UITableViewRowAnimation)animation;

/*!
 * @brief Insert cells at a given indexPaths with a given model objects.
 * Use this method instead of tableView's similar one in order to better manipulate its stored data.
 * @param indexPath Specifies where cells need to be inserted.
 * @param models Model for the cell.
 * @param animation How to animate the inserting.
 */
- (void)insertRowsAtIndexPaths:(nonnull NSArray *)indexPaths
                        models:(nonnull NSArray *)models
              withRowAnimation:(UITableViewRowAnimation)animation;

@end
