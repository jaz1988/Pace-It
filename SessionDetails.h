//
//  SessionDetails.h
//  Pace It
//
//  Created by Saran Babu on 16/4/14.
//  Copyright (c) 2014 UsefulApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UserSession;

@interface SessionDetails : NSManagedObject

@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) UserSession *runSession;

@end
