//
//  Category.swift
//  mysubs
//
//  Created by Manon Russo on 01/12/2021.
//

import Foundation

struct CategoryInfo: Decodable {
    let name: String
}

extension CategoryInfo {
    init(from category: CategoryEntity) {
        self.name = category.name ?? ""
    }
}
