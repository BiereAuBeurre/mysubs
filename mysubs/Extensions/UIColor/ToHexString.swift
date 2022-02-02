//
//  ToHexString.swift
//  mysubs
//
//  Created by Manon Russo on 13/01/2022.
//

import UIKit

// Convert UIColor into hexa code color
extension UIColor {
    convenience init?(hex: String) {

            var cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            cleanedHex = cleanedHex.replacingOccurrences(of: "#", with: "")
            let length = cleanedHex.count

            var rgb: UInt64 = 0
            var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 1.0

            guard Scanner(string: cleanedHex).scanHexInt64(&rgb) else { return nil }

            if length == 6 {
                red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
                green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
                blue = CGFloat(rgb & 0x0000FF) / 255.0
            } else if length == 8 {
                red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
                green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
                blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
                alpha = CGFloat(rgb & 0x000000FF) / 255.0
            } else {
                return nil
            }

            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
    
    func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let rgb: Int = (Int)(red*255)<<16 | (Int)(green*255)<<8 | (Int)(blue*255)<<0
        return String(format: "#%06x", rgb)
    }

}
