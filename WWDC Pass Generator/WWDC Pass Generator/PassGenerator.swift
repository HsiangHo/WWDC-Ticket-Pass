//
//  PassGenerator.swift
//  WWDC Pass Generator
//
//  Created by Jovi on 6/18/20.
//  Copyright © 2020 Jovi. All rights reserved.
//

import Cocoa

enum PassGeneratorError: Error {
    case invalidTemplate
    case invalidConfiguration
    case saveFailed
    case signFailed
}

class PassGenerator: NSObject {
    static var shared: PassGenerator = PassGenerator.init()

    private var passTemplateURL: URL {
        Bundle.main.resourceURL!.appendingPathComponent("t/template.pass")
    }

    func package(config: PassConfiguration, to: URL, needSign: Bool = true) throws {
        /// Copy template
        let dest = to.appendingPathComponent("WWDC.pass")
        if !FileManager.default.fileExists(atPath: passTemplateURL.path) {
            throw PassGeneratorError.invalidTemplate
        }
        
        try? FileManager.default.removeItem(at: dest)

        do {
            try FileManager.default.copyItem(at: passTemplateURL, to: dest)
        } catch {
            throw PassGeneratorError.saveFailed
        }

        /// Edit json
        let jsonURL = dest.appendingPathComponent("pass.json")
        try fillInJson(jsonURL: jsonURL, config: config)

        /// Make images
        var imageSize = NSSize.init(width: 180, height: 220)
        var imageURL = dest.appendingPathComponent("background.png")
        makeBackgroundImage(size: imageSize, config: config, to: imageURL)

        imageSize = NSSize.init(width: 360, height: 440)
        imageURL = dest.appendingPathComponent("background@2x.png")
        makeBackgroundImage(size: imageSize, config: config, to: imageURL)

        imageSize = NSSize.init(width: 540, height: 660)
        imageURL = dest.appendingPathComponent("background@3x.png")
        makeBackgroundImage(size: imageSize, config: config, to: imageURL)

        if needSign {
            try sign(packageURL: dest)
        }
    }
}

extension PassGenerator {
    private func fillInJson(jsonURL: URL, config: PassConfiguration) throws  {
        let decoder = JSONDecoder()
        guard let model = try? decoder.decode(PassJsonModel.self, from: Data.init(contentsOf: jsonURL)) else {
            throw PassGeneratorError.invalidTemplate
        }

        var jsonModel = model
        jsonModel.passTypeIdentifier = config.passTypeID
        jsonModel.teamIdentifier = config.teamID
        jsonModel.serialNumber = NSUUID().uuidString
        jsonModel.expirationDate = "\(config.expiryDate.toString(dateFormat: "yyyy-MM-dd"))T23:59-07:00"
        jsonModel.beacons?[0].relevantText = "Check in to \(config.eventName)."
        jsonModel.barcode?.message = "{\"badge_id\":\"\(config.teamID)\"}"
        jsonModel.organizationName = config.eventName
        jsonModel.descriptionValue = "\(config.eventName) Ticket"
        jsonModel.eventTicket?.primaryFields?[0].value = config.attendee
        jsonModel.eventTicket?.secondaryFields?[0].value = config.dates
        jsonModel.eventTicket?.auxiliaryFields?[0].value = config.location

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(jsonModel) else {
            throw PassGeneratorError.invalidConfiguration
        }

        do {
            try data.write(to: jsonURL)
        } catch {
            throw PassGeneratorError.saveFailed
        }
    }

    private func makeBackgroundImage(size: NSSize, config: PassConfiguration, to: URL) {
        guard let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(size.width), pixelsHigh: Int(size.height), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: NSColorSpaceName.deviceRGB, bytesPerRow: 0, bitsPerPixel: 0) else {
                return
        }
        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)

        let rect = NSMakeRect(0, 0, size.width, size.height)
        let gradient = NSGradient.init(starting: config.color1, ending: config.color2)
        gradient?.draw(in: rect, angle: 270)
        
        NSGraphicsContext.restoreGraphicsState()
        guard let data = rep.representation(using: NSBitmapImageRep.FileType.png, properties: [NSBitmapImageRep.PropertyKey.compressionFactor: 1.0]) else {
            return
        }
        try? data.write(to: to, options: .atomic)
    }

    private func sign(packageURL: URL) throws {
        let signToolURL = Bundle.main.executableURL!.deletingLastPathComponent().appendingPathComponent("signpass")
        let cmd = String(format: "'%@' -p '%@'", signToolURL.path, packageURL.path)
        if 0 != Utility.system(cmd) {
            throw PassGeneratorError.signFailed
        }
    }
}
