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
    
    
    // MARK: - Properties: @IBOutlet
    
    
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var clearButton: UIButton!
    
    
    // MARK: - Lifecycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadLog()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Methods
    
    
    private func loadLog() {
        guard let logPath = appDelegate.loggerManager.mainLogger?.logPath else { return }
     
        do {
            let text = try String(contentsOfFile: logPath, encoding: .utf8)
            self.textView.text = text
        } catch {
            DDLogWarn("Can't read log file: \(error)")
        }
    }

}

