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
        let directory = self.mainLogger!.logDirectory
        
        DDLog.remove(self.mainLogger)
        self.mainLogger = nil
        
        // give the logger a chance to attempt to rotate logs, then clean up and start fresh
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let dirContents = try? FileManager.default.contentsOfDirectory(atPath: directory) {
                dirContents.forEach { filename in
                    if filename.hasPrefix(MainLogger.matchingFilePrefix) &&
                        filename.hasSuffix(MainLogger.matchingFileSuffix)
                    {
                        let path = (directory as NSString).appendingPathComponent(filename)
                        try? FileManager.default.removeItem(atPath: path)
                    }
                }
            }
            
            self.setUpMainLogger()
        }
    }
    
    private func setUpMainLogger() {
        self.mainLogger = MainLogger()
        DDLog.add(self.mainLogger)
    }
}
