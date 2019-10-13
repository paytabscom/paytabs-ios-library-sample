//
//  BITableViewCell.h
//  BIObjCHelpers
//
//  Created by Mihai Chifor on 7/17/15.
//  Copyright (c) 2015 iGama Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 Default height for separatorview (1 pt).
 */
FOUNDATION_EXPORT const CGFloat kBIDefaultTableViewCellSeparatorViewHeight;

/*!
 @brief Custom table view cell.
 */
@interface BITableViewCell : UITableViewCell

/*!
 @brief Custom separator view placed at the bottom of the cell.
 Valid only if separatorViewVisible is YES.
 */
@property (nonatomic, strong, nonnull, readonly) UIView *separatorView;

/*!
 @brief Flag for adding of removing the separatorView. Default is YES.
 */
@property (nonatomic, assign, getter=isSeparatorViewVisible) BOOL separatorViewVisible;

/*!
 @brief Custom height for separatorView. Defaults to kBIDefaultTableViewCellSeparatorViewHeight(1 pt).
 */
@property (nonatomic, assign) CGFloat separatorViewHeight;

@end
