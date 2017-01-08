//
//  LoggerManager.swift
//  PushmiPullyu
//
//  Created by Matthias Ferber on 1/6/17.
//  Copyright © 2017 Cantina. All rights reserved.
//

import CocoaLumberjackSwift

class LoggerManager {
    var mainLogger: MainLogger?
    
    init() {
        DDLog.add(DDTTYLogger.sharedInstance())
        self.setUpMainLogger()
    }
    
    func clearLog() {
        DDLog.remove(self.mainLogger)
        
        if let logPath = self.mainLogger?.logPath {
            do {
                try FileManager.default.removeItem(atPath: logPath)
            } catch {
                DDLogWarn("Error trying to delete log file at \(logPath): \(error)")
            }
        }
        
        self.mainLogger = nil
        self.setUpMainLogger()
    }
    
    private func setUpMainLogger() {
        self.mainLogger = MainLogger()
        DDLog.add(self.mainLogger)
    }
}
