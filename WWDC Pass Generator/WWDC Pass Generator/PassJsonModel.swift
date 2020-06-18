//
//  PassJsonModel.swift
//  WWDC Pass Generator
//
//  Created by Jovi on 6/18/20.
//  Copyright © 2020 Jovi. All rights reserved.
//

import Foundation

struct PassJsonModel: Codable {

    enum CodingKeys: String, CodingKey {
        case eventTicket
        case barcode
        case associatedStoreIdentifiers
        case foregroundColor
        case beacons
        case passTypeIdentifier
        case teamIdentifier
        case descriptionValue = "description"
        case organizationName
        case serialNumber
        case backgroundColor
        case formatVersion
        case labelColor
        case webServiceURL
        case expirationDate
        case authenticationToken
    }

    var eventTicket: EventTicket?
    var barcode: Barcode?
    var associatedStoreIdentifiers: [Int]?
    var foregroundColor: String?
    var beacons: [Beacons]?
    var passTypeIdentifier: String?
    var teamIdentifier: String?
    var descriptionValue: String?
    var organizationName: String?
    var serialNumber: String?
    var backgroundColor: String?
    var formatVersion: Int?
    var labelColor: String?
    var webServiceURL: String?
    var expirationDate: String?
    var authenticationToken: String?



    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        eventTicket = try container.decodeIfPresent(EventTicket.self, forKey: .eventTicket)
        barcode = try container.decodeIfPresent(Barcode.self, forKey: .barcode)
        associatedStoreIdentifiers = try container.decodeIfPresent([Int].self, forKey: .associatedStoreIdentifiers)
        foregroundColor = try container.decodeIfPresent(String.self, forKey: .foregroundColor)
        beacons = try container.decodeIfPresent([Beacons].self, forKey: .beacons)
        passTypeIdentifier = try container.decodeIfPresent(String.self, forKey: .passTypeIdentifier)
        teamIdentifier = try container.decodeIfPresent(String.self, forKey: .teamIdentifier)
        descriptionValue = try container.decodeIfPresent(String.self, forKey: .descriptionValue)
        organizationName = try container.decodeIfPresent(String.self, forKey: .organizationName)
        serialNumber = try container.decodeIfPresent(String.self, forKey: .serialNumber)
        backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor)
        formatVersion = try container.decodeIfPresent(Int.self, forKey: .formatVersion)
        labelColor = try container.decodeIfPresent(String.self, forKey: .labelColor)
        webServiceURL = try container.decodeIfPresent(String.self, forKey: .webServiceURL)
        expirationDate = try container.decodeIfPresent(String.self, forKey: .expirationDate)
        authenticationToken = try container.decodeIfPresent(String.self, forKey: .authenticationToken)
    }

}


struct EventTicket: Codable {
    enum CodingKeys: String, CodingKey {
        case secondaryFields
        case primaryFields
        case backFields
        case auxiliaryFields
    }
    var secondaryFields: [SecondaryFields]?
    var primaryFields: [PrimaryFields]?
    var backFields: [BackFields]?
    var auxiliaryFields: [AuxiliaryFields]?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        secondaryFields = try container.decodeIfPresent([SecondaryFields].self, forKey: .secondaryFields)
        primaryFields = try container.decodeIfPresent([PrimaryFields].self, forKey: .primaryFields)
        backFields = try container.decodeIfPresent([BackFields].self, forKey: .backFields)
        auxiliaryFields = try container.decodeIfPresent([AuxiliaryFields].self, forKey: .auxiliaryFields)
    }
}

struct SecondaryFields: Codable {
    enum CodingKeys: String, CodingKey {
        case value
        case key
        case label
    }
    var value: String?
    var key: String?
    var label: String?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decodeIfPresent(String.self, forKey: .value)
        key = try container.decodeIfPresent(String.self, forKey: .key)
        label = try container.decodeIfPresent(String.self, forKey: .label)
    }
}

struct PrimaryFields: Codable {
    enum CodingKeys: String, CodingKey {
        case label
        case value
        case key
    }
    var label: String?
    var value: String?
    var key: String?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        label = try container.decodeIfPresent(String.self, forKey: .label)
        value = try container.decodeIfPresent(String.self, forKey: .value)
        key = try container.decodeIfPresent(String.self, forKey: .key)
    }
}

struct BackFields: Codable {
    enum CodingKeys: String, CodingKey {
        case value
        case key
        case attributedValue
        case label
    }
    var value: String?
    var key: String?
    var attributedValue: String?
    var label: String?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decodeIfPresent(String.self, forKey: .value)
        key = try container.decodeIfPresent(String.self, forKey: .key)
        attributedValue = try container.decodeIfPresent(String.self, forKey: .attributedValue)
        label = try container.decodeIfPresent(String.self, forKey: .label)
    }
}

struct AuxiliaryFields: Codable {
    enum CodingKeys: String, CodingKey {
        case label
        case value
        case key
    }
    var label: String?
    var value: String?
    var key: String?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        label = try container.decodeIfPresent(String.self, forKey: .label)
        value = try container.decodeIfPresent(String.self, forKey: .value)
        key = try container.decodeIfPresent(String.self, forKey: .key)
    }
}

struct Barcode: Codable {
    enum CodingKeys: String, CodingKey {
        case format
        case messageEncoding
        case message
    }
    var format: String?
    var messageEncoding: String?
    var message: String?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        format = try container.decodeIfPresent(String.self, forKey: .format)
        messageEncoding = try container.decodeIfPresent(String.self, forKey: .messageEncoding)
        message = try container.decodeIfPresent(String.self, forKey: .message)
    }
}

struct Beacons: Codable {
    enum CodingKeys: String, CodingKey {
        case relevantText
        case proximityUUID
        case major
    }
    var relevantText: String?
    var proximityUUID: String?
    var major: Int?
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        relevantText = try container.decodeIfPresent(String.self, forKey: .relevantText)
        proximityUUID = try container.decodeIfPresent(String.self, forKey: .proximityUUID)
        major = try container.decodeIfPresent(Int.self, forKey: .major)
    }
}
