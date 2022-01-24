//
//  IconPickerCollectionViewController.swift
//  mysubs
//
//  Created by Manon Russo on 21/01/2022.
//

import UIKit
import Foundation

class IconPickerViewController: UIViewController {
    
    var iconCollectionView: UICollectionView!
    var iconDictionnary = ["custom.airplane.circle.fill", "custom.battery.100.bolt", "custom.bolt.car.fill", "custom.bolt.circle.fill", "custom.book.circle.fill", "custom.briefcase.fill", "custom.car.circle.fill", "custom.cart.circle.fill", "custom.creditcard.circle.fill", "custom.cross.vial", "custom.eye.circle.fill", "custom.fork.knife.circle.fill", "custom.gift.fill", "custom.graduationcap.fill", "custom.headphones.circle.fill", "custom.house.fill", "custom.ivfluid.bag", "custom.lock.fill", "custom.map.circle.fill", "custom.network", "custom.paintpalette.fill", "custom.pc", "custom.phone.fill", "custom.pills.fill", "custom.play.rectangle.fill", "custom.star.fill", "custom.suit.heart.fill", "custom.sun.haze.fill", "custom.sun.max.fill", "custom.testtube.2", "custom.tv.circle.fill", "custom.wifi.circle.fill"]
    
    
    var icon = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpIconPickerUI()
    }


    func setUpIconPickerUI() {
        view.backgroundColor = .systemBackground
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        iconCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        iconCollectionView.register(IconCell.self, forCellWithReuseIdentifier: IconCell.identifier)
        iconCollectionView.backgroundColor = .systemBackground
        iconCollectionView.dataSource = self
        iconCollectionView.delegate = self
        iconCollectionView.translatesAutoresizingMaskIntoConstraints = false
        iconCollectionView.isScrollEnabled = true
        iconCollectionView.isUserInteractionEnabled = true
        view.addSubview(iconCollectionView ?? UICollectionView())
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 4
        layout.itemSize = CGSize(width:(self.iconCollectionView.frame.size.width - 20)/6,height: (self.iconCollectionView.frame.size.height)/16)
        
        NSLayoutConstraint.activate([
            iconCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            iconCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            iconCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            iconCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
//    
}
//    // MARK: UICollectionViewDataSource
extension IconPickerViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconDictionnary.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let iconCell = collectionView.dequeueReusableCell(withReuseIdentifier: IconCell.identifier, for: indexPath) as! IconCell
        iconCell.logo.image = UIImage(named: "\(iconDictionnary[indexPath.row])")
         icon = UIImage(named: "\(iconDictionnary[indexPath.row])") ?? UIImage(systemName: "house.fill")!
        return iconCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        icon = UIImage(named: "\(iconDictionnary[indexPath.row])") ?? UIImage(systemName: "house.fill")!
        print("icon tapped \(String(describing: icon))")
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.layer.backgroundColor = UIColor.lightGray.cgColor
        
    }

}

class IconCell: UICollectionViewCell {
    
    override var isSelected: Bool {
       didSet{
           if self.isSelected {
               UIView.animate(withDuration: 0.3) { // for animation effect
                   self.backgroundColor = .placeholderText
               }
           }
           else {
               UIView.animate(withDuration: 0.3) { // for animation effect
                   self.backgroundColor = .systemBackground
               }
           }
       }
   }
    
    static let identifier = "IconCell"
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
        addSubview(logo)

        // MARK: - Constraints
        NSLayoutConstraint.activate([
            logo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            logo.widthAnchor.constraint(equalToConstant: 42),
            logo.heightAnchor.constraint(equalToConstant: 42),
            logo.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            
        ])
        
    }
    
    
}
