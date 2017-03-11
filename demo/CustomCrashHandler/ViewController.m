//
//  ViewController.m
//  CustomCrashHandler
//
//  Created by hewig on 6/30/14.
//  Copyright (c) 2014 fourplex. All rights reserved.
//

#import "ViewController.h"
#import <Crashlytics/Crashlytics.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)crashButtonTouched:(id)sender
{
//    NSString* a = nil;
//    NSArray* array = @[a];
//    [[Crashlytics sharedInstance] crash];
    abort();
}

- (IBAction)exitButtonTouched:(id)sender
{
    [[[UIApplication sharedApplication] delegate] applicationWillTerminate:[UIApplication sharedApplication]];
    exit(0);
}

@end
