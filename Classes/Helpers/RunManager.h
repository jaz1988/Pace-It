//
//  RunManager.h
//  Pace It
//
//  Created by SCB on 6/4/14.
//  Copyright (c) 2014 UsefulApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationManager.h"

@interface RunManager : NSObject

@property (strong, nonatomic) NSDate *startTime;
@property (strong, nonatomic) NSDate *endTime;
@property (strong, nonatomic) NSMutableArray *locations;
@property (strong, nonatomic) NSMutableArray *distances;

+ (RunManager*)runManager;
- (void)updateDistances:(CLLocation *)location;
- (void)updateLocations:(CLLocation *)location;
- (NSNumber*)calculateTotalDistances;

@end
