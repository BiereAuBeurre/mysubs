//
//  ToHexString.swift
//  mysubs
//
//  Created by Manon Russo on 13/01/2022.
//

import UIKit

//MARK: - Convert UIColor into hexa code color
extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
//    convenience init?(hex: String) {
//    var cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
//            cleanedHex = cleanedHex.replacingOccurrences(of: "#", with: "")
//            let length = cleanedHex.count
//
//            var rgb: UInt64 = 0
//            var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 1.0
//
//            guard Scanner(string: cleanedHex).scanHexInt64(&rgb) else { return nil }
//
//            if length == 6 {
//                red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
//                green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
//                blue = CGFloat(rgb & 0x0000FF) / 255.0
//            } else if length == 8 {
//                red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
//                green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
//                blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
//                alpha = CGFloat(rgb & 0x000000FF) / 255.0
//            } else {
//                return nil
//            }
//
//            self.init(red: red, green: green, blue: blue, alpha: alpha)
//        }
}

extension UIColor {
    
    convenience init(hexa: String) {
        var hexFormatted: String = hexa.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: 1)
    }
//    convenience init(hexString: String, alpha: CGFloat = 1.0) {
//        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//        let scanner = Scanner(string: hexString)
//        if (hexString.hasPrefix("#")) {
//            scanner.currentIndex = scanner.string.index(after: scanner.currentIndex)
//        }
//        var color: UInt64 = 0
//        scanner.scanHexInt64(&color)
//        let mask = 0x000000FF
//        let r = Int(color >> 16) & mask
//        let g = Int(color >> 8) & mask
//        let b = Int(color) & mask
//        let red   = CGFloat(r) / 255.0
//        let green = CGFloat(g) / 255.0
//        let blue  = CGFloat(b) / 255.0
//        self.init(red:red, green:green, blue:blue, alpha:alpha)
//    }
//    func fromHexToRGB() -> UIColor/*String*/{
//        var r:CGFloat = 0
//        var g:CGFloat = 0
//        var b:CGFloat = 0
//        var a:CGFloat = 0
//        getRed(&r, green: &g, blue: &b, alpha: &a)
//        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
//        return UIColor(rgb)//String(format:"#%06x", rgb)
//    }
}
