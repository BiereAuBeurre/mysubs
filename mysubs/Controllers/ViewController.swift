//
//  ViewController.swift
//  mysubs
//
//  Created by Manon Russo on 25/11/2021.
//

import UIKit

class ViewController: UIViewController {

    var headerView = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
        activateConstraints()
    }

    func setUpView() {
        headerView.configureHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            headerView.heightAnchor.constraint(equalToConstant: 100),
            headerView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 0),
            headerView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 0)
        ])
    }
}

