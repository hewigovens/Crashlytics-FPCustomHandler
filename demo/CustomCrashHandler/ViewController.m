//
//  ViewController.m
//  CustomCrashHandler
//
//  Created by hewig on 6/30/14.
//  Copyright (c) 2014 4plex. All rights reserved.
//

#import "ViewController.h"
#import <Crashlytics/Crashlytics.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)crashButtonTouched:(id)sender
{
    //NSString* a = nil;
    //NSArray* array = @[a];
    //[[Crashlytics sharedInstance] crash];
    abort();
}

- (IBAction)exitButtonTouched:(id)sender
{
    [[[UIApplication sharedApplication] delegate] applicationWillTerminate:[UIApplication sharedApplication]];
    exit(0);
}

@end
