//
//  String+Extensions.swift
//  GorillaBook
//
//  Created by Andres Felipe Rojas R. on 8/11/20.
//

import Foundation

extension Double {
    func getDateFromUnixTimestamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"

        let date = Date(timeIntervalSince1970: self)
        return formatter.string(from: date)
    }
}
