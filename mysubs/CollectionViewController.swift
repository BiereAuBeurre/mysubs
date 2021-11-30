//
//  CollectionViewController.swift
//  mysubs
//
//  Created by Manon Russo on 30/11/2021.
//

import UIKit

class CollectionViewController: UIViewController {
    var headerView = HeaderView()
    var categoryLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        activateConstraints()
    }
    

    func setUpView() {
        headerView.configureHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.text = "Ajouter une catégorie"
        categoryLabel.backgroundColor = UIColor(named: "reverse_bg")
        categoryLabel.textColor = UIColor(named: "background")
        view.addSubview(categoryLabel)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            headerView.heightAnchor.constraint(equalToConstant: 100),
            headerView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 0),
            headerView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 0),
            
            categoryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 32),
            categoryLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16)
        ])
    }

}
