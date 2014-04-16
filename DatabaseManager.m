//
//  DatabaseManager.m
//  Pace It
//
//  Created by Saran Babu on 16/4/14.
//  Copyright (c) 2014 UsefulApps. All rights reserved.
//

#import "DatabaseManager.h"
@interface DatabaseManager()
    @property (nonatomic,strong) NSManagedObjectContext* context;
@end

@implementation DatabaseManager

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

@end
