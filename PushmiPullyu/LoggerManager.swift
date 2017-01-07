//
//  LoggerManager.swift
//  PushmiPullyu
//
//  Created by Matthias Ferber on 1/6/17.
//  Copyright © 2017 Cantina. All rights reserved.
//

import CocoaLumberjack

class LoggerManager {
    var mainLogger: DDLogger?
    
    init() {
        self.mainLogger = MainLogger()
        
        DDLog.add(DDTTYLogger.sharedInstance())
        DDLog.add(self.mainLogger)
    }
}
