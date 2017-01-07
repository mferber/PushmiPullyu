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
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        DDLogError("APP EVENT: willResignActive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        DDLogError("APP EVENT: didEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        DDLogError("APP EVENT: willEnterBackground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        DDLogError("APP EVENT: didBecomeActive")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        DDLogError("APP EVENT: willTerminate")
    }

}

