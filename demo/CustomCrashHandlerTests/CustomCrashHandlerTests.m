//
//  CustomCrashHandlerTests.m
//  CustomCrashHandlerTests
//
//  Created by hewig on 3/11/17.
//  Copyright © 2017 4plex. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Crashlytics/Crashlytics.h>

@interface CustomCrashHandlerTests : XCTestCase

@end

@implementation CustomCrashHandlerTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSignals
{
    SEL seletor = NSSelectorFromString(@"_iterateSignals");
    if ([[Crashlytics sharedInstance] respondsToSelector:seletor]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [[Crashlytics sharedInstance] performSelector:seletor];
#pragma clang diagnostic pop
    }
}

@end
