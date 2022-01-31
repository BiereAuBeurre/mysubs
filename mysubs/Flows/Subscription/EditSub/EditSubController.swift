//
//  EditSubController.swift
//  mysubs
//
//  Created by Manon Russo on 07/12/2021.
//

import UIKit

class EditSubController: UIViewController {
    
    weak var coordinator: AppCoordinator?

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

    var notifAuthorizer = UIStackView()
    var notifTitle = UILabel()
    var switchNotif = UISwitch()
    var notifSettingsStackView = UIStackView()
    var colorAndIconStackView = UIStackView()

    var colorStackView = UIStackView()
    var iconStackView = UIStackView()
    var colorTitle = UIButton()
    var colorPreview = UIImageView()
    var iconTitle = UIButton()
    var iconPreview = UIImageView()
    
    //    let userNotificationCenter = UNUserNotificationCenter.current()

    
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
        let alert = UIAlertController(title: "Sélectionner une icône", message: "", preferredStyle: .actionSheet)
        alert.setValue(iconPickerVC, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: Strings.genericCancel, style: .cancel, handler: { (UIAlertAction) in
        }))
        
        //MARK: - replace selectedRow protocol method since action happen here
        alert.addAction(UIAlertAction(title: "Sélectionner", style: .default, handler: { [self] (UIAlertAction) in
            //Convert icon selected from uiimage to data, then displaying it and assigning to viewmodel.icon
            if let icon = iconPickerVC.icon.pngData() {
                iconPreview.image = UIImage(data: icon)
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
            self.colorPreview.backgroundColor = colorPicker.selectedColor
//            self.colorChoosen.textField.backgroundColor =
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
    
    @objc
    func displayNotifSettings() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.commitmentStackView.isHidden.toggle()
            self.recurrency.isHidden.toggle()
            self.reminder.isHidden.toggle()
        }, completion: nil)
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

            if input == recurrency {
                input.textField.text = "\(valueNumber) \(valueType.stringValue)"
                viewModel?.recurrencyValue = valueNumber
                viewModel?.recurrencyType = valueType
                viewModel?.recurrency = "\(valueNumber) \(valueType.stringValue)"

            } else {
                input.textField.text = "\(valueNumber) \(valueType.stringValue) avant"
                viewModel?.reminderValue = valueNumber
                viewModel?.reminderType = valueType
                viewModel?.reminder = "\(valueNumber) \(valueType.stringValue)"

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
                return componentDayMonthYear[row].stringValue
            }
        }
        
        else {
            if component == 0 {
                return ("\(componentNumber[row])")
            }
            else  {
                return componentDayMonthYear[row].stringValue
            }
        }
    }
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
//            if pickerView == recurrencyPickerView {
                return 2
//            } else {
//                return 3
//            }
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
        self.colorPreview.backgroundColor = viewController.selectedColor
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
            iconPreview.image = UIImage(data: icon)
        }
        if let color = viewModel?.color {
            self.colorPreview.backgroundColor = UIColor(hex: color)
        }
        if let date = viewModel?.date {
            commitmentDate.date = date
            switchNotif.isOn = true
            commitmentStackView.isHidden = false
            recurrency.isHidden = false
            reminder.isHidden = false
        } else {
            switchNotif.isOn = false
            commitmentStackView.isHidden = true
            recurrency.isHidden = true
            reminder.isHidden = true
        }
        
        name.text = viewModel?.name
        price.text = "\(viewModel?.price ?? 0)"
        reminder.text = "\(viewModel?.reminder?.localized ?? "") avant"
        recurrency.text = "Tous les \(viewModel?.recurrency?.localized ?? "")"

    }
    private func setUpView() {
        // MARK: SETTING TITLE
        view.backgroundColor = MSColors.background

        //Hide until user touche switch button
//        commitmentStackView.isHidden = true
//        recurrency.isHidden = true
//        reminder.isHidden = true
        
//        //MARK: Adding name field
        name.fieldTitle = "Nom"
        name.text = viewModel?.name
        // configurer la inpute view pour le name
        name.textFieldInputView = UIView()
        name.textField.addTarget(self, action: #selector(nameFieldTextDidChange), for: .editingChanged)
        name.configureView()
        formView.addArrangedSubview(name)

        //MARK: price
        price.fieldTitle = "Prix"
        price.textField.addTarget(self, action: #selector(priceFieldTextDidChange), for: .editingChanged)
        price.configureView()
        formView.addArrangedSubview(price)
        
        colorTitle.setTitle("Couleur ▼", for: .normal)
        colorTitle.setTitleColor(MSColors.maintext, for: .normal)
        colorTitle.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)
        
        colorPreview.backgroundColor = .white
        colorPreview.addCornerRadius()
        let tapColorPreview = UITapGestureRecognizer(target: self, action: #selector(showColorPicker))
        colorPreview.addGestureRecognizer(tapColorPreview)
        colorPreview.isUserInteractionEnabled = true
        colorStackView.axis = .vertical
        colorStackView.contentMode = .left
        colorStackView.addArrangedSubview(colorTitle)
        colorStackView.addArrangedSubview(colorPreview)
        colorStackView.alignment = .leading
        colorAndIconStackView.addArrangedSubview(colorStackView)

        
        iconTitle.setTitle("Icône ▼", for: .normal)
        iconTitle.setTitleColor(MSColors.maintext, for: .normal)
        iconTitle.addTarget(self, action: #selector(showIconPicker), for: .touchUpInside)
        iconStackView.axis = .vertical
        iconPreview.backgroundColor = .white
        iconPreview.addCornerRadius()
        let tapIconPreview = UITapGestureRecognizer(target: self, action: #selector(showIconPicker))
        iconPreview.addGestureRecognizer(tapIconPreview)
        iconPreview.isUserInteractionEnabled = true
        iconPreview.contentMode = .scaleAspectFit
        iconStackView.addArrangedSubview(iconTitle)
        iconStackView.addArrangedSubview(iconPreview)
        iconStackView.alignment = .leading
        colorAndIconStackView.addArrangedSubview(iconStackView)
        
        colorAndIconStackView.axis = .horizontal
        colorAndIconStackView.distribution = .fillEqually
        colorAndIconStackView.spacing = 34
        formView.addArrangedSubview(colorAndIconStackView)
        
        notifTitle.text = "Activer un rappel avant paiement"
        notifAuthorizer.addArrangedSubview(notifTitle)
        
//        if viewModel?.date == nil {
//            switchNotif.isOn = false
//            commitmentStackView.isHidden = true
//            recurrency.isHidden = true
//            reminder.isHidden = true
//        } else {
//            switchNotif.isOn = true
//            commitmentStackView.isHidden = false
//            recurrency.isHidden = false
//            reminder.isHidden = false
//        }
        switchNotif.addTarget(self, action: #selector(displayNotifSettings), for: .touchUpInside)
        notifAuthorizer.addArrangedSubview(switchNotif)
        notifAuthorizer.axis = .horizontal
        notifSettingsStackView.addArrangedSubview(notifAuthorizer)

//        notifAuthorizer.spacing = 16
        notifAuthorizer.distribution = .equalCentering
        notifSettingsStackView.axis = .vertical
        notifSettingsStackView.spacing = 8
        formView.addArrangedSubview(notifSettingsStackView)
    
        //MARK: DELETE BUTTON
        deleteButton.titleLabel?.textAlignment = .center
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setTitle(" Supprimer", for: .normal)
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = MSColors.maintext
        deleteButton.titleLabel?.font = MSFonts.title2
        deleteButton.setTitleColor(MSColors.maintext, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteSub), for: .touchUpInside)
        view.addSubview(deleteButton)

        
        //MARK: Adding commitment field
        
        commitmentStackView.axis = .vertical
        commitmentStackView.alignment = .leading
        commitmentStackView.distribution = .fillEqually
        commitmentStackView.translatesAutoresizingMaskIntoConstraints = false

        commitmentTitle.textColor = MSColors.maintext
        commitmentTitle.text = "Dernier paiement"
        commitmentTitle.translatesAutoresizingMaskIntoConstraints = false
        commitmentDate.translatesAutoresizingMaskIntoConstraints = false
        commitmentDate.contentMode = .topLeft

        commitmentDate.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
        commitmentDate.datePickerMode = .date
        commitmentDate.translatesAutoresizingMaskIntoConstraints = false
        commitmentDate.locale = Locale.init(identifier: "fr_FR")
        commitmentDate.date = Date.now
        commitmentStackView.addArrangedSubview(commitmentTitle)
        commitmentStackView.addArrangedSubview(commitmentDate)
        notifSettingsStackView.addArrangedSubview(commitmentStackView)
        
        //MARK: - reminder
        reminder.fieldTitle = "Rappel"
        reminder.textField.allowsEditingTextAttributes = false
        reminder.shouldBehaveAsButton = true
        reminder.addTarget(self, action: #selector(changeReminder), for: .touchUpInside)
        reminder.configureView()
        notifSettingsStackView.addArrangedSubview(reminder)

        //MARK: - recurrency field
        recurrency.fieldTitle = "Cycle"
        recurrency.shouldBehaveAsButton = true
        recurrency.addTarget(self, action: #selector(changeReccurency), for: .touchUpInside)
        recurrency.configureView()
        notifSettingsStackView.addArrangedSubview(recurrency)
        
        // MARK: FORMVIEW
        formView.translatesAutoresizingMaskIntoConstraints = false
        formView.axis = .vertical
        formView.spacing = 8
        view.addSubview(formView)
 
        NSLayoutConstraint.activate([
            formView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            formView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: 16),
            deleteButton.topAnchor.constraint(greaterThanOrEqualTo: formView.bottomAnchor, constant: 16),
            iconPreview.heightAnchor.constraint(equalToConstant: 40),
            iconPreview.widthAnchor.constraint(equalToConstant: 80),
            colorPreview.heightAnchor.constraint(equalToConstant: 40),
            colorPreview.widthAnchor.constraint(equalToConstant: 80),
            iconStackView.trailingAnchor.constraint(greaterThanOrEqualTo: colorAndIconStackView.trailingAnchor, constant: -8),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 8),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 16),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
            ])
    }
//    private func setUpView() {
//        name.configureView()
//        price.configureView()
//        reminder.configureView()
//        recurrency.configureView()
//        colorChoosen.configureView()
//        view.backgroundColor = MSColors.background
//
//        iconButton.translatesAutoresizingMaskIntoConstraints = false
//        iconButton.titleLabel?.textAlignment = .center
//        iconButton.setTitle("Icône ▼", for: .normal)
//        iconButton.tintColor = MSColors.maintext
//        iconButton.titleLabel?.font = MSFonts.title2
//        iconButton.setTitleColor(MSColors.maintext, for: .normal)
//        iconButton.addTarget(self, action: #selector(showIconPicker), for: .touchUpInside)
//        view.addSubview(iconButton)
//
//        //MARK: iconView
//        iconView.translatesAutoresizingMaskIntoConstraints = false
//        iconView.tintColor = MSColors.maintext
//        view.addSubview(iconView)
//
//        // MARK: FORMVIEW
//        formView.translatesAutoresizingMaskIntoConstraints = false
//        formView.axis = .vertical
//        formView.alignment = .fill
//        formView.spacing = 8
//        formView.distribution = .fillEqually
//        view.addSubview(formView)
//
//        //MARK: Adding name field
//        formView.addArrangedSubview(name)
//        name.fieldTitle = "Nom"
//        // configurer la inpute view pour le name
//        name.textFieldInputView = UIView()
//
//        //MARK: Adding price field
//        price.fieldTitle = "Prix"
//        formView.addArrangedSubview(price)
//
//        //MARK: Adding commitment field
//        commitmentTitle.text = "Dernier paiement"
//        commitmentDate.datePickerMode = .date
//        commitmentDate.translatesAutoresizingMaskIntoConstraints = false
//        configureCommitment()
//        commitmentDate.locale = Locale.init(identifier: "fr_FR")
//        formView.addArrangedSubview(commitmentStackView)
//
//
//        //MARK: Adding reminder field
//        reminder.fieldTitle = "Rappel"
//        reminder.textField.allowsEditingTextAttributes = false
//        reminder.shouldBehaveAsButton = true
//        reminder.addTarget(self, action: #selector(changeReminder), for: .touchUpInside)
//        formView.addArrangedSubview(reminder)
//
//        //MARK: Adding recurrency field
//        recurrency.fieldTitle = "Cycle"
//        recurrency.shouldBehaveAsButton = true
//        recurrency.addTarget(self, action: #selector(changeReccurency), for: .touchUpInside)
//        formView.addArrangedSubview(recurrency)
//
//        colorChoosen.fieldTitle = "Couleur ▼"
//        colorChoosen.shouldBehaveAsButton = true
//        colorChoosen.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)
//        colorChoosen.textField.text = "➕"
//        colorChoosen.textField.textAlignment = .right
//        colorChoosen.stackView.alignment = .leading
//        formView.addArrangedSubview(colorChoosen)
//
//        //MARK: - action send values to viewModel for being save as new sub values
//        name.textField.addTarget(self, action: #selector(nameFieldTextDidChange), for: .editingChanged)
//        price.textField.addTarget(self, action: #selector(priceFieldTextDidChange), for: .editingChanged)
//        commitmentDate.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
//        //MARK: DELETE BUTTON
//        deleteButton.titleLabel?.textAlignment = .center
//        deleteButton.translatesAutoresizingMaskIntoConstraints = false
//        deleteButton.setTitle(" Supprimer", for: .normal)
//        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
//        deleteButton.tintColor = MSColors.maintext
//        deleteButton.titleLabel?.font = MSFonts.title2
//        deleteButton.setTitleColor(MSColors.maintext, for: .normal)
//        deleteButton.addTarget(self, action: #selector(deleteSub), for: .touchUpInside)
//        view.addSubview(deleteButton)

//
//        NSLayoutConstraint.activate([
//        iconButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
//        iconButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//        iconView.topAnchor.constraint(equalTo: iconButton.bottomAnchor, constant: 16),
//        iconView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//        formView.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 8),
//        formView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: 16),
//        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 16),
//        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 16),
//        deleteButton.topAnchor.constraint(equalTo: formView.bottomAnchor, constant: 16),
//        deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//        deleteButton.heightAnchor.constraint(equalToConstant: 40),
//        colorChoosen.textField.widthAnchor.constraint(equalToConstant: 150)
//        ])
//    }
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
