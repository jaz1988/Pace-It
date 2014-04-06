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

static RunManager *globalRunManager = nil;

+ (RunManager*)runManager
{
	if(!globalRunManager) {
		globalRunManager = [[RunManager alloc] init];
    }
    
    
	return globalRunManager;
}

- (void)updateDistances:(CLLocation *)location {
    
    if(!self.distances) {
        self.distances = [[NSMutableArray alloc] init];
    }
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
    
    if(!self.locations) {
        self.locations = [[NSMutableArray alloc] init];
    }
    
    [self.locations addObject:location];
}

- (NSNumber*)calculateTotalDistances {
    return [self.distances valueForKeyPath: @"@sum.self"];
}

@end
