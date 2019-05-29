//
//  BIHandlerTableView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 04/05/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIHandlerBase.h"

#import <UIKit/UIKit.h>

typedef void(^BIHandlerTableViewRowSelectionCallback)(id __nonnull cell, NSIndexPath * __nonnull indexPath);

@interface BIHandlerTableView : BIHandlerBase<UITableViewDelegate>

+ (nonnull instancetype)handlerWithTableView:(nonnull UITableView *)tableView;
- (nonnull instancetype)initWithTableView:(nonnull UITableView *)tableView;
- (nonnull instancetype)init NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

@property (nonatomic, readonly, strong, nonnull) UITableView *tableView;

@property (nonatomic, copy, nullable) BIHandlerTableViewRowSelectionCallback didSelectRowCallback;
@property (nonatomic, copy, nullable) BIHandlerTableViewRowSelectionCallback didDeselectRowCallback;

@end
