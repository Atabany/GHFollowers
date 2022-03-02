//
//  Date + Ext.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 01/03/2022.
//

import Foundation

extension Date {
    func convertToMonthYearString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
