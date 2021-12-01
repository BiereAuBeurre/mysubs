//
//  Category.swift
//  mysubs
//
//  Created by Manon Russo on 01/12/2021.
//

import Foundation

struct CategoryEntity {
    let name: String
}

extension CategoryEntity {
    init(from category: CategoryEntity) {
        self.name = category.name
    }
}
