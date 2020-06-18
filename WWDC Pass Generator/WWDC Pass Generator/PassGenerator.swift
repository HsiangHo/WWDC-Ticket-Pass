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
}

class PassGenerator: NSObject {
    static var shared: PassGenerator = PassGenerator.init()

    private var passTemplateURL: URL {
        Bundle.main.resourceURL!.appendingPathComponent("t/template.pass")
    }

    func package(config: PassConfiguration, to: URL) throws {
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

        let jsonURL = dest.appendingPathComponent("pass.json")
        try fillInJson(jsonURL: jsonURL, config: config)
    }
}

extension PassGenerator {
    func fillInJson(jsonURL: URL, config: PassConfiguration) throws  {
        let decoder = JSONDecoder()
        guard let model = try? decoder.decode(PassJsonModel.self, from: Data.init(contentsOf: jsonURL)) else {
            throw PassGeneratorError.invalidTemplate
        }

        var jsonModel = model
        jsonModel.passTypeIdentifier = config.passTypeID
        jsonModel.teamIdentifier = config.teamID
        jsonModel.serialNumber = config.teamID
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
}
