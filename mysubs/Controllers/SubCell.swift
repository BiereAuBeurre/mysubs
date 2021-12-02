//
//  SubCell.swift
//  mysubs
//
//  Created by Manon Russo on 02/12/2021.
//

import UIKit

class SubCell: UICollectionViewCell {
        
    @IBOutlet weak var subNameLabel: UILabel!
    
    func setup() {
        subNameLabel?.text = "Netflix test"
        subNameLabel.textColor = .systemYellow
        self.addSubview(subNameLabel)
    }
}
