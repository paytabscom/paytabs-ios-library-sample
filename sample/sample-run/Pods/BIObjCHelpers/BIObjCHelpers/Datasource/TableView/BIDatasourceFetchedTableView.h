//
//  BIDatasourceFetchedTableView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/12/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceTableView.h"

#import <CoreData/CoreData.h>

@interface BIDatasourceFetchedTableView : BIDatasourceTableView<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong, nullable) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, assign, getter=isPaused) BOOL paused;

@end
