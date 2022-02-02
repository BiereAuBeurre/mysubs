//
//  FakeData.swift
//  mysubsTests
//
//  Created by Manon Russo on 01/02/2022.
//
import Foundation

@testable import mysubs

final class FakeData {
    static var subscription1 = Subscription() {
        didSet {
            subscription1.name = "Coucou"
            subscription1.price = 2
            subscription1.reminder = "2j"
            subscription1.commitment = Date()
            subscription1.color = ""
            subscription1.icon = nil
            subscription1.paymentRecurrency = ""
        }
    }
    
    static var subscription2 = Subscription() {
        didSet {
            subscription2.name = "Coucou"
            subscription2.price = 2
            subscription2.reminder = "2j"
            subscription2.commitment = Date()
            subscription2.color = ""
            subscription2.icon = nil
            subscription2.paymentRecurrency = ""
        }
    }
    
}
