## Crashlytics+FPCustomHandler

FPCustomHandler is a category for [Crashlytics](www.crashlytics.com) to allow you run custom `NSUncaughtExceptionHandler` or `signal` handler when crash happened.

## Warning

FPCustomHandler relies on the underlying implementation details of Crashlytics(version 2.2.1(35)), These may changed in future Crashlytics releases. At your own risk to use it.

When you implement your custom handlers, please do take [Async-Safe Functions](https://www.plcrashreporter.org/documentation/api/v1.2/async_safety.html) into considerations.

## Example


```objc

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[Crashlytics startWithAPIKey:@"YOUR_API_KEY" delegate:self];
	
	//These category methods should be called after start Crashlytics
    [[Crashlytics sharedInstance] setupCustomExceptionHandler:&CustomNSExceptionCrashHandler];
    [[Crashlytics sharedInstance] setupCustomSignalHandler:&CustomSignalCrashHandler];
    
    return YES;
}
```

```objc

static void CustomNSExceptionCrashHandler(NSException *exception)
{
    NSLog(@"==========> CustomNSExceptionCrashHandler called\n");
}

static void CustomSignalCrashHandler(int signo, siginfo_t *info, void *context)
{
    NSLog(@"==========> CustomSignalCrashHandler called\n");
}

```

### Trigger a crash

```objc

	//SIGABRT
	abort();
	
	//NSInvalidArgumentException
	NSString* str = nil;
	NSArray* array = @[str];
```

## Reference

* [Can I use a custom Exception Handler?](http://support.crashlytics.com/knowledgebase/articles/222764-can-i-use-a-custom-exception-handler)

## License

MIT
