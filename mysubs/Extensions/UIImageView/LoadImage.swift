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
    
    func loadImage(_ urls: String) {
        let urlString = "\(urls)"
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
//            print("loading background image...")
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return }
//            print("diplsaying background image")
            DispatchQueue.main.async  { [weak self] in
//                print("BACKGROUND IMAGE LOADED")
                self?.image = image
            }
        }
    }
}
