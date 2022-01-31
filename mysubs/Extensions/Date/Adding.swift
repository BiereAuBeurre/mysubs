//
//  Adding.swift
//  mysubs
//
//  Created by Manon Russo on 14/01/2022.
//

import Foundation

extension Date {
    
    var calendar: Calendar {
        Calendar.current
    }
    
    func add9hour() -> Date?{
        return calendar.startOfDay(for: self).adding(.hour, value: 10)
    }
    
    func adding(_ component: Calendar.Component, value: Int) -> Date? {
    // FIXME:
      //  calendar.startOfDay(for: <#T##Date#>) //retourne minuit + rajoute 9h
        return calendar.date(byAdding: component, value: value, to: self)
    }
        
}

