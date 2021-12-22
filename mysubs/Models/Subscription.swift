////
////  SubInfo.swift
////  mysubs
////
////  Created by Manon Russo on 01/12/2021.
////
//
//import Foundation
//
//struct Subscription: Decodable {
//    let category: String?
//    let commitment: String?
//    let extraInfo: String?
//    var name: String
//    let paymentRecurrency: String?
//    var price: Float
//    let reminder: String?
//    let suggestedLogo: String?
//}
//
//extension Subscription {
//    init(from subscriptionEntity: SubscriptionEntity) {
//        self.category = subscriptionEntity.category ?? ""
//        self.commitment = subscriptionEntity.commitment ?? ""
//        self.extraInfo = subscriptionEntity.extraInfo ?? ""
//        self.name = subscriptionEntity.name ?? ""
//        self.paymentRecurrency = subscriptionEntity.paymentRecurrency ?? ""
//        self.price = subscriptionEntity.price
//        self.reminder = subscriptionEntity.reminder ?? ""
//        self.suggestedLogo = subscriptionEntity.suggestedLogo ?? ""
//    }
//
//}
