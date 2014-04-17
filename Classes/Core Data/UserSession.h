//
//  UserSession.h
//  Pace It
//
//  Created by Saran on 17/4/14.
//  Copyright (c) 2014 UsefulApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserSession : NSManagedObject

@property (nonatomic, retain) NSNumber * averageSpeed;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSNumber * totalDistance;
@property (nonatomic, retain) NSDate * endDate;

@end
