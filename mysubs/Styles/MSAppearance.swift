//
//  MSAppearance.swift
//  mysubs
//
//  Created by Manon Russo on 09/12/2021.
//

import UIKit

enum MSAppearance {
    static func setUp() {
        //exemple othmane

        UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 0.1325160861, green: 0.1609178782, blue: 0.1995640397, alpha: 1)
        UINavigationBar.appearance().standardAppearance = UINavigationBarAppearance()
        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBarAppearance()
        UINavigationBar.appearance().scrollEdgeAppearance?.backgroundColor = #colorLiteral(red: 0.1325160861, green: 0.1609178782, blue: 0.1995640397, alpha: 1)
        UINavigationBar.appearance().standardAppearance.backgroundColor = #colorLiteral(red: 0.1325160861, green: 0.1609178782, blue: 0.1995640397, alpha: 1)
        
        
        
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
//        imageView.contentMode = .scaleAspectFit
//            let image = UIImage(named: "subs_dark")
//            imageView.image = image
//            navigationItem.titleView = imageView
//        //DISPLAYING SETTINGS BUTTON
//        let menuButton = UIButton(type: .custom)
//           menuButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
//           menuButton.setImage(UIImage(named:"menu_button"), for: .normal)
//        let menuBarItem = UIBarButtonItem(customView: menuButton)
//        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
//            currWidth?.isActive = true
//            let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
//            currHeight?.isActive = true
//
////        navigationItem.leftBarButtonItem = menuBarItem
//
//        //DISPLAYING Plus BUTTON
//        let plusButton = UIButton(type: .custom)
//           plusButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
//           plusButton.setImage(UIImage(named:"plus_button"), for: .normal)
//        let plusBarItem = UIBarButtonItem(customView: plusButton)
//        let plusWidth = plusBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
//            plusWidth?.isActive = true
//            let plusHeight = plusBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
//            plusHeight?.isActive = true
//        navigationItem.rightBarButtonItem = plusBarItem
        
        
    }
}
