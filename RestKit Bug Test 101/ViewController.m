//
//  ViewController.m
//  RestKit Bug Test 101
//
//  Created by Nicholas Merrill on 9/8/14.
//  Copyright (c) 2014 Nick Merrill. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register notification receiver for failures and successes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveSuccessfulRequestNotification:) name:@"connectionSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveFailedRequestNotification:) name:@"connectionFailure" object:nil];
}

- (void)alertWithMessage:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)didReceiveSuccessfulRequestNotification:(NSNotification *)notification {
    RKObjectRequestOperation *operation = (RKObjectRequestOperation *)notification.userInfo;
    [self alertWithMessage:[NSString stringWithFormat:@"success: %@", operation]];
}

- (void)didReceiveFailedRequestNotification:(NSNotification *)notification {
    RKObjectRequestOperation *operation = (RKObjectRequestOperation *)notification.userInfo;
    [self alertWithMessage:[NSString stringWithFormat:@"failure: %@", operation]];
}


- (IBAction)publicResourceRequested:(id)sender {
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/gists/public" parameters:nil success:nil failure:nil];
}

- (IBAction)privateResourceRequested:(id)sender {
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/gists/starred" parameters:nil success:nil failure:nil];
}

@end
