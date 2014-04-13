//
//  LocationManager.h
//  Pace It
//
//  Created by SCB on 6/4/14.
//  Copyright (c) 2014 UsefulApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "StringConstants.h"
#import "DistanceDelegate.h"

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property (assign) id<DistanceDelegate> delegate;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) NSDate *locationManagerStartDate;
@property (strong, nonatomic) CLLocation *location;

+ (LocationManager*)locationManager;
- (void) startUpdates;
- (void) stopUpdates;

@end
