//
//  NCViewController.swift
//  Debate Flow
//
//  Created by Saranjitharunesh Chockan on 1/7/18.
//  Copyright © 2018 Saranjitharunesh Chockan. All rights reserved.
//

import Cocoa

class NCViewController: NSViewController {

    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var documentView: Flow!
    
    var arrayOfTextViews = [NSTextView]()

    var directoryURL: URL? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        scrollView.documentView = documentView
        
        let arrayOfViews = documentView.subviews
        
        for view in arrayOfViews{
            if let _: View = view as? View{
                let array = view.subviews
                
                for view in array{
                    if let _:NSScrollView = view as? NSScrollView{
                        let a = view.subviews
                        for v in a{
                            if let _: NSClipView = v as? NSClipView{
                                let r = v.subviews
                                
                                for t in r{
                                    if let _: NSTextView = t as? NSTextView{
                                        arrayOfTextViews.append(t as! NSTextView)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        documentView.scroll(arrayOfViews[0].frame.origin)

    }
    
    
    
    @IBAction func save(_ sender: Any) {
        
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        if directoryURL==nil{
            panel.runModal()
        }
        
        directoryURL = panel.directoryURL
        
        let saveFile: NSSavePanel = NSSavePanel()
        saveFile.canSelectHiddenExtension = true
        saveFile.directoryURL = directoryURL
        
        
        for textView in arrayOfTextViews{
            
            let view = textView.superview?.superview?.superview
            let identifier: String = (view!.identifier?.rawValue.debugDescription)!
            saveFile.nameFieldStringValue = identifier
            
            let text = textView.attributedString()
            var range = NSRange()
            let documentAttributes: [NSAttributedString.DocumentAttributeKey: Any] = [.documentType: NSAttributedString.DocumentType.rtf]
            
            if let length = textView.textStorage?.length{
                
                range = NSRange(0..<length)
            }
            
            do{
                
                let exportedFileURL = saveFile.url
                let textSave = try text.fileWrapper(from: range, documentAttributes: documentAttributes)
                try textSave.write(to: exportedFileURL!, options: FileWrapper.WritingOptions.atomic, originalContentsURL: nil)
                print(exportedFileURL?.lastPathComponent)
            }
            catch{
                print("error")
            }
        }
    }
    
    @IBAction func load(_ sender: Any) {
        
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        panel.runModal()
        

        
        _ = FileManager.default
        
        do {
            let resourceKeys : [URLResourceKey] = [.creationDateKey, .isDirectoryKey]
            let enumerator = FileManager.default.enumerator(at: panel.directoryURL!,
                                                            includingPropertiesForKeys: resourceKeys,
                                                            options: [.skipsHiddenFiles], errorHandler: { (url, error) -> Bool in
                                                                print("directoryEnumerator error at \(url): ", error)
                                                                return true
            })!
            
            for case let fileURL as URL in enumerator {
                _ = try fileURL.resourceValues(forKeys: Set(resourceKeys))
                
                for textView in arrayOfTextViews{
                    let view = textView.superview?.superview?.superview
                    let identifier: String = (view!.identifier?.rawValue.debugDescription)!
                    
                    if identifier==fileURL.lastPathComponent{
                        let attributedStringWithRtf: NSAttributedString = try NSAttributedString(url: URL(fileURLWithPath: fileURL.path), options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
                        
                        
                        let TV = NSTextView()
                        TV.textStorage?.setAttributedString(attributedStringWithRtf)
                        let numOfLines:Int = TV.numberOfLines()
                        
                        let v: View = textView.superview?.superview?.superview as! View
                        for _ in 1...numOfLines{
                            v.rePosition()
                            v.pushDown()
                        }
                        textView.textStorage?.setAttributedString(attributedStringWithRtf)
                        
                    }
                }
            }
        } catch {
            print(error)
        }
        
    }
        
}
    
    

