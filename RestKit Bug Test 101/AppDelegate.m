//
//  AppDelegate.m
//  RestKit Bug Test 101
//
//  Created by Nicholas Merrill on 9/8/14.
//  Copyright (c) 2014 Nick Merrill. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import "MyRKObjectRequestOperation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSError *error = nil;
    NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"BugTest" ofType:@"momd"]];
    NSManagedObjectModel *managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    // Initialize the Core Data stack
    [managedObjectStore createPersistentStoreCoordinator];
    
    NSPersistentStore __unused *persistentStore = [managedObjectStore addInMemoryPersistentStore:&error];
    NSAssert(persistentStore, @"Failed to add persistent store: %@", error);
    
    [managedObjectStore createManagedObjectContexts];
    
    // Set the default store shared instance
    [RKManagedObjectStore setDefaultStore:managedObjectStore];
    
    // Configure the object manager
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"https://api.github.com"]];
    objectManager.managedObjectStore = managedObjectStore;
    
    /// ******* Register my custom operation class ********* ///
    [objectManager registerRequestOperationClass:[MyRKObjectRequestOperation class]];
    
    [RKObjectManager setSharedManager:objectManager];
    
    RKEntityMapping *entityMapping = [RKEntityMapping mappingForEntityForName:@"Gist" inManagedObjectStore:managedObjectStore];
    [entityMapping addAttributeMappingsFromDictionary:@{
                                                        @"id":             @"gistID",
                                                        @"url":            @"jsonURL",
                                                        @"description":    @"descriptionText",
                                                        @"public":         @"public",
                                                        @"created_at":     @"createdAt"}];
    entityMapping.identificationAttributes = @[ @"gistID" ];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:entityMapping method:RKRequestMethodGET pathPattern:@"/gists/:modifier" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    // Override point for customization after application launch.
//    ViewController *controller = (ViewController *)self.window.rootViewController;
//    controller.managedObjectContext = managedObjectStore.mainQueueManagedObjectContext;
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
