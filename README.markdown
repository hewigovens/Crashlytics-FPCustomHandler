## Crashlytics+FPCustomHandler

FPCustomHandler is a category for Crashlytics to allow you run custom `NSUncaughtExceptionHandler` or `signal handler` when crash happend.

## Example


```objc

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[Crashlytics startWithAPIKey:@"YOUR_API_KEY" delegate:self];
    [[Crashlytics sharedInstance] setupCustomExceptionHandler:&CustomNSExceptionCrashHandler];
    [[Crashlytics sharedInstance] setupCustomSignalHandler:NULL];
    
    return YES;
}
```

```objc

static void CustomNSExceptionCrashHandler(NSException *exception)
{
    NSLog(@"==========> CustomNSExceptionCrashHandler called\n");
}

```

