//
//  LDFlow.swift
//  Debate Flow
//
//  Created by Saranjitharunesh Chockan on 1/12/18.
//  Copyright © 2018 Saranjitharunesh Chockan. All rights reserved.
//

import Cocoa

class LDFlow: NSTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.preferredContentSize = NSSize(width: 1390, height: 795)
    }
    
}
