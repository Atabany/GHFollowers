//
//  Date + Ext.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 01/03/2022.
//

import Foundation
import UIKit

extension Date {
    func convertToMonthYearString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
}

