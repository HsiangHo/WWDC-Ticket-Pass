//
//  AppDelegate.swift
//  WWDC Pass Generator
//
//  Created by Jovi on 6/16/20.
//  Copyright © 2020 Jovi. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        let windowStyles: NSWindow.StyleMask = [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView]
        let windowRect = NSRect.init(x: 0, y: 0, width: 600, height: 400)
        window = NSWindow.init(contentRect: windowRect, styleMask: windowStyles, backing: .buffered, defer: true)
        window.title = "Title"
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = false
        window.toolbar = NSToolbar.init(identifier: "toolbar")
        window.toolbar?.insertItem(withItemIdentifier: .showColors, at: 0)
        window.toolbar?.insertItem(withItemIdentifier: .flexibleSpace, at: 0)
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.alphaValue = 1.0
        window.center()
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

