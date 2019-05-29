//
//  BIOperationQueue.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/2/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BIOperationQueueFinishedCallback)(void);

@interface BIOperationQueue : NSOperationQueue

@property (nonatomic, copy) BIOperationQueueFinishedCallback finishedCallback;

@end
