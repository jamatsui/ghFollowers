//
//  String+Ext.swift
//  GHFollowers
//
//  Created by jason on 2/20/20.
//  Copyright © 2020 jason. All rights reserved.
//

import Foundation

extension String {
    
    // reason we keep as a date, is that you can use it a lot as long as it's in a date format
    func convertToDate() -> Date? {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormmater.locale = Locale(identifier: "en_US_POSIX")
        dateFormmater.timeZone = .current
        
        // reason it's an optional is that we can't always guarantee it's the exact format
        return dateFormmater.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
