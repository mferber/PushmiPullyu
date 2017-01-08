//
//  AppDelegate.swift
//  PushmiPullyu
//
//  Created by Matthias Ferber on 1/6/17.
//  Copyright © 2017 Cantina. All rights reserved.
//

import UIKit

import CocoaLumberjackSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let loggerManager: LoggerManager = LoggerManager()

    
    // MARK: - Lifecycle
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        NSLog("Application logs are in \(FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask))")
        DDLogError("APP EVENT: didFinishLaunchingWithOptions")
        
        self.initiatePushRegistration(application: application)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        DDLogError("APP EVENT: willResignActive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        DDLogError("APP EVENT: didEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        DDLogError("APP EVENT: willEnterForeground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        DDLogError("APP EVENT: didBecomeActive")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        DDLogError("APP EVENT: willTerminate")
    }
    
    
    // MARK: - Push registration
    
    
    func initiatePushRegistration(application: UIApplication) {
        let settings = UIUserNotificationSettings(types: [.alert], categories: nil)
        application.registerUserNotificationSettings(settings)
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenAsHexString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        DDLogInfo("***** COPY THIS APNs DEVICE TOKEN: \(tokenAsHexString)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("Push notification error:\n\nFailed to register for remote notifications: \(error.localizedDescription)\n\n")
    }
    
}

