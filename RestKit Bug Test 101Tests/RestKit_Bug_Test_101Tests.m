//
//  RestKit_Bug_Test_101Tests.m
//  RestKit Bug Test 101Tests
//
//  Created by Nicholas Merrill on 9/8/14.
//  Copyright (c) 2014 Nick Merrill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface RestKit_Bug_Test_101Tests : XCTestCase

@end

@implementation RestKit_Bug_Test_101Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
