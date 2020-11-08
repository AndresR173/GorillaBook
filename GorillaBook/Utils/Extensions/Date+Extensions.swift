//
//  Date+Extension.swift
//  GorillaBook
//
//  Created by Andres Felipe Rojas R. on 8/11/20.
//

import Foundation

extension Date {
    func getReadableDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"

        return formatter.string(from: Date())
    }
}
