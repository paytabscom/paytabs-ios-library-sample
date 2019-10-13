//
//  NSBundle+BIExtra.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 18/06/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "NSBundle+BIExtra.h"

@implementation NSBundle (BIExtra)

- (nullable NSString *)fullPathForFilename:(nonnull NSString *)filename {
    NSString *fileType = [filename pathExtension];
    NSString *filenameWithoutExtension = [filename stringByDeletingPathExtension];
    return [self pathForResource:filenameWithoutExtension ofType:fileType];
}

@end
