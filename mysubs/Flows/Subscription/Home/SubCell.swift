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
    var subscriptionTest = Subscription(category: "ciné", commitment: "mensuel", extraInfo: "test", name: "SUBTEST", paymentRecurrency: "mensuel", price: 9.99, reminder: "2j avant", suggestedLogo: "rien")
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemPink//UIColor(named: "background")
        refreshSubData()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    var subscriptions: Subscription? {
        didSet {
            refreshSubData()
        }
    }
    private var homeVC = HomeViewController()
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        subNameLabel.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
//    }
    
    //Setting values in cells
    func refreshSubData() {
        subNameLabel.text = subscriptionTest.name
    }
    
    func setup() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = "\(subscriptionTest.price) €"
        priceLabel.textColor = MSColors.maintext
        
        subNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        subNameLabel.text = subInfo.name
        subNameLabel.textColor = .systemYellow
        subNameLabel.tintColor = .systemPink
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
