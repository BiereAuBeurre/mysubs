//
//  NewSubController.swift
//  mysubs
//
//  Created by Manon Russo on 06/12/2021.
//

import UIKit

class NewSubController: UIViewController, UINavigationBarDelegate {
//    var navBar: UINavigationBar!
//    let navBarAppearance = UINavigationBarAppearance()
    var newSubLabel = UILabel()
    var titleView = UIView()
    var addButton = UIButton()
    var separatorLine = UIView()
    
    var leftSideStackView = UIStackView()
    var rightSideStackView = UIStackView()
    var formView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpNavBar()
        setUpView()
        activateConstraints()
        // Do any additional setup after loading the view.
    }
    
//    func setUpNavBar() {
//        navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
//        navBar.delegate = self
//        navBar.translatesAutoresizingMaskIntoConstraints = false
//        navBar.isHidden = false
//        navBar.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1647058824, blue: 0.2, alpha: 1)
//        let imageTitleBar = UIImage(named: "subs_dark")
//        self.navigationItem.titleView = UIImageView(image: imageTitleBar)
//        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
//        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
//        view.addSubview(navBar)
//    }
    
    func setUpView() {
        newSubLabel.text = "Nouvel abonnement"
        newSubLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        newSubLabel.textColor = UIColor(named: "mainText")
        newSubLabel.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Ajouter", for: .normal)
        addButton.titleLabel?.adjustsFontForContentSizeCategory = true
        addButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        addButton.setTitleColor(UIColor(named: "yellowgrey"), for: UIControl.State.normal)

        view.addSubview(titleView)
        titleView.addSubview(newSubLabel)
        titleView.addSubview(addButton)
        
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.backgroundColor = UIColor(named: "yellowgrey")
//        separatorLine.backgroundColor = UIColor(named: "mainText")
        view.addSubview(separatorLine)

        leftSideStackView.translatesAutoresizingMaskIntoConstraints = false
        rightSideStackView.translatesAutoresizingMaskIntoConstraints = false
        formView.translatesAutoresizingMaskIntoConstraints = false
        formView.axis = .vertical
        leftSideStackView.axis = .vertical
        rightSideStackView.axis = .vertical
        view.addSubview(formView)
        formView.addArrangedSubview(leftSideStackView)
        formView.addArrangedSubview(rightSideStackView)
        formView.backgroundColor = .systemRed
        formView.distribution = .fillEqually
        leftSideStackView.backgroundColor = .systemBlue
        rightSideStackView.backgroundColor = .systemCyan
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
//            navBar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
//            navBar.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 0),
//            navBar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 0),
//            navBar.heightAnchor.constraint(equalToConstant: 100),
//            titleView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 16),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleView.heightAnchor.constraint(equalToConstant: 30),
            
            newSubLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 0),
            newSubLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 0),
//            newSubLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: 16),
            newSubLabel.heightAnchor.constraint(equalToConstant: 20),
            
            addButton.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 0),
            addButton.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -0),
            addButton.heightAnchor.constraint(equalToConstant: 20),
            
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            separatorLine.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 8),
            separatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            separatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            separatorLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            formView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 16),
            formView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            formView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            formView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
//            leftSideStackView.leadingAnchor.constraint(equalTo: formView.leadingAnchor),
//            leftSideStackView.topAnchor.constraint(equalTo: formView.topAnchor),
//            leftSideStackView.bottomAnchor.constraint(equalTo: formView.bottomAnchor),
//            rightSideStackView.trailingAnchor.constraint(equalTo: formView.trailingAnchor),
//            rightSideStackView.topAnchor.constraint(equalTo: formView.topAnchor),
//            rightSideStackView.bottomAnchor.constraint(equalTo: formView.bottomAnchor)
//
//
            ])
    }
}
