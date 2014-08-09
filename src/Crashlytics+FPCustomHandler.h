//
//  Crashlytics+FPCustomHandler.h
//  CustomCrashHandler
//
//  Created by hewig on 6/30/14.
//  Copyright (c) 2014 4plex. All rights reserved.
//

#import <Crashlytics/Crashlytics.h>

typedef void (*FPCustomSignalHandler)(int signo, siginfo_t *info, void *context);

@interface Crashlytics (FPCustomHandler)

/**
 *  Check if last session was crashed
 *
 *  @return NO if not crashed
 */
-(BOOL)isLastSessionCrashed;

/**
 *  Allow you to run custome exception handler before Crashlytics' handler
 *
 *  @param exceptionHandler, custome NSUncaughtExceptionHandler
 */
-(void)setupCustomExceptionHandler:(NSUncaughtExceptionHandler*)exceptionHandler;

/**
 *  Allow you to run custome signal handler before Crashlytics' handler
 *
 *  @param customHandler custome signal handler
 */
-(void)setupCustomSignalHandler:(FPCustomSignalHandler)customHandler;

@end
