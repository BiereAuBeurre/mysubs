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
    var name = UILabel()
    var nameFilling = UITextField()
    var commitment = UILabel()
    var commitmentFilling = UITextField()
    var category = UILabel()
    var categoryFilling = UITextField() //A changer pour appeler liste des catégories user
    var info = UILabel()
    var infoFilling = UITextField()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setUpView()
        activateConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setUpNavBar() {
        // DISPLAYING LOGO
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "subs_dark")
        imageView.image = image
        navigationItem.titleView = imageView
        
        //DISPLAYING "+" BUTTON
        let rightButton = UIBarButtonItem(image: UIImage(named: "plus_button"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(test))
        navigationItem.rightBarButtonItem = rightButton
        
        //DISPLAYING SETTINGS BUTTON
        let leftButton = UIBarButtonItem(image: UIImage(named: "menu_button")!,
                                         style: .plain,
                                         target: self,
                                         action: #selector(test))
        navigationItem.leftBarButtonItem = leftButton
        leftButton.tintColor = #colorLiteral(red: 0.9333333373, green: 0.9333333373, blue: 0.9333333373, alpha: 1)
        rightButton.tintColor = #colorLiteral(red: 0.9333333373, green: 0.9333333373, blue: 0.9333333373, alpha: 1)
    }
    
    @objc func test(){
        print("test")
    }
    
    func setUpView() {
        view.backgroundColor = UIColor(named: "background")
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
        leftSideStackView.alignment = .fill
        leftSideStackView.distribution = .fillEqually
        //MARK: Adding name field
        leftSideStackView.addArrangedSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Nom"
        leftSideStackView.addArrangedSubview(nameFilling)
        nameFilling.text = "netflix"
        nameFilling.borderStyle = .roundedRect
        nameFilling.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Adding commitment field
        leftSideStackView.addArrangedSubview(commitment)
        commitment.translatesAutoresizingMaskIntoConstraints = false
        commitment.text = "Engagement"
        leftSideStackView.addArrangedSubview(commitmentFilling)
        commitmentFilling.borderStyle = .roundedRect
        commitmentFilling.translatesAutoresizingMaskIntoConstraints = false
        commitmentFilling.text = "Mensuel" // changer pour liste préconçue
        
        //MARK: Adding category field
        leftSideStackView.addArrangedSubview(category)
        category.translatesAutoresizingMaskIntoConstraints = false
        category.text = "Catégorie"
        leftSideStackView.addArrangedSubview(categoryFilling)
        categoryFilling.borderStyle = .roundedRect
        categoryFilling.translatesAutoresizingMaskIntoConstraints = false
        commitmentFilling.text = "Loisirs" // changer pour liste préconçue
        
        //MARK: Adding info field
        leftSideStackView.addArrangedSubview(info)
        info.translatesAutoresizingMaskIntoConstraints = false
        info.text = "INFOS"
        leftSideStackView.addArrangedSubview(infoFilling)
        infoFilling.borderStyle = .roundedRect
        infoFilling.translatesAutoresizingMaskIntoConstraints = false
        infoFilling.text = "Période d'essai"

        rightSideStackView.translatesAutoresizingMaskIntoConstraints = false
        rightSideStackView.alignment = .fill
        rightSideStackView.distribution = .fillEqually
        formView.translatesAutoresizingMaskIntoConstraints = false
        formView.axis = .horizontal
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
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
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
            formView.heightAnchor.constraint(equalToConstant: 400)
//            formView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            
            
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
