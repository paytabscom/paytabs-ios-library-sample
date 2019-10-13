//
//  BIScrollAdditionalLoadingView.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 18/01/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import "BIScrollAdditionalLoadingView.h"

@interface BIScrollAdditionalLoadingView ()

@property (nonatomic, assign, readwrite) BITableAdditionalTypeView type;

@end


@implementation BIScrollAdditionalLoadingView

@synthesize type = _type;

#pragma mark - BIScrollAdditionalViewBase methods

- (void)commonSetup {
    [super commonSetup];
    self.type = BITableAdditionalTypeLoadingContentView;
}

@end
