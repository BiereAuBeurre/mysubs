//
//  LoadImage.swift
//  mysubs
//
//  Created by Manon Russo on 01/12/2021.
//

import UIKit
extension UIImageView {
    
    func addShadow() {
          self.layer.shadowOffset = CGSize(width: 1, height: 1)
          self.layer.shadowOpacity = 0.8
          self.layer.shadowRadius = 2
          self.layer.shadowColor = UIColor.black.cgColor
      }
}
