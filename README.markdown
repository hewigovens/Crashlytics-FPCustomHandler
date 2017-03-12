## FPCrashHandler

![](https://img.shields.io/cocoapods/v/FPCrashHandler.svg)
![](https://img.shields.io/cocoapods/p/FPCrashHandler.svg)
![](https://img.shields.io/cocoapods/l/FPCrashHandler.svg)

FPCustomHandler is a helper class for [Crashlytics](https://fabric.io/kits/ios/crashlytics) to allow you run custom `NSUncaughtExceptionHandler` or `signal` handler when crash happened.

## Warning

FPCustomHandler relies on the underlying implementation details of Crashlytics(version 3.8.4(121)), These may be changed in future Crashlytics releases. At your own risk to use it.

When you implement your custom handlers, please do take [Async-Safe Functions](https://www.plcrashreporter.org/documentation/api/v1.2/async_safety.html) into considerations.

## Integration

Add pod 'Crashlytics-FPCustomHandler' to your Podfile

```ruby
    pod 'FPCrashHandler'
```

## Example Swift

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    //These methods should be called after start Crashlytics
    FPCrashHandler.setupCustomExceptionHandler { exception in
        NSLog("==> CustomNSExceptionCrashHandler called\n")
    }

    FPCrashHandler.setupCustomSignal { (status, info, context) in
        NSLog("==> CustomSignalCrashHandler called\n");
    }
}
```

## Example ObjC


```objc

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	
	//These methods should be called after start Crashlytics
    [FPCrashHandler setupCustomExceptionHandler:&CustomNSExceptionCrashHandler];
    [FPCrashHandler setupCustomSignalHandler:&CustomSignalCrashHandler];
    return YES;
}
```

```objc

static void CustomNSExceptionCrashHandler(NSException *exception)
{
    NSLog(@"==> CustomNSExceptionCrashHandler called\n");
}

static void CustomSignalCrashHandler(int signo, siginfo_t *info, void *context)
{
    NSLog(@"==> CustomSignalCrashHandler called\n");
}

```

## Trigger a crash

```objc

	//SIGABRT
	abort();
	
	//NSInvalidArgumentException
	NSString* str = nil;
	NSArray* array = @[str];
```

Or just present the `debugOptionsAlert` on `FPCrashHandler`.

You should run the demo app without Xcode's debbuger attached, then you can search the logs with "==>" here: 

`iOS Simulator -> Debug -> Open System Log (or press Cmd + / in iOS Simulator)`

## Reference

* [Can I use a custom Exception Handler?](http://support.crashlytics.com/knowledgebase/articles/222764-can-i-use-a-custom-exception-handler)

## License

MIT
