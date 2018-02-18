//
//  Flow.swift
//  Debate Flow
//
//  Created by Saranjitharunesh Chockan on 1/5/18.
//  Copyright © 2018 Saranjitharunesh Chockan. All rights reserved.
//

import Cocoa
import Anchors

class Flow: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
    }
    func increaseHeight(){
        let newFrame = NSRect(x: self.frame.origin.x, y: self.frame.origin.y-20, width: self.frame.width, height: self.frame.height+20)
        self.frame = newFrame
    }
}
