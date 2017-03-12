//
//  AppDelegate.m
//  CustomCrashHandler
//
//  Created by hewig on 6/30/14.
//  Copyright (c) 2014 fourplex. All rights reserved.
//

#import "AppDelegate.h"
#import <Crashlytics/Crashlytics.h>
#import "FPCrashHandler.h"
#import "ViewController.h"

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
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    [self.window makeKeyAndVisible];
    
    [Crashlytics startWithAPIKey:@"" delegate:self];
    [FPCrashHandler setupCustomExceptionHandler:&CustomNSExceptionCrashHandler];
    [FPCrashHandler setupCustomSignalHandler:&CustomSignalCrashHandler];

    return YES;
}

- (void)crashlyticsDidDetectReportForLastExecution:(CLSReport *)report
{
    NSLog(@"==> App crashed at :%@", report.crashedOnDate);
}

@end
