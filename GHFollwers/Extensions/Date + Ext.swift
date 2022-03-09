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
        return formatted(.dateTime.month().year().locale(Locale(identifier: "en_US_POSIX")))
    }
}

