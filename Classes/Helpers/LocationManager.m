//
//  LocationManager.m
//  Pace It
//
//  Created by SCB on 6/4/14.
//  Copyright (c) 2014 UsefulApps. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

static LocationManager *globalLocationManager = nil;

+ (LocationManager*)locationManager
{
	if(!globalLocationManager)
		globalLocationManager = [[LocationManager alloc] init];
    
	return globalLocationManager;
}

- (void) stopUpdates
{
	if (self.locationManager)
	{
		[self.locationManager stopUpdatingLocation];
	}
}

- (void) startUpdates
{
    
    if ([self locationServicesEnabled]) {
        
        if (self.locationManager)
        {
            [self.locationManager stopUpdatingLocation];
        }
        else
        {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
//            locationManager.distanceFilter = 1;            
//            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        }
        [self.locationManager startUpdatingLocation];
        
        self.locationManagerStartDate = [NSDate date];
        
    }
    else
    {
        NSLog(@"Location not enabled");
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"SHOWLOCATIONALERT" object:nil];
    }
}

- (BOOL) locationServicesEnabled
{
	return ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied);
}

#pragma mark
#pragma mark core location delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"location received");
    //Get the latest location
    self.location = locations.lastObject;
    
    //Stop the update
    [self stopUpdates];
}

@end
