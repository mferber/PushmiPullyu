//
//  MainLogger.swift
//  PushmiPullyu
//
//  Created by Matthias Ferber on 1/6/17.
//  Copyright © 2017 Cantina. All rights reserved.
//

import CocoaLumberjackSwift

/**
 Custom logger that logs events with a timestamp and code location.
 
 To log a header, use Error level.  All other levels produce normal log entries.
 */
class MainLogger: DDFileLogger {
    
    static let filename = "log.txt"
    static let archivedFilename = "log.archived.txt"
    
    var logDirectory: String {
        return self.logFileManager.logsDirectory
    }
    
    var logPath: String {
        return (self.logDirectory as NSString).appendingPathComponent(MainLogger.filename)
    }
    
    var archivedLogPath: String {
        return (self.logDirectory as NSString).appendingPathComponent(MainLogger.archivedFilename)
    }

    
    init() {
        super.init(logFileManager: SingleLogCacheFileManager(filename: MainLogger.filename))
        
        // don't ever roll over the files
        self.maximumFileSize = 0
        self.rollingFrequency = 0
        
        self.logFormatter = SimpleTracingFormatter()
    }
}


/**
 Log file manager that only writes to one file ever, in the Caches directory.
 */
private class SingleLogCacheFileManager: DDLogFileManagerDefault {
    
    private let filename: String
    
    init(filename: String) {
        self.filename = filename

        let cachesDirUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        super.init(logsDirectory: cachesDirUrl.path)
    }
    
    override var newLogFileName: String {
        return self.filename
    }
    
    override func isLogFile(withName name: String) -> Bool {
        return name == self.filename
    }

}

private class SimpleTracingFormatter: NSObject, DDLogFormatter {
    
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        return formatter
    }()

    func format(message: DDLogMessage!) -> String {
        if message.flag.contains(.error) {
            return self.headerFormat(message: message)
        }
        return self.normalFormat(message: message)
    }
    
    private func normalFormat(message: DDLogMessage) -> String {
        let timestamp = SimpleTracingFormatter.timeFormatter.string(from: message.timestamp)
        let filename = (message.file as NSString).lastPathComponent
        
        return "\(timestamp)  \(message.message ?? "")\n(\(filename): \(message.function ?? "unknown function")))\n\n"
    }
    
    private func headerFormat(message: DDLogMessage) -> String {
        let timestamp = SimpleTracingFormatter.timeFormatter.string(from: message.timestamp)
        return "\n\(timestamp)  ----- \(message.message ?? "") -----\n\n"
    }
    
}
