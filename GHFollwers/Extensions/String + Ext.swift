//
//  String + Ext.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 01/03/2022.
//

import Foundation
extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self) ?? nil
    }
    
    func convertToDisplayFormat() -> String? {
        guard let date = self.convertToDate() else {return "N/A"}
        return date.convertToMonthYearString()
    }
}

