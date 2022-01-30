//
//  EditSubController.swift
//  mysubs
//
//  Created by Manon Russo on 07/12/2021.
//

import UIKit

class EditSubController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    //MARK: -LOGO PROPERTY
    var iconButton = UIButton()
    var iconView = UIImageView()
    //MARK: -LeftSideStackView properties
    var formView = UIStackView()
    var name = InputFormTextField()
    var commitmentTitle = UILabel()
    var commitmentDate = UIDatePicker()
    let commitmentStackView = UIStackView()
    //MARK: -RightSideStackView properties
    var price = InputFormTextField()
    var reminder = InputFormTextField()
    var recurrency = InputFormTextField()
    var suggestedLogo = UILabel()
    //MARK: -FOOTER BUTTON PROPERTIES
    var footerStackView = UIStackView()
    var modifyButton = UIButton()
    var deleteButton = UIButton()
    var viewModel: EditSubViewModel?
    var storageService = StorageService()

    let componentNumber = Array(stride(from: 1, to: 30 + 1, by: 1))
    let componentDayMonthYear = [Calendar.Component.day, Calendar.Component.weekOfMonth, Calendar.Component.month, Calendar.Component.year] 
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedColor = ""

    var selectedRow = 0
    var reminderPickerView = UIPickerView()
    var recurrencyPickerView = UIPickerView()
    let iconPickerVC = IconPickerViewController()

    
    var colorChoosen = InputFormTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.viewModel?.subscription = sub
//        self.viewModel?.categorys = categorys
    }
    
    //MARK: -OJBC METHODS
    
    @objc
    func deleteSub() {
        deletingAlert()
    }
    
    @objc
    func doneEditingAction() {
        
        viewModel?.saveEditedSub()
        viewModel?.goBack()
        
    }
    
    @objc
    func showIconPicker() {
        iconPickerVC.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let alert = UIAlertController(title: "Sélectionner un icône", message: "", preferredStyle: .actionSheet)
        alert.setValue(iconPickerVC, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: Strings.genericCancel, style: .cancel, handler: { (UIAlertAction) in
        }))
        
        //MARK: - replace selectedRow protocol method since action happen here
        alert.addAction(UIAlertAction(title: "Sélectionner", style: .default, handler: { [self] (UIAlertAction) in
            //Convert icon selected from uiimage to data, then displaying it and assigning to viewmodel.icon
            if let icon = iconPickerVC.icon.pngData() {
                iconView.image = UIImage(data: icon)
//                iconButton.setImage(UIImage(data: icon), for: .normal)
                viewModel?.icon = icon
            }
        }))
        self.present(alert, animated: true, completion: nil)
                                      
        }
    
    @objc
    func showColorPicker()  {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        colorPicker.title = "Couleurs"
        self.present(colorPicker, animated: true) {
            self.colorChoosen.textField.backgroundColor = colorPicker.selectedColor
        }
    }
    
    @objc
    func nameFieldTextDidChange(textField: UITextField) {
        viewModel?.name = textField.text
    }
    
    @objc
    func priceFieldTextDidChange(textField: UITextField) {
        viewModel?.price = Float(textField.text ?? "") ?? 0
    }
    
//    @objc
//    func reminderFieldDidChange() {
//        self.selectedRow = reminderPickerView.selectedRow(inComponent: 0)
//        let valueNumber = self.componentNumber[reminderPickerView.selectedRow(inComponent: 0)]
//        let valueType = self.componentDayMonthYear[reminderPickerView.selectedRow(inComponent: 1)]
//        let string2 = "avant"
//        viewModel?.reminder = "\(valueNumber) \(valueType) \(string2)"
//
////        viewModel?.subscription.reminder = "\(valueNumber) \(valueType) \(string2)"
//        viewModel?.reminderValue = valueNumber
//        viewModel?.reminderType2 = valueType
//
////        viewModel?.subscription.reminder = reminderPickerView
//    }
    
    @objc
    func textFieldDidChange(textField: UITextField) {
        //delegate.textFieldDidCha
    }
    
    @objc
    func dateDidChange() {
        viewModel?.date = commitmentDate.date
    }
    
    
    @objc func changeReminder() {
        print(#function)
        showPicker(reminderPickerView, reminder)
    }
    
    @objc func changeReccurency() {
        print(#function)
        showPicker(recurrencyPickerView, recurrency)
    }
    //MARK: -Private METHODS

    private func deletingAlert() {
        let alert = UIAlertController(title: "Suppression de l'abonnement", message: "Êtes-vous sur de vouloir supprimer l'abonnement \(viewModel?.name ?? "") ?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: Strings.genericConfirm, style: .default) { [unowned self] action in
            viewModel?.delete()
            viewModel?.goBack()
        }
        let cancelAction = UIAlertAction(title: Strings.genericCancel, style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func refreshWith(subscription: Subscription) {
//        viewModel?.subscription = Subs
//        nameField.text = sub.name
    }
    
    private func showPicker(_ picker : UIPickerView, _ input: InputFormTextField) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        picker.dataSource = self
        picker.delegate = self
        picker.selectRow(selectedRow, inComponent: 0, animated: false)
        vc.view.addSubview(picker)
        picker.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        picker.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = input
        alert.popoverPresentationController?.sourceRect = input.bounds
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: { (UIAlertAction) in
        }))
        //MARK: - replace selectedRow protocol method since action happen here
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { [self] (UIAlertAction) in
            self.selectedRow = picker.selectedRow(inComponent: 0)
            let valueNumber = self.componentNumber[picker.selectedRow(inComponent: 0)]
            let valueType = self.componentDayMonthYear[picker.selectedRow(inComponent: 1)]
            let string2 = "avant"

            if input == recurrency {
                input.textField.text = "\(valueNumber) \(valueType.stringValue)"
                viewModel?.recurrencyValue = valueNumber
                viewModel?.recurrencyType = valueType
                viewModel?.recurrency = "\(valueNumber) \(valueType.stringValue)"

            } else {
                input.textField.text = "\(valueNumber) \(valueType.stringValue) \(string2)"
                viewModel?.reminderValue = valueNumber
                viewModel?.reminderType = valueType
                viewModel?.reminder = "\(valueNumber) \(valueType.stringValue) \(string2)"

            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


//MARK: - PICKERVIEW SETTINGS
extension EditSubController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == recurrencyPickerView {
            if component == 0 {
                return ("\(componentNumber[row])")
            } else {
                return ("\(componentDayMonthYear[row].stringValue)")
            }
        }
        
        else {
            if component == 0 {
                return ("\(componentNumber[row])")
            }
            else if component == 1 {
                return ("\(componentDayMonthYear[row].stringValue)")
            } else {
                return "avant"
            }
        }
    }
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            if pickerView == recurrencyPickerView {
                return 2
            } else {
                return 3
            }
        }
    
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if pickerView == recurrencyPickerView {
                if component == 0 {
                    return componentNumber.count
                } else {
                    return componentDayMonthYear.count
                }
            } else {
                if component == 0 {
                    return componentNumber.count
                } else if component == 1 {
                    return componentDayMonthYear.count
                } else {
                    return 1
                }
            }
        }
}

//MARK: - COLOR PICKER SETTINGS
extension EditSubController: UIColorPickerViewControllerDelegate {
    ///  Called on every color selection done in the picker.
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.colorChoosen.textField.backgroundColor = viewController.selectedColor
        self.selectedColor = viewController.selectedColor.toHexString()
        viewModel?.color = selectedColor
    }
}
// MARK: -SETTING UP ALL UI
extension EditSubController {
    
    private func setUpUI() {
        setUpNavBar()
        setUpView()
        setUpData()
    }
    
    private func configureCommitment() {
        commitmentStackView.addArrangedSubview(commitmentTitle)
        commitmentStackView.addArrangedSubview(commitmentDate)
        commitmentStackView.axis = .vertical
        commitmentStackView.alignment = .leading
        commitmentDate.backgroundColor = MSColors.background
        commitmentTitle.textColor = MSColors.maintext
        commitmentDate.contentMode = .top
        commitmentStackView.translatesAutoresizingMaskIntoConstraints = false
        commitmentTitle.translatesAutoresizingMaskIntoConstraints = false
        commitmentDate.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            commitmentTitle.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    private func setUpNavBar() {
        // MARK: DISPLAYING LOGO
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "subs_dark")
        imageView.image = image
        navigationItem.titleView = imageView
        //MARK: DISPLAYING DONE BUTTON
        let doneButton: UIButton = UIButton(type: .custom)
        doneButton.setTitle("Terminer", for: .normal)
        doneButton.addTarget(self, action: #selector(doneEditingAction), for: .touchUpInside)
        let rightBarButtonItem:UIBarButtonItem = UIBarButtonItem(customView: doneButton)
        rightBarButtonItem.customView = doneButton
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setUpData() {
        if let icon = viewModel?.icon {
//            iconHeader.setImage(UIImage(data: icon), for: .normal)
            iconView.image = UIImage(data: icon)
        }
//        else {
//            iconHeader.setImage(UIImage(systemName: "pc"), for: .normal)
//        }
//        else {
//            iconView.setImage(UIImage(systemName: "pc"), for: .normal)
//        }
        name.text = viewModel?.name
        price.text = "\(viewModel?.price ?? 0)"
        commitmentDate.date = viewModel?.date ?? Date.now
        reminder.text = "\(viewModel?.reminder ?? "")"
        recurrency.text = "\(viewModel?.recurrency ?? "")"
        colorChoosen.textField.backgroundColor = UIColor(hex: viewModel?.color ?? "#F7CE46")
    }
    
    private func setUpView() {
        name.configureView()
        price.configureView()
        reminder.configureView()
        recurrency.configureView()
        colorChoosen.configureView()
        view.backgroundColor = MSColors.background
        
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        iconButton.titleLabel?.textAlignment = .center
        iconButton.setTitle("Icône ▼", for: .normal)
        iconButton.tintColor = MSColors.maintext
        iconButton.titleLabel?.font = MSFonts.title2
        iconButton.setTitleColor(MSColors.maintext, for: .normal)
        iconButton.addTarget(self, action: #selector(showIconPicker), for: .touchUpInside)
        view.addSubview(iconButton)
        
        //MARK: iconView
        iconView.translatesAutoresizingMaskIntoConstraints = false
//        iconView.titleLabel?.textAlignment = .center
//        iconView.setTitle("Icône ▼", for: .normal)
        iconView.tintColor = MSColors.maintext
//        iconView.titleLabel?.font = MSFonts.title2
//        iconView.setTitleColor(MSColors.maintext, for: .normal)
//        iconView.addTarget(self, action: #selector(showIconPicker), for: .touchUpInside)
        view.addSubview(iconView)
        
        // MARK: FORMVIEW
        formView.translatesAutoresizingMaskIntoConstraints = false
        formView.axis = .vertical
        formView.alignment = .fill
        formView.spacing = 8
        formView.distribution = .fillEqually
        view.addSubview(formView)
        
        //MARK: Adding name field
        formView.addArrangedSubview(name)
        name.fieldTitle = "Nom"
        // configurer la inpute view pour le name
        name.textFieldInputView = UIView()
        
        //MARK: Adding price field
        price.fieldTitle = "Prix"
        formView.addArrangedSubview(price)
        
        //MARK: Adding commitment field
        commitmentTitle.text = "Dernier paiement"
        commitmentDate.datePickerMode = .date
        commitmentDate.translatesAutoresizingMaskIntoConstraints = false
        configureCommitment()
        commitmentDate.locale = Locale.init(identifier: "fr_FR")
        formView.addArrangedSubview(commitmentStackView)


        //MARK: Adding reminder field
        reminder.fieldTitle = "Rappel"
        reminder.textField.allowsEditingTextAttributes = false
        reminder.shouldBehaveAsButton = true
        reminder.addTarget(self, action: #selector(changeReminder), for: .touchUpInside)
        formView.addArrangedSubview(reminder)

        //MARK: Adding recurrency field
        recurrency.fieldTitle = "Cycle"
        recurrency.shouldBehaveAsButton = true
        recurrency.addTarget(self, action: #selector(changeReccurency), for: .touchUpInside)
        formView.addArrangedSubview(recurrency)
        
        colorChoosen.fieldTitle = "Couleur ▼"
        colorChoosen.shouldBehaveAsButton = true
        colorChoosen.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)
        colorChoosen.textField.text = "➕"
        colorChoosen.textField.textAlignment = .right
        colorChoosen.stackView.alignment = .leading
        formView.addArrangedSubview(colorChoosen)

        //MARK: - action send values to viewModel for being save as new sub values
        name.textField.addTarget(self, action: #selector(nameFieldTextDidChange), for: .editingChanged)
        price.textField.addTarget(self, action: #selector(priceFieldTextDidChange), for: .editingChanged)
        commitmentDate.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
        //MARK: DELETE BUTTON
        view.addSubview(deleteButton)
        deleteButton.titleLabel?.textAlignment = .center
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setTitle(" Supprimer", for: .normal)
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = MSColors.maintext
        deleteButton.titleLabel?.font = MSFonts.title2
        deleteButton.setTitleColor(MSColors.maintext, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteSub), for: .touchUpInside)
   
        NSLayoutConstraint.activate([
            iconButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
        iconButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
        iconView.topAnchor.constraint(equalTo: iconButton.bottomAnchor, constant: 16),
        iconView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        formView.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 8),
        formView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: 16),
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 16),
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 16),
        deleteButton.topAnchor.constraint(equalTo: formView.bottomAnchor, constant: 16),
        deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        deleteButton.heightAnchor.constraint(equalToConstant: 40),
        colorChoosen.textField.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}



// Adding category field
//        leftSideStackView.addArrangedSubview(category)
//        category.translatesAutoresizingMaskIntoConstraints = false
//        category.label.text = "Catégorie"
//        category.label.textColor = MSColors.maintext
//        category.textField.borderStyle = .roundedRect
//        category.textField.translatesAutoresizingMaskIntoConstraints = false
//FIXME: plutôt utiliser addtarget comme commenté ? Ne fonctionne pas donc bouton rajouté sur textfield pour le moment
//        category.textField.addTarget(self, action: #selector(didSelectReminderField), for: .touchUpInside)
//FIXME: display the associated cateogry of the selected subscription (currently displaying the first one of the array)
//        category.textField.text = categorys.first?.name//""//subInfo.category // changer pour liste préconçue
//        category.textField.placeholder = categorys.first?.name
