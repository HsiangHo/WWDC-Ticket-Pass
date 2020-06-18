//
//  Utility.swift
//  WWDC Pass Generator
//
//  Created by Jovi on 6/18/20.
//  Copyright © 2020 Jovi. All rights reserved.
//

import Cocoa

class Utility: NSObject {
    @discardableResult public static func system(_ command: String) -> Int {
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", command]

        task.launch()
        task.waitUntilExit()
        return Int(task.terminationStatus)
    }
}
