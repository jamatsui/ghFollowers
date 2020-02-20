//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by jason on 2/20/20.
//  Copyright © 2020 jason. All rights reserved.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
