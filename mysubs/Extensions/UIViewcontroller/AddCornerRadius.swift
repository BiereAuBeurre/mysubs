//
//  AddCornerRadius.swift
//  mysubs
//
//  Created by Manon Russo on 01/12/2021.
//

import UIKit

extension UIButton {
    func addCornerRadius() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }
}

extension UICollectionViewCell {
    func addCornerRadius() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
}

extension UIImageView {
    func addCornerRadius() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
}
