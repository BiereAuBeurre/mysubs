//
//  File.swift
//  mysubs
//
//  Created by Manon Russo on 02/02/2022.
//

import Foundation

extension Float {
    /// This methods define the number of decimal numbers to show.
     func editMaxDigitTo(_ numberOfDigit: Int) -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = numberOfDigit
        return String(formatter.string(from: number) ?? "\(self)")
    }
}
