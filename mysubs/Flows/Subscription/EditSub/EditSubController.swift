//
//  EditSubController.swift
//  mysubs
//
//  Created by Manon Russo on 07/12/2021.
//

import UIKit

class EditSubController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    var sub: String?

    
    var logoHeader = UIImageView()
    var validateButton = UIButton()
    
    //MARK: LeftSideStackView properties
    var leftSideStackView = UIStackView()
    var formView = UIStackView()
    var name = UILabel()
    var nameField = UITextField()
    var commitment = UILabel()
    var commitmentField = UITextField()
    var categoryLabel = UILabel()
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
    
    //MARK: FOOTER BUTTON PROPERTY
    var footerStackView = UIStackView()
    var modifyButton = UIButton()
    var deleteButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpNavBar()
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
    }
    
    func setUpView(){
        view.backgroundColor = MSColors.background
        logoHeader.translatesAutoresizingMaskIntoConstraints = false
        logoHeader.image = UIImage(named: "ps")
        view.addSubview(logoHeader)
        validateButton.translatesAutoresizingMaskIntoConstraints = false
        validateButton.setTitle("Valider", for: .normal)
        validateButton.setTitleColor(UIColor(named: "maintext"), for: .normal)
        view.addSubview(validateButton)
        
        // MARK: FORMVIEW
        formView.translatesAutoresizingMaskIntoConstraints = false
        formView.axis = .horizontal
        formView.alignment = .top
        formView.spacing = 8
        formView.distribution = .fillEqually
        view.addSubview(formView)
        
    //MARK: LEFTSIDE STACKVIEW
        leftSideStackView.translatesAutoresizingMaskIntoConstraints = false
        leftSideStackView.contentMode = .scaleToFill
        leftSideStackView.axis = .vertical
        leftSideStackView.alignment = .fill
        leftSideStackView.distribution = .fillEqually
        leftSideStackView.spacing = 8
        
        //MARK: Adding name field
        leftSideStackView.addArrangedSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Nom"
        name.textColor = UIColor(named: "maintext")
        leftSideStackView.addArrangedSubview(nameField)
        nameField.text = "Netflix"
        nameField.borderStyle = .roundedRect
        nameField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Adding commitment field
        leftSideStackView.addArrangedSubview(commitment)
        commitment.translatesAutoresizingMaskIntoConstraints = false
        commitment.text = "Engagement"
        commitment.textColor = UIColor(named: "maintext")
        leftSideStackView.addArrangedSubview(commitmentField)
        commitmentField.borderStyle = .roundedRect
        commitmentField.translatesAutoresizingMaskIntoConstraints = false
        commitmentField.text = "Annuel" // changer pour liste préconçue
        
        //MARK: Adding category field
        leftSideStackView.addArrangedSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.text = "Catégorie"
        categoryLabel.textColor = UIColor(named: "maintext")
        leftSideStackView.addArrangedSubview(categoryField)
        categoryField.borderStyle = .roundedRect
        categoryField.translatesAutoresizingMaskIntoConstraints = false
        commitmentField.text = "Loisirs" // changer pour liste préconçue
        
        //MARK: Adding info field
        leftSideStackView.addArrangedSubview(info)
        info.translatesAutoresizingMaskIntoConstraints = false
        info.text = "INFOS"
        info.textColor = UIColor(named: "maintext")
        leftSideStackView.addArrangedSubview(infoField)
        infoField.borderStyle = .roundedRect
        infoField.translatesAutoresizingMaskIntoConstraints = false
        infoField.text = "Période d'essai"
        
        formView.addArrangedSubview(leftSideStackView)
        
    //MARK: RIGHTSIDE STACKVIEW
        rightSideStackView.translatesAutoresizingMaskIntoConstraints = false
        rightSideStackView.contentMode = .scaleToFill
        rightSideStackView.axis = .vertical
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
        reminder.text = "Rappel"
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
        
        formView.addArrangedSubview(rightSideStackView)

    //MARK: Adding logo suggestion
        suggestedLogo.translatesAutoresizingMaskIntoConstraints = false
        logo.translatesAutoresizingMaskIntoConstraints = false
        suggestedLogo.text = "Logo suggéré"
        logo.image = UIImage(named: "ps")
        
        
    //MARK: FOOTER BUTTONS
        footerStackView.translatesAutoresizingMaskIntoConstraints = false
        footerStackView.axis = .horizontal
        footerStackView.alignment = .fill
        footerStackView.distribution = .fillEqually
        footerStackView.contentMode = .scaleToFill
        footerStackView.spacing = 16
//        footerStackView.layer.borderWidth = 2
//        footerStackView.layer.borderColor = #colorLiteral(red: 0.2237218916, green: 0.2467257082, blue: 0.2812070549, alpha: 1)
        modifyButton.backgroundColor = UIColor(named: "reverse_bg")
        modifyButton.addCornerRadius()
        deleteButton.backgroundColor = UIColor(named: "reverse_bg")
        deleteButton.addCornerRadius()
        view.addSubview(footerStackView)
        modifyButton.translatesAutoresizingMaskIntoConstraints = false
        
        deleteButton.titleLabel?.textAlignment = .center
        footerStackView.addArrangedSubview(modifyButton)
        modifyButton.setTitle("Modifier", for: .normal)
        modifyButton.titleLabel!.textAlignment = .center
        modifyButton.setTitleColor(MSColors.background, for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        footerStackView.addArrangedSubview(deleteButton)
        deleteButton.setTitle("Supprimer", for: .normal)
        deleteButton.setTitleColor(MSColors.background, for: .normal)
        
        
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
        logoHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        logoHeader.widthAnchor.constraint(equalToConstant: 50),
        logoHeader.heightAnchor.constraint(equalToConstant: 50),
        logoHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
        validateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        validateButton.centerYAnchor.constraint(equalTo: logoHeader.centerYAnchor, constant: 0),
        formView.topAnchor.constraint(equalTo: logoHeader.bottomAnchor, constant: 16),
        formView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        formView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        formView.heightAnchor.constraint(equalToConstant: 350),
        footerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
        footerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        footerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        footerStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
