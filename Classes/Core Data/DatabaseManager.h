//
//  DatabaseManager.h
//  Pace It
//
//  Created by Saran Babu on 16/4/14.
//  Copyright (c) 2014 UsefulApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface DatabaseManager : NSObject

- (void)saveUserSession:(NSDictionary*) sessionDictionary;

@end
