//
//  LogViewController.swift
//  PushmiPullyu
//
//  Created by Matthias Ferber on 1/6/17.
//  Copyright © 2017 Cantina. All rights reserved.
//

import UIKit

import CocoaLumberjackSwift

class LogViewController: UIViewController {
    
    
    // MARK: - Properties: static
    
    
    private struct Const {
        static let refreshInterval: TimeInterval = 1.0
    }
    
    
    // MARK: - Properties: private
    
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var loggerManager: LoggerManager!
    private var reloadTimer: Timer!
    
    // MARK: - Properties: @IBOutlet
    
    
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var clearButton: UIButton!
    
    
    // MARK: - Lifecycle
    
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        
        self.logViewControllerSharedInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.logViewControllerSharedInit()
    }
    
    
    private func logViewControllerSharedInit() {
        self.loggerManager = self.appDelegate.loggerManager
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadLog()
        self.reloadTimer = Timer.scheduledTimer(timeInterval: Const.refreshInterval,
                                                target: self,
                                                selector: #selector(loadLog),
                                                userInfo: nil,
                                                repeats: true)
    }
    
    
    // MARK: - Event handlers
    
    
    @IBAction private func clearButtonTapped() {
        self.loggerManager.clearLog()
        self.textView.text = ""
    }
    
    
    @IBAction private func forceQuitButtonTapped() {
        abort()
    }


    // MARK: - Methods
    
    
    @objc private func loadLog() {
        guard let logPath = appDelegate.loggerManager.mainLogger?.logPath else { return }
     
        do {
            let text = try String(contentsOfFile: logPath, encoding: .utf8)
            self.textView.text = text
        } catch {
            // Probably the logger just hasn't written anything to the log yet, especially if it was just
            // cleared.  No need to log that.  (Better to test the error type, but that's out of scope for
            // now.)
            // DDLogWarn("Can't read log file: \(error)")
        }
    }

}

