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
        
        //Mock data only, should be fetched from database
        self.lastRunDistances = [[NSMutableArray alloc] init];
        [self.lastRunDistances addObject:[NSNumber numberWithDouble:20]];
        [self.lastRunDistances addObject:[NSNumber numberWithDouble:25]];
        [self.lastRunDistances addObject:[NSNumber numberWithDouble:30]];
        [self.lastRunDistances addObject:[NSNumber numberWithDouble:0]];
        [self.lastRunDistances addObject:[NSNumber numberWithDouble:30]];
        [self.lastRunDistances addObject:[NSNumber numberWithDouble:0]];
    }
    return self;
}

/*need to have a method to return distance from the previous location,
so that distance can be saved in database along with location

 - need to have a variable to store last known location
 - distance can be calculated using 
    [currentLocation distanceFromLocation:lastKnownLocation]
 */

- (void)updateDistances:(CLLocation *)location {
    //if no location is captured, dont save!!!
    if(!location)
        return;
    
    //If there are no records yet, from origin
    if([self.distances count] == 0 ) {
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

//Method to compare the distance from previous run and current run
- (int)compareDistance {
    //Since comparing is only done after saving the current run distance, get the count - 1 as the index
    int index = [self.distances count] - 1;
    
    //Previous run distance at current index
    NSNumber *lastDistance = [self.lastRunDistances objectAtIndex:index];
    
    //Compare with the current distance
    if([[self.distances lastObject] doubleValue] < [lastDistance doubleValue]) {
        //current distance lesser than previous -> slower pace
        return 0;
    }
    else {
        //either equal distance of more than previous -> improved or maintained pace
        return 1;
    }
}

@end
