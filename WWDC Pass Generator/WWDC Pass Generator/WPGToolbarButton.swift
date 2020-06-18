//
//  WPGToolbarButton.swift
//  WWDC Pass Generator
//
//  Created by Jovi on 6/18/20.
//  Copyright © 2020 Jovi. All rights reserved.
//

import Cocoa

class WPGToolbarButton: NSButton {
    private var _trackingArea: NSTrackingArea?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
        self.bezelStyle = .texturedSquare
        self.setButtonType(.momentaryChange)
        self.focusRingType = .none
        self.isBordered = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WPGToolbarButton {
    override func updateTrackingAreas() {
        super.updateTrackingAreas()

        if nil != _trackingArea {
            self.removeTrackingArea(_trackingArea!)
        }
        _trackingArea = NSTrackingArea.init(rect: self.bounds,
                                            options: [.activeAlways, .mouseMoved, .mouseEnteredAndExited],
                                            owner: self,
                                            userInfo: nil)
        self.addTrackingArea(_trackingArea!)
    }

    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        NSCursor.pointingHand.set()
    }

    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        NSCursor.arrow.set()
    }
}
