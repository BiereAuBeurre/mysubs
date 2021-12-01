//
//  BrandInfo.swift
//  mysubs
//
//  Created by Manon Russo on 30/11/2021.
//

import Foundation

struct BrandInfo: Decodable {
    let brandsReturned: [Brand]
}

struct Brand: Decodable {
    let name: String
    let domain: String
    let logo: String
}
