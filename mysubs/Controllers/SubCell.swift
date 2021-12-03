//
//  SubCell.swift
//  mysubs
//
//  Created by Manon Russo on 02/12/2021.
//

import UIKit

class SubCell: UICollectionViewCell {
    static let identifier = "SubCell"
    private var subNameLabel = UILabel()
    private var stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBlue
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subNameLabel.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
    func setup() {
        subNameLabel.translatesAutoresizingMaskIntoConstraints = false
        subNameLabel.text = "Netflix test"
        subNameLabel.textColor = .systemYellow
        subNameLabel.tintColor = .systemPink
        
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
