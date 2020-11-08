//
//  Date+Extension.swift
//  GorillaBook
//
//  Created by Andres Felipe Rojas R. on 8/11/20.
//

import Foundation

extension DateFormatter {
    public static var versionFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"

        return formatter
    }
}
