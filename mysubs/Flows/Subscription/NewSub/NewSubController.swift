//
//  NewSubController.swift
//  mysubs
//
//  Created by Manon Russo on 06/12/2021.
//

import UIKit
import CoreData

class NewSubController: UIViewController, UINavigationBarDelegate {
    let navBarAppearance = UINavigationBarAppearance()
    var newSubLabel = UILabel()
    var titleView = UIView()
    var separatorLine = UIView()
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
    
    var viewModel: NewSubViewModel?

    var storageService = StorageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print("Category : \(viewModel.categ ?? "Missing")")
    }
    
    //MARK: -OBJC METHODs
    @objc func addButtonAction() {
        if viewModel?.name == nil {
            showAlert("Champ manquant", "ajouter au moins un nom")
            return
        } else {
            viewModel?.saveSub()
            print("dans add button action, ajouté à \(String(describing: viewModel?.subscriptions))")
        }
    }
    
    @objc func nameFieldTextDidChange(textField: UITextField) {
        viewModel?.name = textField.text
    }
    //MARK: - PRIVATES METHODS
    private func refreshWith(subscriptions: [Subscription]) {
        // myCollectionView.reloadData()
        print("refresh with is read")
    }
    
}

extension NewSubController {
    func canSaveStatusDidChange(canSave: Bool) {
        self.navigationItem.rightBarButtonItem?.isEnabled = canSave
    }
}

// MARK: - SET UP ALL UI
extension NewSubController {
    
    private func setUpUI() {
        setUpNavBar()
        setUpView()
        activateConstraints()
    }
    
    private func setUpNavBar() {
        // DISPLAYING LOGO
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "subs_dark")
        imageView.image = image
        navigationItem.titleView = imageView
        
        //DISPLAYING ADD SUB BUTTON
        let addSubButton: UIButton = UIButton(type: .custom)
        addSubButton.setTitle("Ajouter", for: .normal)
        addSubButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        let rightBarButtonItem:UIBarButtonItem = UIBarButtonItem(customView: addSubButton)
        rightBarButtonItem.customView = addSubButton
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    private func setUpView() {
        // MARK: SETTING TITLE
        view.backgroundColor = MSColors.background
        newSubLabel.text = "Nouvel abonnement"
        newSubLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        newSubLabel.textColor = MSColors.maintext
        newSubLabel.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
    
        view.addSubview(titleView)
        view.addSubview(logo)
        view.addSubview(suggestedLogo)
        titleView.addSubview(newSubLabel)
                
        // MARK: SEPARATOR LINE VIEW
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.backgroundColor = UIColor(named: "yellowgrey")
        view.addSubview(separatorLine)

        // MARK: FORMVIEW
        formView.translatesAutoresizingMaskIntoConstraints = false
        formView.axis = .horizontal
        formView.alignment = .top
        formView.distribution = .fillEqually
        formView.spacing = 8
        view.addSubview(formView)
        formView.addArrangedSubview(leftSideStackView)
        formView.addArrangedSubview(rightSideStackView)
        
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
        name.textColor = MSColors.maintext
        leftSideStackView.addArrangedSubview(nameField)
        nameField.text = ""
        nameField.borderStyle = .roundedRect
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.addTarget(self, action: #selector(nameFieldTextDidChange), for: .editingChanged)
        
        //MARK: Adding commitment field
        leftSideStackView.addArrangedSubview(commitment)
        commitment.translatesAutoresizingMaskIntoConstraints = false
        commitment.text = "Engagement"
        commitment.textColor = MSColors.maintext
        leftSideStackView.addArrangedSubview(commitmentField)
        commitmentField.borderStyle = .roundedRect
        commitmentField.translatesAutoresizingMaskIntoConstraints = false
        commitmentField.text = "Annuel" // changer pour liste préconçue
        
        //MARK: Adding category field
        leftSideStackView.addArrangedSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.text = "Catégorie"
        categoryLabel.textColor = MSColors.maintext
        leftSideStackView.addArrangedSubview(categoryField)
        categoryField.borderStyle = .roundedRect
        categoryField.translatesAutoresizingMaskIntoConstraints = false
        commitmentField.text = "Loisirs" // changer pour liste préconçue
        
        //MARK: Adding info field
        leftSideStackView.addArrangedSubview(info)
        info.translatesAutoresizingMaskIntoConstraints = false
        info.text = "INFOS"
        info.textColor = MSColors.maintext
        leftSideStackView.addArrangedSubview(infoField)
        infoField.borderStyle = .roundedRect
        infoField.translatesAutoresizingMaskIntoConstraints = false
        infoField.text = "Période d'essai"
        
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
        priceField.text = ""
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
            newSubLabel.heightAnchor.constraint(equalToConstant: 20),
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
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logo.widthAnchor.constraint(equalToConstant: 100),
            logo.heightAnchor.constraint(equalToConstant: 100)
            ])
    }
}
