//
//  AppDelegate.swift
//  WWDC Pass Generator
//
//  Created by Jovi on 6/16/20.
//  Copyright © 2020 Jovi. All rights reserved.
//

import Cocoa
import SwiftUI

extension NSToolbarItem.Identifier {
    static let generateToolbarIdentifier = NSToolbarItem.Identifier(rawValue: "generateToolbarIdentifier")
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    let toolbarTabsIdentifierArray: [NSToolbarItem.Identifier] = [.generateToolbarIdentifier]
    var generateButton: WPGToolbarButton!
    var generateMenu: NSMenu = NSMenu.init(title: "generateMenu")

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        let windowStyles: NSWindow.StyleMask = [.titled, .closable, .miniaturizable]
        let windowRect = NSRect.init(x: 0, y: 0, width: 700, height: 400)
        window = NSWindow.init(contentRect: windowRect, styleMask: windowStyles, backing: .buffered, defer: true)
        window.title = "Title"
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = false
        window.toolbar = NSToolbar.init(identifier: "toolbar")
        window.toolbar?.delegate = self
        window.toolbar?.insertItem(withItemIdentifier: .generateToolbarIdentifier, at: 0)
        window.toolbar?.insertItem(withItemIdentifier: .flexibleSpace, at: 0)
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.alphaValue = 1.0
        window.center()
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)

        let generatePackageMenuItem = NSMenuItem.init(title: LocalizedStrings.GeneratePassPackage, action: #selector(generatePackage_click(sender:)), keyEquivalent: "")
        generatePackageMenuItem.target = self

        let generatePkpassMenuItem = NSMenuItem.init(title: LocalizedStrings.GeneratePkpassFile, action: #selector(generatePkpass_click(sender:)), keyEquivalent: "")
        generatePkpassMenuItem.target = self

        generateMenu.addItem(generatePackageMenuItem)
        generateMenu.addItem(generatePkpassMenuItem)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }

}

extension AppDelegate: NSToolbarDelegate {
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)

        if itemIdentifier == .generateToolbarIdentifier {
            generateButton = WPGToolbarButton.init(frame: NSRect(x: 0, y: 0, width: 43, height: 27))
            let image = NSImage.init(named: "export")
            image?.isTemplate = true
            image?.size = NSSize.init(width: 14, height: 15)
            generateButton.image = image
            generateButton.toolTip = LocalizedStrings.Generate
            toolbarItem.view = generateButton
            toolbarItem.minSize = generateButton.frame.size
            toolbarItem.maxSize = generateButton.frame.size
            toolbarItem.target = self
            toolbarItem.action = #selector(generateMenu_click(sender:))
        }

        return toolbarItem
    }

    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return self.toolbarTabsIdentifierArray
    }

    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return self.toolbarTabsIdentifierArray
    }

    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return self.toolbarTabsIdentifierArray
    }
}

extension AppDelegate {
    @IBAction func generateMenu_click(sender: Any?) {
        NSMenu.popUpContextMenu(generateMenu, with: NSApp.currentEvent!, for: sender as! NSView)
    }

    @IBAction func generatePackage_click(sender: Any?) {

    }

    @IBAction func generatePkpass_click(sender: Any?) {

    }
}
