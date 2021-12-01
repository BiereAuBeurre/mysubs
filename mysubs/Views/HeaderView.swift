//
//  HeaderView.swift
//  mysubs
//
//  Created by Manon Russo on 29/11/2021.
//
//import UIKit

//final class HeaderView: UIView {
//    // MARK: Properties
//    private var backgroundView = UIView()
//    private var mysubsLogo = UIImageView()
//    private var menuButton = UIButton()
//    private var plusButton = UIButton()
//
//    //MARK: Setting constraints and displaying rules
//    func configureHeaderView() {
//
//        //MARK: DISPLAYING RULES : Background View
//        backgroundView.translatesAutoresizingMaskIntoConstraints = false
//        backgroundView.contentMode = ContentMode.scaleToFill
//        backgroundView.backgroundColor = #colorLiteral(red: 0.1335636079, green: 0.1629035473, blue: 0.2006920278, alpha: 1)
//        addSubview(backgroundView)
//
//        //MARK: DISPLAYING RULES : Logo
//        mysubsLogo.translatesAutoresizingMaskIntoConstraints = false
//        mysubsLogo.image = UIImage(named: "subs_dark")
//        backgroundView.addSubview(mysubsLogo)
//
//        //MARK: DISPLAYING RULES : menuButton
//        menuButton.translatesAutoresizingMaskIntoConstraints = false
//        menuButton.setImage(UIImage(named: "menu_button"), for: UIControl.State.normal)
//        menuButton.tintColor = #colorLiteral(red: 0.9333333373, green: 0.9333333373, blue: 0.9333333373, alpha: 1)
//        backgroundView.addSubview(menuButton)
//
//        //MARK: DISPLAYING RULES : plusButton
//        plusButton.translatesAutoresizingMaskIntoConstraints = false
//        plusButton.setImage(UIImage(named: "plus_button"), for: UIControl.State.normal)
//        plusButton.tintColor = #colorLiteral(red: 0.9333333373, green: 0.9333333373, blue: 0.9333333373, alpha: 1)
//        backgroundView.addSubview(plusButton)
//
//        //MARK: Constraints
//        NSLayoutConstraint.activate([
//            //BACKGROUND
//            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
//            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
//            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
//            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
//
//            //MENU BUTTON
//            menuButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 32),
//            menuButton.heightAnchor.constraint(equalToConstant: 35),
//            menuButton.widthAnchor.constraint(equalToConstant: 35),
//            menuButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 50),
//            menuButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -15),
//
//            //LOGO
//            mysubsLogo.heightAnchor.constraint(equalToConstant: 56),
//            mysubsLogo.widthAnchor.constraint(equalToConstant: 111),
//            mysubsLogo.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -8),
//            mysubsLogo.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
//
//            // PLUS BUTTON
//            plusButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -32),
//            plusButton.heightAnchor.constraint(equalToConstant: 35),
//            plusButton.widthAnchor.constraint(equalToConstant: 35),
//            plusButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 50),
//            plusButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -15)
//        ])
//    }
//}
