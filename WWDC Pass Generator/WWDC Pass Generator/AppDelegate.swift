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
    static let exportToolbarIdentifier = NSToolbarItem.Identifier(rawValue: "exportToolbarIdentifier")
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    let toolbarTabsIdentifierArray: [NSToolbarItem.Identifier] = [.exportToolbarIdentifier]
    var exportButton: WPGToolbarButton!
    var exportMenu: NSMenu = NSMenu.init(title: "exportMenu")

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
        window.toolbar?.insertItem(withItemIdentifier: .exportToolbarIdentifier, at: 0)
        window.toolbar?.insertItem(withItemIdentifier: .flexibleSpace, at: 0)
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.alphaValue = 1.0
        window.center()
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)

        let exportPackageMenuItem = NSMenuItem.init(title: LocalizedStrings.ExportPassPackage, action: #selector(exportPackage_click(sender:)), keyEquivalent: "")
        exportPackageMenuItem.target = self

        let exportPkpassMenuItem = NSMenuItem.init(title: LocalizedStrings.ExportPkpassFile, action: #selector(exportPkpass_click(sender:)), keyEquivalent: "")
        exportPkpassMenuItem.target = self

        exportMenu.addItem(exportPackageMenuItem)
        exportMenu.addItem(exportPkpassMenuItem)
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

        if itemIdentifier == .exportToolbarIdentifier {
            exportButton = WPGToolbarButton.init(frame: NSRect(x: 0, y: 0, width: 43, height: 27))
            let image = NSImage.init(named: "export")
            image?.isTemplate = true
            image?.size = NSSize.init(width: 14, height: 15)
            exportButton.image = image
            exportButton.toolTip = LocalizedStrings.Export
            toolbarItem.view = exportButton
            toolbarItem.minSize = exportButton.frame.size
            toolbarItem.maxSize = exportButton.frame.size
            toolbarItem.target = self
            toolbarItem.action = #selector(exportMenu_click(sender:))
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
    @IBAction func exportMenu_click(sender: Any?) {
        NSMenu.popUpContextMenu(exportMenu, with: NSApp.currentEvent!, for: sender as! NSView)
    }

    @IBAction func exportPackage_click(sender: Any?) {

    }

    @IBAction func exportPkpass_click(sender: Any?) {

    }
}
