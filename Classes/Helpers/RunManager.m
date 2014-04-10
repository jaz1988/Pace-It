//
//  RunManager.m
//  Pace It
//
//  Created by SCB on 6/4/14.
//  Copyright (c) 2014 UsefulApps. All rights reserved.
//

#import "RunManager.h"

@implementation RunManager
@synthesize distances;

- (id) init {
    self = [super init];
    if (self) {
        self.distances = [[NSMutableArray alloc] init];
        self.locations = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)updateDistances:(CLLocation *)location {
    //if no location is captured, dont save!!!
    if(!location)
        return;
    
    if([self.distances count] == 0) {
        //If there are no records yet, from origin
        [self.distances addObject:[NSNumber numberWithDouble:0]];
    }
    else {
        NSLog(@"Calculating distances between: %@",@"Test");
        //Calculate the distance between current location and last saved location
        [self.distances addObject:[NSNumber numberWithDouble:[location distanceFromLocation:self.locations.lastObject]]];
    }
}

- (void)updateLocations:(CLLocation *)location {
    NSLog(@"Location is %@",location);
    
    //Save location only if not null
    if(location)
        [self.locations addObject:location];
}

- (NSNumber*)calculateTotalDistances {
    return [self.distances valueForKeyPath: @"@sum.self"];
}

@end
