//
//  NewSubController.swift
//  mysubs
//
//  Created by Manon Russo on 06/12/2021.
//

import UIKit

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
    var subscriptions: [Subscription] = []
    var storageService = StorageService()

//    var subscription1 = Subscription(category: "ciné", commitment: "mensuel", extraInfo: "test", name: "netflix", paymentRecurrency: "mensuel", price: 9.99, reminder: "2j avant", suggestedLogo: "rien")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        activateConstraints()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print("Category : \(viewModel.categ ?? "Missing")")
    }
    
    @objc func addButtonAction(){
        //checking minimum field to fill are
        guard nameField.text != "",
              priceField.text != "" else { return showAlert("Champs manquants", "Merci de renseigner au moins les deux champs obligatoires : \n - nom \n - prix") }
        /// Unwrapping nameField.text.
        guard let name = nameField.text else { return }
//              let price = Float(priceField.text ?? "0")
        var subTest = Subscription(category: nil, commitment: nil, extraInfo: nil, name: name, paymentRecurrency: nil, price: 99, reminder: nil, suggestedLogo: nil)
        subscriptions.append(subTest)
        
        do {
            try storageService.saveSubs(subTest)

        }
        catch { print(error)}
        
        viewModel?.goBack()
        print("voici les abonnements dans editVC :")
        print(subscriptions)
    }
    
    func refreshWith(subscriptions: [Subscription]) {
//        myCollectionView.reloadData()
        
        print("refresh with is read")
    }
    
    func setUpNavBar() {
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

    func setUpView() {
        setUpNavBar()
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
        
//        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        
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
        nameField.text = "Netflix"
        nameField.borderStyle = .roundedRect
        nameField.translatesAutoresizingMaskIntoConstraints = false
        
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
