//
//  ExclusionDate.swift
//  RRuleSwift
//
//  Created by Xin Hong on 16/3/28.
//  Copyright © 2016年 Teambition. All rights reserved.
//

import Foundation

public struct ExclusionDate {
    /// All exclusion dates.
    public fileprivate(set) var dates = [Date]()
    /// The component of ExclusionDate, used to decide which exdate will be excluded.
    public fileprivate(set) var component: Calendar.Component!

    public init(dates: [Date], granularity component: Calendar.Component) {
        self.dates = dates
        self.component = component
    }

    public init?(exdateString string: String, granularity component: Calendar.Component) {
        let exdateString = string.trimmingCharacters(in: .whitespaces)
        let exdates = exdateString.components(separatedBy: ",").flatMap { (dateString) -> String? in
            if (dateString.isEmpty || dateString.count == 0) {
                return nil
            }
            return dateString
        }

        self.dates = exdates.flatMap({ (dateString) -> Date? in
            if let date = RRule.dateFormatter.date(from: dateString) {
                return date
            } else if let date = RRule.realDate(dateString) {
                return date
            }
            return nil
        })
        self.component = component
    }

    public func toExDateString() -> String? {
        var exdateString = ""
        let dateStrings = dates.map { (date) -> String in
            return RRule.dateFormatter.string(from: date)
        }
        if dateStrings.count > 0 {
            exdateString += dateStrings.joined(separator: ",")
        } else {
            return nil
        }

        return exdateString
    }
}
