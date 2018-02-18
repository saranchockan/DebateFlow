//
//  View.swift
//  Debate Flow
//
//  Created by Saranjitharunesh Chockan on 1/5/18.
//  Copyright © 2018 Saranjitharunesh Chockan. All rights reserved.
//

import Cocoa
import Anchors

class View: NSView, NSTextViewDelegate, NSComboBoxDelegate {
    
    var comboBox: NSComboBox = NSComboBox()
    var scrollView: NSScrollView = NSScrollView()
    var clipView: NSClipView = NSClipView()
    var textView: NSTextView = NSTextView()
    var height: CGFloat = CGFloat(56)
    var numberOfLines = Int()
    var bool: Bool = true

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        var arrayOfSubViews:[NSView] = self.subviews
        
        for view in arrayOfSubViews{
            if let _: NSScrollView = view as? NSScrollView{
                scrollView = view as! NSScrollView
            }
            
            if let _: NSComboBox = view as? NSComboBox{
                comboBox = view as! NSComboBox
                comboBox.delegate =  self
                
            }
        }
        arrayOfSubViews = scrollView.subviews
        for view in arrayOfSubViews{
            if let _:NSClipView = view as? NSClipView{
                clipView = view as! NSClipView
            }
        }
        
        arrayOfSubViews = clipView.subviews
        
        for view in arrayOfSubViews{
            if let _:NSTextView = view as? NSTextView{
                textView = view as! NSTextView
                textView.delegate = self
            }
        }
        

    
        let identifier: String = (self.identifier?.rawValue.debugDescription)!
        let index = identifier.index(identifier.startIndex, offsetBy: 3)
        
        let ID : Int = Int(String(identifier[index]))!
        
        if ID<8{
            activate(
                scrollView.anchor.top.constant(20),
            
                scrollView.anchor.paddingHorizontally(0),
            
                scrollView.anchor.bottom.constant(0)
            )
        
            activate(
            textView.anchor.edges
            )
        }
        
        else if ID==8{
            activate(
                scrollView.anchor.top.constant(20),
                
                scrollView.anchor.paddingHorizontally(0)
            )
            
            activate(
                textView.anchor.edges
            )
        }
        /*
         anchor.top.constant sets the gap between the top and bottom of the Parent View and the TextView
         anchor.paddingHorizontally sets the gap between the vertical and horizontal of the Parent View and the TextView
         */
        
        if bool == true{
            numberOfLines = textView.numberOfLines()
            bool = false
        }
    }
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
    }
    
    func textDidChange(_ notification: Notification) {
        
        let identifier: String = (self.identifier?.rawValue.debugDescription)!
        let index = identifier.index(identifier.startIndex, offsetBy: 3)
        
        let ID : Int = Int(String(identifier[index]))!
        
        if ID==8{
            rePosition()
            textView.invalidateIntrinsicContentSize()
        }
        else if textView.numberOfLines()>3 && textView.numberOfLines()>numberOfLines{

            numberOfLines = textView.numberOfLines()
            rePosition()
            height = (textView.layoutManager?.usedRect(for: textView.textContainer!).size.height)!
            pushDown()
            let diff = numberOfLines-textView.numberOfLines()

        }
        else{
            let diff = numberOfLines-textView.numberOfLines()
            if textView.numberOfLines()>4{
                pushUp(diff: diff)
            }
            numberOfLines = textView.numberOfLines()
        }
    }
    
    func rePosition(){
        let newFrame = NSRect(x: self.frame.origin.x, y: self.frame.origin.y-14, width: self.frame.width, height: self.frame.height+14)
          self.frame = newFrame
        
        let view: Flow = self.superview as! Flow
        view.increaseHeight()
       
    }
    
    func pushDown(){
        var arrayofSubViews: [NSView] = (self.superview?.subviews)!
        let identifier: String = (self.identifier?.rawValue.debugDescription)!
        let index = identifier.index(identifier.startIndex, offsetBy: 3)
        
        let ID : Int = Int(String(identifier[index]))!
        
        if ID<8{
            
            if identifier.prefix(upTo: index) == "\"AC" || identifier.prefix(upTo: index) == "\"NC" || identifier.prefix(upTo: index) == "\"PC" || identifier.prefix(upTo: index) == "\"CC" {
                for k in ID...7{
                    let view: View = arrayofSubViews[k] as! View
                    let newFrame = NSRect(x: view.frame.origin.x, y: view.frame.origin.y-14, width: view.frame.width, height: view.frame.height)
                    view.frame = newFrame
            
                }
            }
            
            else if identifier.prefix(upTo: index) == "\"NR" || identifier.prefix(upTo: index) == "\"RA" || identifier.prefix(upTo: index) == "\"CR" || identifier.prefix(upTo: index) == "\"PR"{
                for k in ID+9...16{
                    let view: View = arrayofSubViews[k] as! View
                    let newFrame = NSRect(x: view.frame.origin.x, y: view.frame.origin.y-14, width: view.frame.width, height: view.frame.height)
                    view.frame = newFrame
                    
                }
            }
            
            else if identifier.prefix(upTo: index) == "\"AR" || identifier.prefix(upTo: index) == "\"NN" || identifier.prefix(upTo: index) == "\"PS" || identifier.prefix(upTo: index) == "\"CS" {
                for k in ID+18...25{
                    let view: View = arrayofSubViews[k] as! View
                    let newFrame = NSRect(x: view.frame.origin.x, y: view.frame.origin.y-14, width: view.frame.width, height: view.frame.height)
                    view.frame = newFrame
                    
                }
            }
            
            else if identifier.prefix(upTo: index) == "\"RN" {
                for k in ID+36...43{
                    let view: View = arrayofSubViews[k] as! View
                    let newFrame = NSRect(x: view.frame.origin.x, y: view.frame.origin.y-14, width: view.frame.width, height: view.frame.height)
                    view.frame = newFrame
                    print(identifier.prefix(upTo: index))
                }
            }
            
            else if identifier.prefix(upTo: index) == "\"AA"  {
                for k in ID+27...34{
                    let view: View = arrayofSubViews[k] as! View
                    let newFrame = NSRect(x: view.frame.origin.x, y: view.frame.origin.y-14, width: view.frame.width, height: view.frame.height)
                    view.frame = newFrame
                    print(identifier.prefix(upTo: index))

                }
            }
            
            else if identifier.prefix(upTo: index) == "\"RR" || identifier.prefix(upTo: index) == "\"CF" || identifier.prefix(upTo: index) == "\"PF"{
                for k in ID+27...34{
                    let view: View = arrayofSubViews[k] as! View
                    let newFrame = NSRect(x: view.frame.origin.x, y: view.frame.origin.y-14, width: view.frame.width, height: view.frame.height)
                    view.frame = newFrame
                    print(identifier.prefix(upTo: index))
                    
                }
            }
            
        }

    }
    
    func pushUp(diff:Int){
        var arrayofSubViews: [NSView] = (self.superview?.subviews)!
        let identifier: String = (self.identifier?.rawValue.debugDescription)!
        let index = identifier.index(identifier.startIndex, offsetBy: 3)
        
        let ID : Int = Int(String(identifier[index]))!
        
        if ID<8{
            if diff>0{

            for _ in 1...diff{
                
                if identifier.prefix(upTo: index) == "\"AC" || identifier.prefix(upTo: index) == "\"NC" || identifier.prefix(upTo: index) == "\"PC" || identifier.prefix(upTo: index) == "\"CC" {
                    for k in ID...7{
                        let view: View = arrayofSubViews[k] as! View
                        let newFrame = NSRect(x: view.frame.origin.x, y: view.frame.origin.y+14, width: view.frame.width, height: view.frame.height)
                        view.frame = newFrame
                    
                    }
                        let newFrame = NSRect(x: self.frame.origin.x, y: self.frame.origin.y+14, width: self.frame.width, height: self.frame.height-14)
                        self.frame = newFrame
                    
                  }
                
                else if identifier.prefix(upTo: index) == "\"NR"  || identifier.prefix(upTo: index) == "\"RA" || identifier.prefix(upTo: index) == "\"CR" || identifier.prefix(upTo: index) == "\"PR" {
                    for k in ID+9...16{
                        let view: View = arrayofSubViews[k] as! View
                        let newFrame = NSRect(x: view.frame.origin.x, y: view.frame.origin.y+14, width: view.frame.width, height: view.frame.height)
                        view.frame = newFrame
                        
                    }
                    let newFrame = NSRect(x: self.frame.origin.x, y: self.frame.origin.y+14, width: self.frame.width, height: self.frame.height-14)
                    self.frame = newFrame
                }
                
                else if identifier.prefix(upTo: index) == "\"AR" || identifier.prefix(upTo: index) == "\"NN" || identifier.prefix(upTo: index) == "\"PS" || identifier.prefix(upTo: index) == "\"CS"{
                    for k in ID+18...25{
                        let view: View = arrayofSubViews[k] as! View
                        let newFrame = NSRect(x: view.frame.origin.x, y: view.frame.origin.y+14, width: view.frame.width, height: view.frame.height)
                        view.frame = newFrame
                        
                    }
                    let newFrame = NSRect(x: self.frame.origin.x, y: self.frame.origin.y+14, width: self.frame.width, height: self.frame.height-14)
                    self.frame = newFrame
                }
                
                else if identifier.prefix(upTo: index) == "\"RN"  {
                    for k in ID+36...43{
                        let view: View = arrayofSubViews[k] as! View
                        let newFrame = NSRect(x: view.frame.origin.x, y: view.frame.origin.y+14, width: view.frame.width, height: view.frame.height)
                        view.frame = newFrame
                        
                    }
                    let newFrame = NSRect(x: self.frame.origin.x, y: self.frame.origin.y+14, width: self.frame.width, height: self.frame.height-14)
                    self.frame = newFrame
                }
                
                else if identifier.prefix(upTo: index) == "\"AA" {
                    for k in ID+27...34{ 
                        let view: View = arrayofSubViews[k] as! View
                        let newFrame = NSRect(x: view.frame.origin.x, y: view.frame.origin.y+14, width: view.frame.width, height: view.frame.height)
                        view.frame = newFrame
                        
                    }
                    let newFrame = NSRect(x: self.frame.origin.x, y: self.frame.origin.y+14, width: self.frame.width, height: self.frame.height-14)
                    self.frame = newFrame
                }
                
                else if identifier.prefix(upTo: index) == "\"RR" || identifier.prefix(upTo: index) == "\"CF" || identifier.prefix(upTo: index) == "\"PF" {
                    for k in ID+27...33{
                        let view: View = arrayofSubViews[k] as! View
                        let newFrame = NSRect(x: view.frame.origin.x, y: view.frame.origin.y+14, width: view.frame.width, height: view.frame.height)
                        view.frame = newFrame
                        
                    }
                    let newFrame = NSRect(x: self.frame.origin.x, y: self.frame.origin.y+14, width: self.frame.width, height: self.frame.height-14)
                    self.frame = newFrame
                }
            }
         }
      }
   }
}

