//
//  Calendar.Component.swift
//  mysubs
//
//  Created by Manon Russo on 26/01/2022.
//

import Foundation

extension Calendar.Component {
    var stringValue: String {
        switch self {
        case .day:
            return "Jour(s)"
        case .weekOfMonth:
            return "Semaine(s)"
        case .month:
            return "Mois"
        case .year:
            return "Année(s)"
        default:
            return "todo"
        }
    }
}
