//
//  IconPickerCollectionViewController.swift
//  mysubs
//
//  Created by Manon Russo on 21/01/2022.
//

import UIKit
import Foundation
private let reuseIdentifier = "Cell"

class IconPickerViewController: UIViewController {
    var collectionView: UICollectionView!
    var iconDictionnary = ["custom.airplane.circle.fill", "custom.battery.100.bolt", "custom.bolt.car.fill", "custom.bolt.circle.fill", "custom.book.circle.fill", "custom.briefcase.fill", "custom.car.circle.fill", "custom.cart.circle.fill", "custom.creditcard.circle.fill", "custom.cross.vial", "custom.eye.circle.fill", "custom.fork.knife.circle.fill", "custom.gift.fill", "custom.graduationcap.fill", "custom.headphones.circle.fill", "custom.house.fill", "custom.ivfluid.bag", "custom.lock.fill", "custom.map.circle.fill", "custom.network", "custom.paintpalette.fill", "custom.pc", "custom.phone.fill", "custom.pills.fill", "custom.play.rectangle.fill", "custom.star.fill", "custom.suit.heart.fill", "custom.sun.haze.fill", "custom.sun.max.fill", "custom.testtube.2", "custom.tv.circle.fill", "custom.wifi.circle.fill"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }


    func setUpUI() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(IconCell.self, forCellWithReuseIdentifier: IconCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.isUserInteractionEnabled = true
        view.addSubview(collectionView ?? UICollectionView())
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 4
        layout.itemSize = CGSize(width:(self.collectionView.frame.size.width - 20)/2,height: (self.collectionView.frame.size.height)/3)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
}
    // MARK: UICollectionViewDataSource
extension IconPickerViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        iconDictionnary.count
    }
    
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return iconDictionnary.count
    }


     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let iconCell = collectionView.dequeueReusableCell(withReuseIdentifier: IconCell.identifier, for: indexPath) as! IconCell
        iconCell.logo.image = UIImage(named: "\(iconDictionnary[indexPath.row])")
    
        return iconCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedCell = comics[indexPath.row]
//        cellTapped(comic: selectedCell)
    }

}

class IconCell: UICollectionViewCell {
    static let identifier = "IconCell"
    
//    private var subNameLabel = UILabel()
     var logo = UIImageView()


    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    func setup() {
        logo.translatesAutoresizingMaskIntoConstraints = false
//        logo.image = UIImage(named: "custom.pc")
        logo.addShadow()
        addSubview(logo)

        // MARK: - Constraints
        NSLayoutConstraint.activate([
            logo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            logo.widthAnchor.constraint(equalToConstant: 34),
            logo.heightAnchor.constraint(equalToConstant: 34),
            logo.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
        ])
        
    }
}
