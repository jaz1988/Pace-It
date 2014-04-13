//
//  DistanceDelegate.h
//  Pace It
//
//  Created by SCB on 13/4/14.
//  Copyright (c) 2014 UsefulApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DistanceDelegate <NSObject>

- (void) compareDistances;
- (void) updateDistances;

@end
