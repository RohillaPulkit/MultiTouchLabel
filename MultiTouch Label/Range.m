//
//  Range.m
//  MultiTouch Label
//
//  Created by Pulkit Rohilla on 04/03/15.
//  Copyright (c) 2015 PulkitRohilla. All rights reserved.
//

#import "Range.h"

@implementation Range

- (id)initRangeWithLowerValue:(NSNumber *)lowerValue andUpperValue:(NSNumber *)upperValue{
    
    if(self == [super init])
    {
        [self setLowerValue:lowerValue];
        [self setUpperValue:upperValue];
    }
    
    return self;
}


@end
