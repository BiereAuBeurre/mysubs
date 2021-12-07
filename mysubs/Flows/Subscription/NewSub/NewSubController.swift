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
    //MARK: LeftSideStackView properties
    var leftSideStackView = UIStackView()
    var formView = UIStackView()
    var name = UILabel()
    var nameField = UITextField()
    var commitment = UILabel()
    var commitmentField = UITextField()
    var category = UILabel()
    var categoryField = UITextField() //A changer pour appeler liste des catégories user
    var info = UILabel()
    var infoField = UITextField()
    
    //MARK: RightSideStackView properties
    var rightSideStackView = UIStackView()
    var price = UILabel()
    var priceField = UITextField()
    var reminder = UILabel()
    var reminderField = UITextField()
    var recurrency = UILabel()
    var recurrencyField = UITextField()

    //MARK: LOGO PROPERTY
    var suggestedLogo = UILabel()
    var logo = UIImageView()
    
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
        
        //DISPLAYING SETTINGS BUTTON
        let menuButton = UIButton(type: .custom)
           menuButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
           menuButton.setImage(UIImage(named:"menu_button"), for: .normal)
        let menuBarItem = UIBarButtonItem(customView: menuButton)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
            currWidth?.isActive = true
            let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
            currHeight?.isActive = true
        navigationItem.leftBarButtonItem = menuBarItem
        
        //DISPLAYING Plus BUTTON
        let plusButton = UIButton(type: .custom)
           plusButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
           plusButton.setImage(UIImage(named:"plus_button"), for: .normal)
        let plusBarItem = UIBarButtonItem(customView: plusButton)
        let plusWidth = plusBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
            plusWidth?.isActive = true
            let plusHeight = plusBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
            plusHeight?.isActive = true
        
        navigationItem.rightBarButtonItem = plusBarItem
        
        
        
        //DISPLAYING "+" BUTTON
//        let rightButton = UIBarButtonItem(image: UIImage(named: "plus_button"),
//                                          style: .plain,
//                                          target: self,
//                                          action: #selector(test))
//        navigationItem.rightBarButtonItem = rightButton
//
//        //
//        let leftButton = UIBarButtonItem(image: UIImage(named: "menu_button")!,
//                                         style: .plain,
//                                         target: self,
//                                         action: #selector(test))
//        navigationItem.leftBarButtonItem = leftButton
//        leftButton.tintColor = #colorLiteral(red: 0.9333333373, green: 0.9333333373, blue: 0.9333333373, alpha: 1)
//        rightButton.tintColor = #colorLiteral(red: 0.9333333373, green: 0.9333333373, blue: 0.9333333373, alpha: 1)
//        leftButton.customView?.frame = CGRect(x: 0, y: 0, width: 3, height: 3)
    }
    
//    @objc func test(){
//        print("test")
//    }
    
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
        view.addSubview(logo)
        view.addSubview(suggestedLogo)
        titleView.addSubview(newSubLabel)
        titleView.addSubview(addButton)
        
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.backgroundColor = UIColor(named: "yellowgrey")
//        separatorLine.backgroundColor = UIColor(named: "mainText")
        view.addSubview(separatorLine)

        // MARK: FORMVIEW
        formView.translatesAutoresizingMaskIntoConstraints = false
        formView.axis = .horizontal
        formView.alignment = .top
        formView.spacing = 8
        leftSideStackView.contentMode = .scaleToFill
        rightSideStackView.contentMode = .scaleToFill
        leftSideStackView.axis = .vertical
        rightSideStackView.axis = .vertical
        view.addSubview(formView)
        formView.addArrangedSubview(leftSideStackView)
        formView.addArrangedSubview(rightSideStackView)
//        formView.backgroundColor = .systemRed
        formView.distribution = .fillEqually
//        leftSideStackView.backgroundColor = .systemBlue
//        rightSideStackView.backgroundColor = .systemCyan
    //MARK: LEFTSIDE STACKVIEW
        leftSideStackView.translatesAutoresizingMaskIntoConstraints = false
        leftSideStackView.alignment = .fill
        leftSideStackView.distribution = .fillEqually
        leftSideStackView.spacing = 8
        //MARK: Adding name field
        leftSideStackView.addArrangedSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Nom"
        name.textColor = UIColor(named: "mainText")
        leftSideStackView.addArrangedSubview(nameField)
        nameField.text = "Netflix"
        nameField.borderStyle = .roundedRect
        nameField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Adding commitment field
        leftSideStackView.addArrangedSubview(commitment)
        commitment.translatesAutoresizingMaskIntoConstraints = false
        commitment.text = "Engagement"
        commitment.textColor = UIColor(named: "mainText")
        leftSideStackView.addArrangedSubview(commitmentField)
        commitmentField.borderStyle = .roundedRect
        commitmentField.translatesAutoresizingMaskIntoConstraints = false
        commitmentField.text = "Annuel" // changer pour liste préconçue
        
        //MARK: Adding category field
        leftSideStackView.addArrangedSubview(category)
        category.translatesAutoresizingMaskIntoConstraints = false
        category.text = "Catégorie"
        category.textColor = UIColor(named: "mainText")
        leftSideStackView.addArrangedSubview(categoryField)
        categoryField.borderStyle = .roundedRect
        categoryField.translatesAutoresizingMaskIntoConstraints = false
        commitmentField.text = "Loisirs" // changer pour liste préconçue
        
        //MARK: Adding info field
        leftSideStackView.addArrangedSubview(info)
        info.translatesAutoresizingMaskIntoConstraints = false
        info.text = "INFOS"
        info.textColor = UIColor(named: "mainText")
        leftSideStackView.addArrangedSubview(infoField)
        infoField.borderStyle = .roundedRect
        infoField.translatesAutoresizingMaskIntoConstraints = false
        infoField.text = "Période d'essai"
        
    //MARK: RIGHTSIDE STACKVIEW
        rightSideStackView.translatesAutoresizingMaskIntoConstraints = false
        rightSideStackView.alignment = .fill
        rightSideStackView.distribution = .fillEqually
        rightSideStackView.spacing = 8
        
        //MARK: Adding price field
        rightSideStackView.addArrangedSubview(price)
        price.translatesAutoresizingMaskIntoConstraints = false
        price.text = "Prix"
        rightSideStackView.addArrangedSubview(priceField)
        priceField.text = "9,99 €"
        priceField.borderStyle = .roundedRect
        priceField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Adding reminder field
        rightSideStackView.addArrangedSubview(reminder)
        reminder.translatesAutoresizingMaskIntoConstraints = false
        reminder.text = "Prix"
        rightSideStackView.addArrangedSubview(reminderField)
        reminderField.text = "2j avant"
        reminderField.borderStyle = .roundedRect
        reminderField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Adding recurrency field
        rightSideStackView.addArrangedSubview(recurrency)
        recurrency.translatesAutoresizingMaskIntoConstraints = false
        recurrency.text = "Récurrence"
        rightSideStackView.addArrangedSubview(recurrencyField)
        recurrencyField.text = "Mensuelle"
        recurrencyField.borderStyle = .roundedRect
        recurrencyField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Adding logo suggestion
        suggestedLogo.translatesAutoresizingMaskIntoConstraints = false
        logo.translatesAutoresizingMaskIntoConstraints = false
        suggestedLogo.text = "Logo suggéré"
        logo.image = UIImage(named: "ps")
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
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
            formView.heightAnchor.constraint(equalToConstant: 350),
            
            suggestedLogo.topAnchor.constraint(equalTo: formView.bottomAnchor, constant: 16),
            suggestedLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logo.topAnchor.constraint(equalTo: suggestedLogo.bottomAnchor, constant: 8),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
,
            logo.widthAnchor.constraint(equalToConstant: 100),
            logo.heightAnchor.constraint(equalToConstant: 100)
            
            
            ])
    }
}
