//
//  ViewController.m
//  Pace It
//
//  Created by SCB on 15/3/14.
//  Copyright (c) 2014 UsefulApps. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textArea;

@end

@implementation RootViewController {
    RunManager *runManager;
}

#pragma mark
#pragma mark IBAction

- (IBAction)start:(id)sender {
    NSLog(@"Started");
    //Start timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                                  target:self
                                                selector:@selector(startSaving)
                                                userInfo:nil
                                                 repeats:YES];
    
    //Start it immediately without waiting for the time interval to capture first location (origin)
    [self.timer fire];
}

- (IBAction)stop:(id)sender {
    NSLog(@"Stopped");
    //stop location manager
    [[LocationManager locationManager] stopUpdates];
    
    //stop timer
    [self.timer invalidate];
    
    //Calculate the total distance
    NSNumber* sum = [runManager calculateTotalDistances];
    
    //Print out the sum
    self.textArea.text = [self.textArea.text stringByAppendingString:@"Total distance: "];
    self.textArea.text = [self.textArea.text stringByAppendingString:[sum stringValue]];
    self.textArea.text = [self.textArea.text stringByAppendingString:@"\n"];
}

- (IBAction)listLocations:(id)sender {
    NSLog(@"list locations");
    for(CLLocation *location in [runManager locations]) {
        NSLog(@"%@", location.description);
    }
    
    for(NSNumber *distance in [runManager distances]) {
        NSLog(@"%@", distance);
    }
}

#pragma mark
#pragma mark views
- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    //Set delegate at location manager
    [LocationManager locationManager].delegate = self;
    
    //Initialize run manager
    runManager = [[RunManager alloc] init];
    
    //Register saveData to the notification center
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveData) name:SaveDataNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark
#pragma mark protocol implementations

- (void) compareDistances {
    //Compare the current run with the last
    int result = [runManager compareDistance];
    NSLog(@"Compared Distance: %d", result);
}

- (void) updateDistances {
    //Update location and distance
    [self updateData];
    
    //Display the distances
    [self displayDistance];
}

#pragma mark
#pragma mark data control

//This method is invoked every Time Interval according to NSTimer configurations
- (void) startSaving {
    NSLog(@"Timer");
    //Start location manager
    [[LocationManager locationManager] startUpdates];
}


- (void)updateData {
    //Update the distances according to new distance
    [runManager updateDistances:[[LocationManager locationManager] location]];
    
    //Update the locations
    //NOTE: This must be done after the distances have been updated
    [runManager updateLocations:[[LocationManager locationManager] location]];
}

- (void)displayDistance {
    //Display at the text area
    NSNumber *distance  = [[runManager distances] lastObject];
    if(distance){
        NSString *distanceString = [distance stringValue];
        self.textArea.text = [self.textArea.text stringByAppendingString:distanceString];
        self.textArea.text = [self.textArea.text stringByAppendingString:@"\n"];
        [self.textArea scrollRangeToVisible:NSMakeRange([self.textArea.text length],0)];
    }else{
        self.textArea.text = @"Location not available";
    }
}

@end
