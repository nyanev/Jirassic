//
//  ReportsHeaderView.swift
//  Jirassic
//
//  Created by Cristian Baluta on 19/02/2017.
//  Copyright © 2017 Imagin soft. All rights reserved.
//

import Cocoa

class ReportsHeaderView: NSTableHeaderView {
    
    fileprivate var butRound: NSButton
    fileprivate var butPercents: NSButton
    fileprivate var totalTimeTextField: NSTextField
    fileprivate let localPreferences = RCPreferences<LocalPreferences>()
    var didChangeSettings: (() -> ())?
    var totalTime: String {
        get {
            return ""
        }
        set {
            totalTimeTextField.stringValue = newValue
        }
    }
    var targetTime: Double {
        get {
            return 0.0
        }
        set {
            butRound.attributedTitle = NSAttributedString(string: "Round to \(newValue) hours", attributes: attributes)
        }
    }
    fileprivate let attributes = [NSForegroundColorAttributeName: NSColor.white]
    
    init() {
        
        butRound = NSButton()
        butRound.frame = NSRect(x: 200, y: 20, width: 200, height: 20)
        butRound.setButtonType(.switch)
        butRound.state = localPreferences.bool(.roundDay)  ? NSOnState : NSOffState
        butRound.toolTip = "This time can be set in 'Settings/Tracking/Working between'"
        
        butPercents = NSButton()
        butPercents.frame = NSRect(x: 15, y: 20, width: 200, height: 20)
        butPercents.attributedTitle = NSAttributedString(string: "Show time in percents", attributes: attributes)
        butPercents.setButtonType(.switch)
        butPercents.state = localPreferences.bool(.usePercents) ? NSOnState : NSOffState
        
        totalTimeTextField = NSTextField()
        totalTimeTextField.alignment = NSTextAlignment.right
        totalTimeTextField.drawsBackground = false
        totalTimeTextField.isBordered = false
        totalTimeTextField.isEnabled = false
        totalTimeTextField.focusRingType = .none
        totalTimeTextField.textColor = NSColor.white
        totalTimeTextField.backgroundColor = NSColor.clear
        
        super.init(frame: NSRect(x: 0, y: 0, width: 0, height: 60))
        
        self.totalTime = ""
        self.targetTime = 8.0
        
        butRound.target = self
        butRound.action = #selector(self.handleRoundButton)
        butPercents.target = self
        butPercents.action = #selector(self.handlePercentsButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        NSColor.darkGray.set()
        NSRectFill(dirtyRect)
        
        self.addSubview(butPercents)
        self.addSubview(butRound)
        
        totalTimeTextField.frame = NSRect(x: dirtyRect.size.width - 80, y: 22, width: 64, height: 20)
        self.addSubview(totalTimeTextField)
    }
}

extension ReportsHeaderView {
    
    func handleRoundButton (_ sender: NSButton) {
        localPreferences.set(sender.state == NSOnState, forKey: .roundDay)
        didChangeSettings?()
    }
    
    func handlePercentsButton (_ sender: NSButton) {
        localPreferences.set(sender.state == NSOnState, forKey: .usePercents)
        didChangeSettings?()
    }
}
