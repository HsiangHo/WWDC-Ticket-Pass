//
//  DateExtension.swift
//  WWDC Pass Generator
//
//  Created by Jovi on 6/18/20.
//  Copyright © 2020 Jovi. All rights reserved.
//

import Foundation

extension Date{

    func toString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
