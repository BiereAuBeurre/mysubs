//
//  CategoriesCell.swift
//  mysubs
//
//  Created by Manon Russo on 27/12/2021.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    static let identifier = "CategoriesCell"
    
    var category: SubCategory? {
        didSet {
            titleLabel.text = category?.name
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
       // label.text = "loisirs"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemPink
//        contentView.layer.borderColor = (MSColors.background as! CGColor)
        contentView.layer.borderWidth = 1
        titleLabel.textColor = MSColors.maintext
        titleLabel.textAlignment = .center
        //Addcornerradius()
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented in categories cell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
}

