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
    var colorToConvert = String()
    var subscription: Subscription? {
        didSet {
            refreshSubData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
    }
    
    //Setting values in cells with the object value
    func refreshSubData() {
        subNameLabel.text = subscription?.name
        
        priceLabel.text = "\(subscription?.price.editMaxDigitTo(2).replacingOccurrences(of: ",", with: ".") ?? "0") €"
        if let color = subscription?.color {
            contentView.backgroundColor = UIColor(hex: color)
        } else {
            contentView.backgroundColor = .white
        }

        if let icon = subscription?.icon {
            logo.image = UIImage(data: icon)
        } else {
            logo.image = UIImage(systemName: "circlebadge.fill")
            logo.tintColor = .black
        }
    }
    
    func configureCell() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textColor = .black//MSColors.maintext
        subNameLabel.translatesAutoresizingMaskIntoConstraints = false
        subNameLabel.textColor = .black
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        contentView.alpha = 0.8
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

