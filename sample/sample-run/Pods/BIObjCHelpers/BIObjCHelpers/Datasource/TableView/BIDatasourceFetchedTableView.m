//
//  BIDatasourceFetchedTableView.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/12/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceFetchedTableView.h"

@implementation BIDatasourceFetchedTableView


#pragma mark - BIDatasourceBase methods

- (void)load {
    [super load];
    NSParameterAssert(self.fetchedResultsController);
}

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

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSParameterAssert(self.fetchedResultsController);
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSParameterAssert(self.fetchedResultsController);
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

#pragma mark - NSFetchedResultsControllerDelegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections: [NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation: UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections: [NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation: UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch(type) {
            // Data was inserted -- insert the data into the table view
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            // Data was deleted -- delete the data from the table view
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            break;
            // Data was updated (changed) -- reconfigure the cell for the data
        case NSFetchedResultsChangeUpdate:
            
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath: indexPath];
            break;
            // Data was moved -- delete the data from the old location and insert the data into the new location
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            
            NSArray *insertPaths = @[newIndexPath];
            
            [self.tableView insertRowsAtIndexPaths:insertPaths withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

@end
