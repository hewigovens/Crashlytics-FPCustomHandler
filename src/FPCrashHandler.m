//
//  Crashlytics+FPCustomHandler.m
//  CustomCrashHandler
//
//  Created by hewig on 6/30/14.
//  Copyright (c) 2014 fourplex. All rights reserved.
//

#import "FPCrashHandler.h"
#import <sys/signal.h>
#import <sys/syslog.h>
#import <stdlib.h>

#define FPLog(__FORMAT__, ...) syslog(LOG_WARNING, ("%s line %d $ " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#pragma mark - NSUncaughtExceptionHandler

static NSUncaughtExceptionHandler* customExceptionHandler = NULL;
static NSUncaughtExceptionHandler* crashlyticsExceptionHandler = NULL;

static void fpCustomExceptionHandler(NSException* exception)
{
    FPLog("==> handle exception:%s", [exception.name UTF8String]);
    if (customExceptionHandler) {
        FPLog("==> call custom exception handler");
        customExceptionHandler(exception);
    }
    if (crashlyticsExceptionHandler) {
        FPLog("==> call crashlytics exception handler");
        crashlyticsExceptionHandler(exception);
    }
}

#pragma mark - signals

/* seems crashlytics only handle these signals? */
static int fp_signals[] =
{
    SIGILL  ,   /* illegal instruction (not reset when caught) */
    SIGTRAP ,   /* trace trap (not reset when caught) */
    SIGABRT ,   /* abort() */
    SIGFPE  ,   /* floating point exception */
    SIGBUS  ,   /* bus error */
    SIGSEGV ,   /* segmentation violation */
    SIGSYS  ,   /* bad argument to system call */
};

static FPCustomSignalHandler custom_signal_handler = NULL;
static FPCustomSignalHandler crashlytics_signal_handler = NULL;

static void fp_signal_handler(int signo, siginfo_t *info, void *context)
{
    FPLog("==> handle signal:%d", signo);
    if (custom_signal_handler) {
        FPLog("==> call custom signal handler");
        custom_signal_handler(signo, info, context);
    }
    if (crashlytics_signal_handler) {
        FPLog("==> call crashlytics signal handler");
        crashlytics_signal_handler(signo, info, context);
    }
}

#pragma mark - FPCrashHandler

@implementation FPCrashHandler

+(void)setupCustomExceptionHandler:(NSUncaughtExceptionHandler *)exceptionHandler
{
    crashlyticsExceptionHandler = NSGetUncaughtExceptionHandler();
    customExceptionHandler = exceptionHandler;
    NSSetUncaughtExceptionHandler(&fpCustomExceptionHandler);
}

+(void)setupCustomSignalHandler:(FPCustomSignalHandler)customHandler
{
    custom_signal_handler = customHandler;
    
    struct sigaction sa;
    struct sigaction old_sa;
    
    /* seems all the signal handler is same, u can test with method [self _iterateSignals]*/
    sigaction(SIGABRT, NULL, &old_sa);
    if (old_sa.sa_flags & SA_SIGINFO) {
        crashlytics_signal_handler = old_sa.sa_sigaction;
    }
    
    memset(&sa, 0, sizeof(sa));
    sa.sa_flags = SA_SIGINFO|SA_ONSTACK;
    sigemptyset(&sa.sa_mask);
    sa.sa_sigaction = fp_signal_handler;
    
    int count = sizeof(fp_signals)/sizeof(int);
    for (int i = 0 ; i < count; i++) {
        if (sigaction(fp_signals[i], &sa, NULL) != 0) {
            FPLog("==> fail to register custom signal handler");
        }
    }
}

#if TARGET_OS_IPHONE
+(UIAlertController *)debugOptionsAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Debug options for testing FPCrashHandler" preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"Simulate ObjcC Exception" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSString* a = nil;
        NSArray* array = @[a];
#pragma unused (array)
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"Call abort()" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        abort();
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"Call exit()" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[[UIApplication sharedApplication] delegate] applicationWillTerminate:[UIApplication sharedApplication]];
        exit(0);
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    return alert;
}
#endif

+(void)_iterateSignals
{
    struct sigaction old_sa;
    
    int count = sizeof(fp_signals)/sizeof(int);
    void *handler = NULL;
    for (int i = 0 ; i < count; i++) {
        sigaction(fp_signals[i], NULL, &old_sa);
        if (old_sa.sa_flags & SA_SIGINFO) {
            if (handler == NULL) {
                handler = old_sa.sa_sigaction;
            } else {
                if (handler != old_sa.sa_sigaction) {
                    /* different signal handler detected abort...*/
                    FPLog("==> different signal handler detected. This category may not work any more");
                    abort();
                }
            }
            FPLog("==> signal :%d sigaction flags is : %d, sigaction handler is :%p", fp_signals[i], old_sa.sa_flags, old_sa.sa_sigaction);
        }
    }
}

@end
