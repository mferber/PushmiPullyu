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
    
    
    // MARK: - Properties: private
    
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var reloadTimer: Timer!
    
    // MARK: - Properties: @IBOutlet
    
    
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var clearButton: UIButton!
    
    
    // MARK: - Lifecycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadLog()
        self.reloadTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(loadLog),
                                                userInfo: nil, repeats: true)

    }


    // MARK: - Methods
    
    
    @objc private func loadLog() {
        guard let logPath = appDelegate.loggerManager.mainLogger?.logPath else { return }
     
        do {
            let text = try String(contentsOfFile: logPath, encoding: .utf8)
            self.textView.text = text
        } catch {
            DDLogWarn("Can't read log file: \(error)")
        }
    }

}

