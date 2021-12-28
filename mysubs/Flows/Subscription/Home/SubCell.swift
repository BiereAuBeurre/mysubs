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
    private var priceLabel = UILabel()
    var subscription: Subscription? {
        didSet {
            refreshSubData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemPink
        refreshSubData()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    //Setting values in cells
    func refreshSubData() {
        subNameLabel.text = subscription?.name
        priceLabel.text = "\(subscription?.price ?? 0) €"
    }
    
    func setup() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textColor = MSColors.maintext
        subNameLabel.translatesAutoresizingMaskIntoConstraints = false
        subNameLabel.textColor = .black
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = UIImage(named: "ps")
        addSubview(priceLabel)
        addSubview(logo)
        addSubview(subNameLabel)

        // MARK: - Constraints
        NSLayoutConstraint.activate([
            logo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            logo.widthAnchor.constraint(equalToConstant: 34),
            logo.heightAnchor.constraint(equalToConstant: 34),
            logo.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            subNameLabel.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 16),
            subNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
    }
}

