//
//  Crashlytics+FPCustomHandler.h
//  CustomCrashHandler
//
//  Created by hewig on 6/30/14.
//  Copyright (c) 2014 fourplex. All rights reserved.
//

typedef void (*FPCustomSignalHandler)(int signo, siginfo_t * _Nullable info, void * _Nullable context);

@interface FPCrashHandler: NSObject

/**
 *  Allow you to run custome exception handler before Crashlytics' handler
 *
 *  @param exceptionHandler, custome NSUncaughtExceptionHandler
 */
+(void)setupCustomExceptionHandler:(nonnull NSUncaughtExceptionHandler*)exceptionHandler;

/**
 *  Allow you to run custome signal handler before Crashlytics' handler
 *
 *  @param customHandler custome signal handler
 */
+(void)setupCustomSignalHandler:(nonnull FPCustomSignalHandler)customHandler;


#if TARGET_OS_IPHONE
/**
 *  Return a debug options alert controller
 */
+(nonnull UIAlertController *)debugOptionsAlert;
#endif

@end
