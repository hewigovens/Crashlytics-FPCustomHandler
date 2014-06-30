## Crashlytics+FPCustomHandler

FPCustomHandler is a category for Crashlytics to allow you run custom `NSUncaughtExceptionHandler` or `signal handler` when crash happend.

## Example


```

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[Crashlytics startWithAPIKey:@"YOUR_API_KEY" delegate:self];
    [[Crashlytics sharedInstance] setupCustomExceptionHandler:&CustomNSExceptionCrashHandler];
    [[Crashlytics sharedInstance] setupCustomSignalHandler:NULL];
    
    return YES;
}
```

```

static void CustomNSExceptionCrashHandler(NSException *exception)
{
    NSLog(@"==========> CustomNSExceptionCrashHandler called\n");
}

```

