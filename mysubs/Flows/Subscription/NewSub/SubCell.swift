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
    private var logo = UIImageView()
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        subNameLabel.translatesAutoresizingMaskIntoConstraints = false
        subNameLabel.text = "Photoshop"
        subNameLabel.textColor = .systemYellow
        subNameLabel.tintColor = .systemPink
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = UIImage(named: "ps")
        stackView.addArrangedSubview(logo)
        stackView.addArrangedSubview(subNameLabel)
        addSubview(stackView)

        // MARK: - Constraints
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            logo.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            logo.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0),
            logo.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0),
            logo.widthAnchor.constraint(equalToConstant: 34),
//
//            subNameLabel.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 8),
//            subNameLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 8),
//            subNameLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8)
//            logo.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            logo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
//            logo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            logo.widthAnchor.constraint(equalToConstant: 40),
//            logo.trailingAnchor.constraint(equalTo: subNameLabel.leadingAnchor, constant: 16),
//            subNameLabel.trailingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 16),
//            subNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            subNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8),
//            subNameLabel.widthAnchor.constraint(equalToConstant: 100),
        ])
        
    }
}
