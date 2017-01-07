//
//  MainView.swift
//  PushmiPullyu
//
//  Created by Matthias Ferber on 1/7/17.
//  Copyright © 2017 Cantina. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setMargins()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setMargins()
    }
    
    private func setMargins() {
        self.layoutMargins = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
}
