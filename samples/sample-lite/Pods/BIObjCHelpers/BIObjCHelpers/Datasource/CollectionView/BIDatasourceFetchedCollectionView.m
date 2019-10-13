//
//  BIDatasourceFetchedCollectionView.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceFetchedCollectionView.h"

@interface BIDatasourceFetchedCollectionView ()

@property (nonatomic, strong, nonnull) NSMutableArray *objectChanges;
@property (nonatomic, strong, nonnull) NSMutableArray *sectionChanges;

@end

@implementation BIDatasourceFetchedCollectionView

#pragma mark - Property methods

- (void)setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController {
    NSParameterAssert(fetchedResultsController);
    if (_fetchedResultsController) {
        _fetchedResultsController.delegate = nil;
    }
    
    _fetchedResultsController = fetchedResultsController;
    _fetchedResultsController.delegate = self;
}

- (void)setPaused:(BOOL)paused {
    self.fetchedResultsController.delegate = paused? nil : self;
    _paused = paused;
    if (!_paused) {
        NSError *error;
        [self.fetchedResultsController performFetch:&error];
        if (error) {
            NSLog(@"Error while performing fetch: %@", error);
        }
    }
}

- (NSMutableArray *)objectChanges {
    if (!_objectChanges) {
        _objectChanges = [NSMutableArray new];
    }
    return _objectChanges;
}

- (NSMutableArray *)sectionChanges {
    if (!_sectionChanges) {
        _sectionChanges = [NSMutableArray new];
    }
    return _sectionChanges;
}

#pragma mark - UICollectionViewDatasource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSParameterAssert(self.fetchedResultsController);
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSParameterAssert(self.fetchedResultsController);
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(self.fetchedResultsController);
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - NSFetchedResultsControllerDelegate methods

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    
    NSMutableDictionary *change = [NSMutableDictionary new];
    switch(type) {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = @(sectionIndex);
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = @(sectionIndex);
            break;
        case NSFetchedResultsChangeUpdate:
        case NSFetchedResultsChangeMove:
            NSLog(@"Update/move sections for collection view is not implemented yet!");
            break;
    }

    [self.sectionChanges addObject:change];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    NSMutableDictionary *change = [NSMutableDictionary new];
    switch(type) {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = newIndexPath;
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeUpdate:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeMove:
            change[@(type)] = @[indexPath, newIndexPath];
            break;
    }
    [self.objectChanges addObject:change];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self resetFetchedResultControllerChanges];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    if ([self.sectionChanges count]) {
        [self.collectionView performBatchUpdates:^{
            
            for (NSDictionary *change in self.sectionChanges) {
                [change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
                    
                    NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                    switch (type) {
                        case NSFetchedResultsChangeInsert:
                            [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        case NSFetchedResultsChangeDelete:
                            [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        case NSFetchedResultsChangeUpdate:
                            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        case NSFetchedResultsChangeMove:
                        default:
                            break;
                    }
                }];
            }
        } completion:nil];
    }
    
    if ([self.objectChanges count] && ![self.sectionChanges count]) {
        
        if ([self shouldReloadCollectionViewToPreventKnownIssue] || !self.collectionView.window) {
            // This is to prevent a bug in UICollectionView from occurring.
            // The bug presents itself when inserting the first object or deleting the last object in a collection view.
            // http://stackoverflow.com/questions/12611292/uicollectionview-assertion-failure
            // This code should be removed once the bug has been fixed, it is tracked in OpenRadar
            // http://openradar.appspot.com/12954582
            [self reloadCollectionView];
        } else {
            [self insertChangesIntoCollectionView];
        }
    }
}

- (void)insertChangesIntoCollectionView {
    __weak typeof(self) weakself = self;
    [self.collectionView performBatchUpdates:^{
        for (NSDictionary *change in weakself.objectChanges) {
            NSArray *allKeys = [change allKeys];
            for (NSNumber *key in allKeys) {
                id obj = change[key];
                NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                switch (type) {
                    case NSFetchedResultsChangeInsert:
                        [weakself.collectionView insertItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeDelete:
                        [weakself.collectionView deleteItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeUpdate:
                        [weakself.collectionView reloadItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeMove:
                        [weakself.collectionView moveItemAtIndexPath:obj[0] toIndexPath:obj[1]];
                        break;
                }
            }
        }
    } completion:^(BOOL finished) {
        [weakself resetFetchedResultControllerChanges];
    }];
}

- (BOOL)shouldReloadCollectionViewToPreventKnownIssue {
    __block BOOL shouldReload = NO;
    for (NSDictionary *change in self.objectChanges) {
        [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSFetchedResultsChangeType type = [key unsignedIntegerValue];
            NSIndexPath *indexPath = obj;
            switch (type) {
                case NSFetchedResultsChangeInsert:
                    if ([self.collectionView numberOfItemsInSection:indexPath.section] == 0) {
                        shouldReload = YES;
                    } else {
                        shouldReload = NO;
                    }
                    break;
                case NSFetchedResultsChangeDelete:
                    if ([self.collectionView numberOfItemsInSection:indexPath.section] == 1) {
                        shouldReload = YES;
                    } else {
                        shouldReload = NO;
                    }
                    break;
                case NSFetchedResultsChangeUpdate:
                    shouldReload = NO;
                    break;
                case NSFetchedResultsChangeMove:
                    shouldReload = NO;
                    break;
            }
        }];
    }

    return shouldReload;
}

- (void)resetFetchedResultControllerChanges {
    [self.objectChanges removeAllObjects];
    [self.sectionChanges removeAllObjects];
}

- (void)reloadCollectionView {
    [NSFetchedResultsController deleteCacheWithName:self.fetchedResultsController.cacheName];
    [self resetFetchedResultControllerChanges];
    [self.collectionView reloadData];
}

@end
