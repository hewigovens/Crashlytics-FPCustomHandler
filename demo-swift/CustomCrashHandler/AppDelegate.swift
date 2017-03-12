//
//  AppDelegate.swift
//  CustomCrashHandler
//
//  Created by hewig on 3/12/17.
//  Copyright © 2017 Fourplex Labs. All rights reserved.
//

import UIKit
import Crashlytics
import FPCrashHandler

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CrashlyticsDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        Crashlytics.start(withAPIKey: "", delegate: self)
        FPCrashHandler.setupCustomExceptionHandler { exception in
            NSLog("==> CustomNSExceptionCrashHandler called\n")
        }

        FPCrashHandler.setupCustomSignal { (status, info, context) in
            NSLog("==> CustomSignalCrashHandler called\n");
        }
        return true
    }

    func crashlyticsDidDetectReport(forLastExecution report: CLSReport) {
        NSLog("==> app crashed at \(report.crashedOnDate)")
    }
}
