//
//  BIScrollAdditionalErrorNoContentView.m
//  BIObjCHelpers
//
//  Created by Bogdan Iusco on 18/01/16.
//  Copyright © 2016 iGama Apps. All rights reserved.
//

#import "BIScrollAdditionalErrorNoContentView.h"

@interface BIScrollAdditionalErrorNoContentView ()

@property (nonatomic, assign, readwrite) BITableAdditionalTypeView type;

@end


@implementation BIScrollAdditionalErrorNoContentView

@synthesize type = _type;

#pragma mark - BIScrollAdditionalViewBase methods

- (void)commonSetup {
    [super commonSetup];
    self.type = BITableAdditionalTypeErrorNoContentView;
}

@end
