//
//  SubCell.swift
//  mysubs
//
//  Created by Manon Russo on 02/12/2021.
//

import UIKit

class SubCell: UICollectionViewCell {
        
    private var subNameLabel = UILabel()
    private var stackView = UIStackView()
    
    func setup() {
        subNameLabel.translatesAutoresizingMaskIntoConstraints = false
        subNameLabel.text = "Netflix test"
        subNameLabel.textColor = .systemYellow
        
        addSubview(subNameLabel)
        
        // MARK: - Constraints
        NSLayoutConstraint.activate([
            subNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            subNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            subNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8),
            subNameLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
    }
}
