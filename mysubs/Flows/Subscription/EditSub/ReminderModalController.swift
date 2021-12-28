//
//  ReminderModalController.swift
//  mysubs
//
//  Created by Manon Russo on 28/12/2021.
//

import Foundation
import UIKit

class ReminderModalController: UIViewController {
    
    var test = UILabel()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBasicUI()
    }
    
    func setUpBasicUI() {
        test.text = "coucou test"
        view.addSubview(test)
        view.backgroundColor = MSColors.background
        test.translatesAutoresizingMaskIntoConstraints = false
        test.textAlignment = .center
        NSLayoutConstraint.activate([
            test.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            test.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            test.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            test.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8)
        ])
    }
}
