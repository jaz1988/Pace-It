//
//  DatabaseManager.m
//  Pace It
//
//  Created by Saran Babu on 16/4/14.
//  Copyright (c) 2014 UsefulApps. All rights reserved.
//

#import "DatabaseManager.h"
#import "UserSession.h"
#import "SessionDetails.h"

@interface DatabaseManager()
    @property (nonatomic,strong) NSManagedObjectContext* context;
@end

@implementation DatabaseManager

@synthesize context;
static DatabaseManager* globalDatabaseManager;

- (id) init{
    self= [super init];
    if(!self.context){
        [self initContext];
    }
    return self;
}

+ (DatabaseManager*) databaseManager{
    if(!globalDatabaseManager){
        globalDatabaseManager = [[DatabaseManager alloc] init];
    }
    return globalDatabaseManager;
}

- (void) initContext{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSURL* documentsDirectory = [[fileManager URLsForDirectory:NSDocumentationDirectory inDomains:NSUserDomainMask] firstObject];
    NSString* documentName = @"paceitDocument";
    NSURL* url = [documentsDirectory URLByAppendingPathComponent:documentName];
    UIManagedDocument* document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        [document openWithCompletionHandler: ^(BOOL success){
            if (success) {
                if([document documentState] == UIDocumentStateNormal){
                    self.context = document.managedObjectContext;
                }
            }else{
                NSLog(@"Couldnt open core data document");
            }
        }];
    }else{
        [document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                if([document documentState] == UIDocumentStateNormal){
                    self.context = document.managedObjectContext;
                }
            }else{
                NSLog(@"Couldnt create document");
            }
        }];
    }
}

- (void)saveSession:(NSDictionary*) sessionDictionary{
    NSArray* locations = [sessionDictionary objectForKey:@"Locations"];
    NSArray* distances = [sessionDictionary objectForKey:@"Distances"];
    NSDate* startDate = [sessionDictionary objectForKey:@"StartDate"];
    NSDate* endDate = [sessionDictionary objectForKey:@"SndDate"];
    NSNumber* totalDistance = [sessionDictionary objectForKey:@"TotalDistance"];
    NSNumber* averageSpeed = [sessionDictionary objectForKey:@"AverageSpeed"];
    
    UserSession *userSession = [NSEntityDescription
                                      insertNewObjectForEntityForName:@"UserSession"
                                      inManagedObjectContext:self.context];
    [userSession setValue:startDate forKey:@"startDate"];
    [userSession setValue:endDate forKey:@"endDate"];
    [userSession setValue:totalDistance forKey:@"totalDistance"];
    [userSession setValue:averageSpeed forKey:@"averageSpeed"];

    
    for (int i=0; i<locations.count; i++) {
        CLLocation* location = (CLLocation*) locations[i];
        double latitude = (double)location.coordinate.latitude;
        double longitude = (double)location.coordinate.longitude;

        SessionDetails *sessionDetails = [NSEntityDescription
                                          insertNewObjectForEntityForName:@"SessionDetails"
                                          inManagedObjectContext:self.context];
        [sessionDetails setValue:[NSNumber numberWithDouble:latitude] forKey:@"latitude"];
        [sessionDetails setValue:[NSNumber numberWithDouble:longitude] forKey:@"longitude"];

        [sessionDetails setValue:distances[i] forKey:@"distance"];
        [sessionDetails setValue:startDate forKey:@"startDate"];
    }
    
}

- (void)saveSessionDetails:(NSDictionary*) sessionDictionary{
}

- (void)saveUserSession:(NSDictionary *)sessionDictionary{
    
}

@end
