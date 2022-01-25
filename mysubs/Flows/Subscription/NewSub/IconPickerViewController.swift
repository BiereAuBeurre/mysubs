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
    var icon = UIImage()
    var iconDictionnary = ["airplane.circle.fill", "battery.100.bolt","music.note.list", "bolt.car.fill", "book.circle.fill", "briefcase.fill", "car.circle.fill", "cart.circle.fill", "creditcard.circle.fill", "cross.vial", "eye.circle.fill", "fork.knife.circle.fill", "gift.fill", "graduationcap.fill", "headphones.circle.fill", "house.fill", "ivfluid.bag", "lock.fill", "map.circle.fill", "network", "paintpalette.fill", "pc", "phone.fill", "pills.fill", "play.rectangle.fill", "star.fill", "suit.heart.fill", "sun.haze.fill", "sun.max.fill", "testtube.2", "tv.circle.fill", "wifi.circle.fill", "bolt.circle.fill"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    func setUpUI() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 4
        iconCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        iconCollectionView.register(IconCell.self, forCellWithReuseIdentifier: IconCell.identifier)
        iconCollectionView.backgroundColor = .systemBackground
        iconCollectionView.dataSource = self
        iconCollectionView.delegate = self
        iconCollectionView.translatesAutoresizingMaskIntoConstraints = false
        iconCollectionView.isScrollEnabled = true
        iconCollectionView.isUserInteractionEnabled = true
        layout.itemSize = CGSize(width:(self.iconCollectionView.frame.size.width - 20)/6,height: (self.iconCollectionView.frame.size.height)/16)

        view.backgroundColor = .systemBackground
        view.addSubview(iconCollectionView ?? UICollectionView())
        
        NSLayoutConstraint.activate([
            iconCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            iconCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            iconCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            iconCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
// MARK: - UICollectionViewDataSource & Delegate protocol methods
extension IconPickerViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconDictionnary.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let iconCell = collectionView.dequeueReusableCell(withReuseIdentifier: IconCell.identifier, for: indexPath) as! IconCell
        iconCell.logo.image = UIImage(systemName: "\(iconDictionnary[indexPath.row])")
         icon = UIImage(systemName: "\(iconDictionnary[indexPath.row])") ?? UIImage(systemName: "house.fill")!
        return iconCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        icon = UIImage(systemName: "\(iconDictionnary[indexPath.row])") ?? UIImage(systemName: "house.fill")!
    }

}
