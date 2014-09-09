//
//  MyRKObjectRequestOperation.m
//  RestKit Bug Test 101
//
//  Created by Nicholas Merrill on 9/8/14.
//  Copyright (c) 2014 Nick Merrill. All rights reserved.
//

#import "MyRKObjectRequestOperation.h"

@implementation MyRKObjectRequestOperation

// Posts a NotificationCenter notification on success and faiure, otherwise has same functionality as superclass.
- (void)setCompletionBlockWithSuccess:(void (^)(RKObjectRequestOperation *, RKMappingResult *))success failure:(void (^)(RKObjectRequestOperation *, NSError *))failure
{
    [super setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        // Post a notification on success.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"connectionSuccess" object:operation];
        
        if (success) {
            success(operation, mappingResult);
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        // Post a notification on faiure.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"connectionFailure" object:operation];
        
        if (failure) {
            failure(operation, error);
        }
    }];
}

@end
