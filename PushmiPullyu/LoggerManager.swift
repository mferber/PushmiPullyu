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
        let archivedLogPath = self.mainLogger?.archivedLogPath
        
        DDLog.remove(self.mainLogger)
        self.mainLogger = nil
        
        self.setUpMainLogger()
        
        // stopping the logger causes the log file to be archived; we don't need that
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let archivedLogPath = archivedLogPath {
                do {
                    try FileManager.default.removeItem(atPath: archivedLogPath)
                } catch {
                    DDLogWarn("Error trying to delete archived log file at \(archivedLogPath): \(error)")
                }
            }
        }
    }
    
    private func setUpMainLogger() {
        self.mainLogger = MainLogger()
        DDLog.add(self.mainLogger)
    }
}
