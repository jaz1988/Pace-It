//
//  ViewController.m
//  Pace It
//
//  Created by SCB on 15/3/14.
//  Copyright (c) 2014 UsefulApps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textArea;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    //Init location manager
	self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.location = [[CLLocation alloc] init];
    
    //Location manager settings
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
//    self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)start:(id)sender {
    NSLog(@"Started");
    //Init locations array
    self.locations = [[NSMutableArray alloc] init];
    
    //Init distances array
    self.distances = [[NSMutableArray alloc] init];
    
    //Start timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:30.0
                                     target:self
                                   selector:@selector(startSaving)
                                   userInfo:nil
                                    repeats:YES];
    
    //Start it immediately without waiting for the time interval to capture first location (origin)
    [self.timer fire];
}

- (void) startSaving {
    NSLog(@"Timer");
    //Start location manager
    [self.locationManager startUpdatingLocation];
}

- (IBAction)stop:(id)sender {
    NSLog(@"Stopped");
    //stop location manager
    [self.locationManager stopUpdatingLocation];
    
    //stop timer
    [self.timer invalidate];
    
}

- (IBAction)listLocations:(id)sender {
     NSLog(@"list locations");
    for(CLLocation *location in self.locations) {
        NSLog(@"%@", location.description);
    }
    
    for(NSNumber *distance in self.distances) {
        NSLog(@"%@", distance);
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
     NSLog(@"location received");
    
    //Get the latest location
    self.location = locations.lastObject;
    
    //Update the distances according to new distance
    [self updateDistances:self.location];
    
    //Update the locations
    //NOTE: This must be done after the distances have been updated
    [self updateLocations:self.location];
    
    //stop location manager
    [self.locationManager stopUpdatingLocation];
    
    //Display at the text area
    NSNumber *distance  = self.distances.lastObject;
    NSString *distanceString = [distance stringValue];
    self.textArea.text = [self.textArea.text stringByAppendingString:distanceString];
    self.textArea.text = [self.textArea.text stringByAppendingString:@"\n"];
    [self.textArea scrollRangeToVisible:NSMakeRange([self.textArea.text length], 0)];
}

- (void)updateDistances:(CLLocation *)location {
    if([self.distances count] == 0) {
        //If there are no records yet, from origin
        [self.distances addObject:[NSNumber numberWithDouble:0]];
    }
    else {
        //Calculate the distance between current location and last saved location
        [self.distances addObject:[NSNumber numberWithDouble:[location distanceFromLocation:self.locations.lastObject]]];
    }
}

- (void)updateLocations:(CLLocation *)location {
    [self.locations addObject:location];
}

@end
