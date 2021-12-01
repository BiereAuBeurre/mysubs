//
//  NavigationBar.swift
//  mysubs
//
//  Created by Manon Russo on 01/12/2021.
//

import UIKit

class NavigationBar: UIViewController, UINavigationBarDelegate {
    
    var navBar: UINavigationBar!

    func setUp() {
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        navBar.delegate = self
        navBar.translatesAutoresizingMaskIntoConstraints = false
//        let navItem = UINavigationItem(title: "MySubs")
//        navBar.items = [navItem]
        navBar.isHidden = false
        navBar.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1647058824, blue: 0.2, alpha: 1)

        view.addSubview(navBar)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            navBar.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 0),
            navBar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 0),
            navBar.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
