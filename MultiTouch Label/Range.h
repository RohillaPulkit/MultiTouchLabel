//
//  Range.h
//  MultiTouch Label
//
//  Created by Pulkit Rohilla on 04/03/15.
//  Copyright (c) 2015 PulkitRohilla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Range : NSObject

- (id)initRangeWithLowerValue:(NSNumber *)lowerValue andUpperValue:(NSNumber *)upperValue;

@property (strong,nonatomic) NSNumber *lowerValue;
@property (strong,nonatomic) NSNumber *UpperValue;

@end
