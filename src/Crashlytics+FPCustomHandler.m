//
//  Crashlytics+FPCustomHandler.m
//  CustomCrashHandler
//
//  Created by hewig on 6/30/14.
//  Copyright (c) 2014 4plex. All rights reserved.
//

#import "Crashlytics+FPCustomHandler.h"
#import <sys/signal.h>

#pragma mark - NSUncaughtExceptionHandler

static NSUncaughtExceptionHandler* customExceptionHandler = NULL;
static NSUncaughtExceptionHandler* crashlyticsExceptionHandler = NULL;

static void fpCustomExceptionHandler(NSException* exception)
{
    CLS_LOG("==> handle exception:%@", exception.name);
    if (customExceptionHandler) {
        CLS_LOG("==> call custom exception handler");
        customExceptionHandler(exception);
    }
    if (crashlyticsExceptionHandler) {
        CLS_LOG("==> call crashlytics exception handler");
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
    CLS_LOG("==> handle signal:%d", signo);
    if (custom_signal_handler) {
        CLS_LOG("==> call custom signal handler");
        custom_signal_handler(signo, info, context);
    }
    if (crashlytics_signal_handler) {
        CLS_LOG("==> call crashlytics signal handler");
        crashlytics_signal_handler(signo, info, context);
    }
}

#pragma mark - Crashlytics (FPCustomHandler)

@implementation Crashlytics (FPCustomHandler)

-(BOOL)isLastSessionCrashed
{
    NSNumber* isCrashed = [self valueForKey:@"_lastSessionWasCrash"];
    return [isCrashed boolValue];
}

-(void)setupCustomExceptionHandler:(NSUncaughtExceptionHandler *)exceptionHandler
{
    crashlyticsExceptionHandler = NSGetUncaughtExceptionHandler();
    customExceptionHandler = exceptionHandler;
    NSSetUncaughtExceptionHandler(&fpCustomExceptionHandler);
}

-(void)setupCustomSignalHandler:(FPCustomSignalHandler)customHandler
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
            CLS_LOG("==> fail to register custom signal handler");
        }
    }
}

-(void)_iterateSignals
{
    struct sigaction old_sa;
    
    int count = sizeof(fp_signals)/sizeof(int);
    for (int i = 0 ; i < count; i++) {
        sigaction(fp_signals[i], NULL, &old_sa);
        CLS_LOG("==> signal :%d sigaction flags is : %d ", fp_signals[i], old_sa.sa_flags);
        if (old_sa.sa_flags & SA_SIGINFO) {
            CLS_LOG("==> and sigaction handler is :%p", old_sa.sa_sigaction);
        }
    }
}

@end
