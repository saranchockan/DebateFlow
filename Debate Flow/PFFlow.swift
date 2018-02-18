//
//  PFFlow.swift
//  Debate Flow
//
//  Created by Saranjitharunesh Chockan on 1/12/18.
//  Copyright © 2018 Saranjitharunesh Chockan. All rights reserved.
//

import Cocoa

class PFFlow: NSTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.preferredContentSize = NSSize(width: 1139, height: 795)
    }
    
}
