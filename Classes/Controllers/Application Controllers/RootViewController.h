//
//  ViewController.h
//  Pace It
//
//  Created by SCB on 15/3/14.
//  Copyright (c) 2014 UsefulApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationManager.h"
#import "RunManager.h"
#import "StringConstants.h"

@interface RootViewController : UIViewController <DistanceDelegate>

@property (strong, nonatomic) NSTimer *timer;

@end
