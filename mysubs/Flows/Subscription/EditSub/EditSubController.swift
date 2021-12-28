//
//  EditSubController.swift
//  mysubs
//
//  Created by Manon Russo on 07/12/2021.
//

import UIKit

class EditSubController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    var logoHeader = UIImageView()
    
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
    var reminderField = UITextField()//UIPickerView()
    var recurrency = UILabel()
    var recurrencyField = UITextField()

    //MARK: LOGO PROPERTY
    var suggestedLogo = UILabel()
    var logo = UIImageView()
    
    //MARK: FOOTER BUTTON PROPERTY
    var footerStackView = UIStackView()
    var modifyButton = UIButton()
    var deleteButton = UIButton()
    var viewModel: EditSubViewModel?
    var storageService = StorageService()

    var sub: Subscription = Subscription()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setUpView()
        activateConstraints()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.subscription = sub

    }
    
    @objc func doneEditingAction() {
        saveEditedSub()
        viewModel?.goBack()
    }
    
    @objc func didSelectReminderField() {
        print("reminder field has been selected")
        viewModel?.openReminderModal()
    }
    
    func saveEditedSub() {
        guard let name = nameField.text,
              let price = Float(priceField.text!) else {return }
        sub.setValue(name, forKey: "name")
        sub.setValue(price, forKey: "price")
    }
    
    func setUpNavBar() {
        // DISPLAYING LOGO
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "subs_dark")
        imageView.image = image
        navigationItem.titleView = imageView
        
        //DISPLAYING SETTINGS BUTTON
        navigationItem.leftBarButtonItem?.tintColor = MSColors.background
        //DISPLAYING DONE BUTTON
        let doneButton: UIButton = UIButton(type: .custom)
        doneButton.setTitle("Terminer", for: .normal)
        doneButton.addTarget(self, action: #selector(doneEditingAction), for: .touchUpInside)
        let rightBarButtonItem:UIBarButtonItem = UIBarButtonItem(customView: doneButton)
        rightBarButtonItem.customView = doneButton
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func refreshWith(subscription: Subscription) {
//        nameField.text = sub.name
        print("sub.name est : \(String(describing: sub.name))")
//        myCollectionView.reloadData()
    }
    
    func setUpView(){
        view.backgroundColor = MSColors.background
        logoHeader.translatesAutoresizingMaskIntoConstraints = false
        logoHeader.image = UIImage(named: "ps")
        view.addSubview(logoHeader)
        
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
        name.textColor = MSColors.maintext
        leftSideStackView.addArrangedSubview(nameField)
        nameField.text = sub.name //self.viewModel?.subscription?.name
//        print("viewmodel.sub.name :\(self.viewModel?.subscription?.name)")
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
        commitmentField.text = ""//subInfo.commitment // changer pour liste préconçue
        
        //MARK: Adding category field
        leftSideStackView.addArrangedSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.text = "Catégorie"
        categoryLabel.textColor = MSColors.maintext
        leftSideStackView.addArrangedSubview(categoryField)
        categoryField.borderStyle = .roundedRect
        categoryField.translatesAutoresizingMaskIntoConstraints = false
        categoryField.text = sub.reminder//""//subInfo.category // changer pour liste préconçue
        
        //MARK: Adding info field
        leftSideStackView.addArrangedSubview(info)
        info.translatesAutoresizingMaskIntoConstraints = false
        info.text = "INFOS"
        info.textColor = MSColors.maintext
        leftSideStackView.addArrangedSubview(infoField)
        infoField.borderStyle = .roundedRect
        infoField.translatesAutoresizingMaskIntoConstraints = false
        infoField.text = ""//subInfo.extraInfo
        
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
        priceField.text = "\(sub.price)"
        priceField.borderStyle = .roundedRect
        priceField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Adding reminder field
        rightSideStackView.addArrangedSubview(reminder)
        reminder.translatesAutoresizingMaskIntoConstraints = false
        reminder.text = "Rappel"
//        rightSideStackView.addArrangedSubview(reminderField)
//        reminderField.numberOfComponents = 3
//        reminderField.numberOfRows(inComponent: 10)
        let overlay = UIButton()
        overlay.addTarget(self, action: #selector(didSelectReminderField), for: .touchUpInside)
        overlay.sizeToFit()
        reminderField.leftView = overlay
        reminderField.leftViewMode = .always
        rightSideStackView.addArrangedSubview(reminderField)

        reminderField.text = ""//subInfo.reminder
        reminderField.borderStyle = .roundedRect
        reminderField.translatesAutoresizingMaskIntoConstraints = false
        reminderField.allowsEditingTextAttributes = false
        //MARK: Adding recurrency field
        rightSideStackView.addArrangedSubview(recurrency)
        recurrency.translatesAutoresizingMaskIntoConstraints = false
        recurrency.text = "Récurrence"
        rightSideStackView.addArrangedSubview(recurrencyField)
        recurrencyField.text = ""//subInfo.paymentRecurrency
        recurrencyField.borderStyle = .roundedRect
        recurrencyField.translatesAutoresizingMaskIntoConstraints = false
        
        formView.addArrangedSubview(rightSideStackView)

    //MARK: Adding logo suggestion
        suggestedLogo.translatesAutoresizingMaskIntoConstraints = false
        logo.translatesAutoresizingMaskIntoConstraints = false
        suggestedLogo.text = ""//Logo suggéré"
        logo.image = nil//UIImage(named: "ps")
        
        
    //MARK: FOOTER BUTTONS
        footerStackView.translatesAutoresizingMaskIntoConstraints = false
        footerStackView.axis = .horizontal
        footerStackView.alignment = .fill
        footerStackView.distribution = .fillEqually
        footerStackView.contentMode = .scaleToFill
        footerStackView.spacing = 16
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
