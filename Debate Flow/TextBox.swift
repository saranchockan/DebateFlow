//
//  TextBox.swift
//  Debate Flow
//
//  Created by Saranjitharunesh Chockan on 1/5/18.
//  Copyright © 2018 Saranjitharunesh Chockan. All rights reserved.
//

import Cocoa
import Anchors

class TextBox: NSTextView {
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
    }
    
    override var intrinsicContentSize: NSSize{
        
        guard let manager = textContainer?.layoutManager else {
            return .zero
        }
        
        if manager.textStorage?.length==0{
            var frame: NSRect = self.frame
            frame.size.height = 50
            frame.size.width = 250
            
            return frame.size
        }
        
        if manager.usedRect(for: textContainer!).size.height<=50{

            return self.frame.size
        }
        manager.ensureLayout(for: textContainer!)
        return manager.usedRect(for: textContainer!).size
        
        
    }
}

extension NSTextView{
    
    
    func numberOfLines() -> Int {
        let layoutManager = self.layoutManager
        let numberOfGlyphs = layoutManager?.numberOfGlyphs
        var lineRange: NSRange = NSMakeRange(0, 1)
        var index = 0
        var numberOfLines = 0
        
        while index < numberOfGlyphs! {
            layoutManager?.lineFragmentRect(
                forGlyphAt: index, effectiveRange: &lineRange
            )
            index = NSMaxRange(lineRange)
            numberOfLines += 1
        }
        return numberOfLines
    }
}
