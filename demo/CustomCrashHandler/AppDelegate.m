//
//  AppDelegate.m
//  CustomCrashHandler
//
//  Created by hewig on 6/30/14.
//  Copyright (c) 2014 fourplex. All rights reserved.
//

#import "AppDelegate.h"
#import <Crashlytics/Crashlytics.h>
#import "Crashlytics+FPCustomHandler.h"

@interface AppDelegate()<CrashlyticsDelegate>
@end

static void CustomNSExceptionCrashHandler(NSException *exception)
{
    NSLog(@"==> CustomNSExceptionCrashHandler called\n");
}

static void CustomSignalCrashHandler(int signo, siginfo_t *info, void *context)
{
    NSLog(@"==> CustomSignalCrashHandler called\n");
}

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [Crashlytics startWithAPIKey:@"" delegate:self];
    [[Crashlytics sharedInstance] setupCustomExceptionHandler:&CustomNSExceptionCrashHandler];
    [[Crashlytics sharedInstance] setupCustomSignalHandler:&CustomSignalCrashHandler];

    return YES;
}

- (void)crashlyticsDidDetectReportForLastExecution:(CLSReport *)report
{
    NSLog(@"==> App crashed at :%@", report.crashedOnDate);
}

@end
