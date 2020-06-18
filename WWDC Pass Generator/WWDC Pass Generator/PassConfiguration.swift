//
//  PassConfiguration.swift
//  WWDC Pass Generator
//
//  Created by Jovi on 6/17/20.
//  Copyright © 2020 Jovi. All rights reserved.
//

import Foundation
import SwiftUI

class PassConfiguration: ObservableObject {
    @Published var eventName: String = "WWDC20"
    @Published var passTypeID: String = "pass.com.hyperartflow.wwdc-tickets"
    @Published var teamID: String = "9P895LY647"
    @Published var expiryDate: Date = Date.init(timeIntervalSince1970: 4070880000)
    @Published var attendee: String = "Xiang"
    @Published var dates: String = "June 22-26, 2020"
    @Published var location: String = "Online"
    @Published var color1: Color = .init(hex: "8b8b8b")
    @Published var color2: Color = .init(hex: "111111")
}
