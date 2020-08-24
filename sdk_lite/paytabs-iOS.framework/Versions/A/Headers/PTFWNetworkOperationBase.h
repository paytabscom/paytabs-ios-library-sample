//
//  PTFWNetworkOperationBase.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/8/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTFWNetworkOperationBase : NSOperation

@property (nonatomic, strong, nullable, readonly) NSURLSessionDataTask *networkTask;

@property (nonatomic, assign, readonly) BOOL isExecuting;
@property (nonatomic, assign, readonly) BOOL isFinished;

@property (nonatomic, copy, nullable) void(^didFinishWithErrorCallback)(NSError *__nonnull error);
@property (nonatomic, copy, nullable) void(^didFinishSuccessfullyCallback)(id __nonnull responseObject);

- (void)finish;
@end
