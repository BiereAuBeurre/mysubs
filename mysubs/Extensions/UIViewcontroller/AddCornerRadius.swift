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
