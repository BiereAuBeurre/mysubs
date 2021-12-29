//
//  EditSubController.swift
//  mysubs
//
//  Created by Manon Russo on 07/12/2021.
//

import UIKit

class EditSubController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    //MARK: LOGO PROPERTY
    var logoHeader = UIImageView()
    
    //MARK: LeftSideStackView properties
    var leftSideStackView = UIStackView()
    var formView = UIStackView()
    var name = InputFormTextField()
    var commitment = InputFormTextField()
    var category = InputFormTextField()
    var info = InputFormTextField()
    
    //MARK: RightSideStackView properties
    var rightSideStackView = UIStackView()
    var price = InputFormTextField()
    var reminder = InputFormTextField()
    var recurrency = InputFormTextField()
    var suggestedLogo = UILabel()
    
    //MARK: FOOTER BUTTON PROPERTIES
    var footerStackView = UIStackView()
    var modifyButton = UIButton()
    var deleteButton = UIButton()
    var viewModel: EditSubViewModel?
    var storageService = StorageService()

    
    var sub: Subscription = Subscription()
    var categorys: [SubCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setUpView()
        activateConstraints()
        configureFormTextField()
        self.category.textField.delegate = self
        print("view model.categorys: \(String(describing: self.viewModel?.categorys))")
        print("categorys only \(categorys)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.subscription = sub
        self.viewModel?.categorys = categorys
    

    }
    
    //MARK: OJBC METHODS
    @objc func doneEditingAction() {
        saveEditedSub()
        viewModel?.goBack()
    }
    
    @objc func didSelectReminderField() {
        print("reminder field has been selected")
        viewModel?.openReminderModal(categorys: categorys)
    }
    
    func saveEditedSub() {
        guard let name = name.textField.text,
              let price = Float(price.textField.text ?? "0")
        else { return }
        sub.setValue(name, forKey: "name")
        sub.setValue(price, forKey: "price")
    }
    
    //MARK: Private METHODS
    private func configureFormTextField() {
        commitment.configureView()
        name.configureView()
        category.configureView()
        info.configureView()
        price.configureView()
        reminder.configureView()
        recurrency.configureView()
    }
    
    private func setUpNavBar() {
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
    
    private func refreshWith(subscription: Subscription) {
//        nameField.text = sub.name
        print("sub.name est : \(String(describing: sub.name))")
    }
    
    private func setUpView() {
        view.backgroundColor = MSColors.background
        logoHeader.translatesAutoresizingMaskIntoConstraints = false
        logoHeader.image = UIImage(named: "ps")
        view.addSubview(logoHeader)
        
        // MARK: FORMVIEW
        formView.translatesAutoresizingMaskIntoConstraints = false
        formView.axis = .horizontal
//        formView.alignment = .top
        formView.spacing = 8
        formView.distribution = .fillProportionally
        view.addSubview(formView)
        
    //MARK: LEFTSIDE STACKVIEW
        leftSideStackView.backgroundColor = .blue
        rightSideStackView.backgroundColor = .yellow
        
        leftSideStackView.translatesAutoresizingMaskIntoConstraints = false
        leftSideStackView.contentMode = .scaleToFill
        leftSideStackView.axis = .vertical
//        leftSideStackView.alignment = .fill
        leftSideStackView.distribution = .fillProportionally
        leftSideStackView.spacing = 8
        //MARK: Adding name field
        leftSideStackView.addArrangedSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.label.text = "Nom"
        name.label.textColor = MSColors.maintext
        name.textField.text = sub.name //viewModel?.subscription?.name
        print("viewmodel.sub.name :\(String(describing: sub.name))")
        name.textField.borderStyle = .roundedRect
        
        //MARK: Adding commitment field
        leftSideStackView.addArrangedSubview(commitment)
        commitment.translatesAutoresizingMaskIntoConstraints = false
        commitment.label.text = "Engagement"
        commitment.textField.text = "Mensuel"
        commitment.label.textColor = MSColors.maintext
        commitment.textField.borderStyle = .roundedRect
        //MARK: Adding category field
        leftSideStackView.addArrangedSubview(category)
        category.translatesAutoresizingMaskIntoConstraints = false
        category.label.text = "Catégorie"
        category.label.textColor = MSColors.maintext
        category.textField.borderStyle = .roundedRect
        category.textField.translatesAutoresizingMaskIntoConstraints = false
        //FIXME: plutôt utiliser addtarget comme commenté ? Ne fonctionne pas donc bouton rajouté sur textfield pour le moment 
        let overlay = UIButton()
        overlay.addTarget(self, action: #selector(didSelectReminderField), for: .touchUpInside)
        //        reminder.textField.leftView.addTarget(self, action: #selector(didSelectReminderField), for: .touchUpInside)
        overlay.sizeToFit()
        category.textField.leftView = overlay
        category.textField.leftViewMode = .always
        //FIXME: display the associated cateogry of the selected subscription (currently displaying the first one of the array)
        category.textField.text = categorys.first?.name//""//subInfo.category // changer pour liste préconçue
//        category.textField.placeholder = categorys.first?.name
        //MARK: Adding info field
        leftSideStackView.addArrangedSubview(info)
        info.translatesAutoresizingMaskIntoConstraints = false
        info.label.text = "INFOS"
        info.label.textColor = MSColors.maintext
        info.textField.borderStyle = .roundedRect
        info.textField.translatesAutoresizingMaskIntoConstraints = false
        info.textField.text = ""//subInfo.extraInfo

        formView.addArrangedSubview(leftSideStackView)
        
    //MARK: RIGHTSIDE STACKVIEW
        rightSideStackView.translatesAutoresizingMaskIntoConstraints = false
        rightSideStackView.contentMode = .scaleToFill
        rightSideStackView.axis = .vertical
//        rightSideStackView.alignment = .fill
        rightSideStackView.distribution = .fillProportionally
        rightSideStackView.spacing = 8
        
        //MARK: Adding price field
        rightSideStackView.addArrangedSubview(price)
        price.translatesAutoresizingMaskIntoConstraints = false
        price.label.text = "Prix"
        price.textField.text = "\(sub.price)" //"\(viewModel?.subscription.price)"
        price.textField.borderStyle = .roundedRect
        price.textField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Adding reminder field
        rightSideStackView.addArrangedSubview(reminder)
        reminder.translatesAutoresizingMaskIntoConstraints = false
        reminder.label.text = "Rappel"
        reminder.backgroundColor = .cyan
        reminder.textField.leftViewMode = .always
        reminder.textField.text = ""//subInfo.reminder
        reminder.textField.borderStyle = .roundedRect
        reminder.textField.translatesAutoresizingMaskIntoConstraints = false
        reminder.textField.allowsEditingTextAttributes = false
        //MARK: Adding recurrency field
        rightSideStackView.addArrangedSubview(recurrency)
        recurrency.backgroundColor = .green
        recurrency.translatesAutoresizingMaskIntoConstraints = false
        recurrency.label.text = "Récurrence"
        recurrency.textField.text = ""//subInfo.paymentRecurrency
        recurrency.textField.borderStyle = .roundedRect
        recurrency.textField.translatesAutoresizingMaskIntoConstraints = false
        formView.addArrangedSubview(rightSideStackView)

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
        formView.heightAnchor.constraint(equalToConstant: 300),
        footerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
        footerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        footerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        footerStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

// MARK: Protocol from UITextFieldDelegate

extension EditSubController: UITextFieldDelegate {
    
    //MARK: making uneditable fields with pickerView
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == category.textField {
          // code which you want to execute when the user touch myTextField
            print("can't edit here")
       }
       return false
    }
    
}
