//
//  AppDelegate.m
//  CustomCrashHandler
//
//  Created by hewig on 6/30/14.
//  Copyright (c) 2014 4plex. All rights reserved.
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
    
    if ([[Crashlytics sharedInstance] isLastSessionCrashed]) {
        NSLog(@"==> last session crashed");
    }
    
    return YES;
}

- (void)crashlytics:(Crashlytics *)crashlytics didDetectCrashDuringPreviousExecution:(id <CLSCrashReport>)crash
{
    NSLog(@"==> App crashed at :%@", crash.crashedOnDate);
}

@end
