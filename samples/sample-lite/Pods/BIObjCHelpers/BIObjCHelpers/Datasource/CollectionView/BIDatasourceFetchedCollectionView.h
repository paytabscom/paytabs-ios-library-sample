//
//  BIDatasourceFetchedCollectionView.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceCollectionView.h"

#import <CoreData/CoreData.h>

@interface BIDatasourceFetchedCollectionView : BIDatasourceCollectionView<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong, nullable) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, assign, getter=isPaused) BOOL paused;

@end
