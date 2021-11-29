//
//  HeaderView.swift
//  mysubs
//
//  Created by Manon Russo on 29/11/2021.
//

import UIKit

final class HeaderView: UIView {
    // MARK: Properties
    private var backgroundView = UIView()
    private var mysubsLogo = UIImageView()
    private var menuButton = UIButton()
    private var plusButton = UIButton()
    
    // MARK: - Setting constraints and displaying rules
    private func configureHeaerView() {
        
    // MARK: Background view color block
    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    backgroundView.contentMode = ContentMode.scaleToFill
    backgroundView.backgroundColor = #colorLiteral(red: 0.1335636079, green: 0.1629035473, blue: 0.2006920278, alpha: 1)
        
    // MARK: logo
        mysubsLogo.image = UIImage(named: "subs_dark")
    }
}
