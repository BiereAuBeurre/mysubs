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
    var iconHeader = UIButton()
    //MARK: -LeftSideStackView properties
//    var leftSideStackView = UIStackView()
    var formView = UIStackView()
    var name = InputFormTextField()
    var commitmentTitle = UILabel()
    var commitmentDate = UIDatePicker()
    let commitmentStackView = UIStackView()

    var info = InputFormTextField()
    //MARK: -RightSideStackView properties
//    var rightSideStackView = UIStackView()
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
        let alert = UIAlertController(title: "Select icon", message: "", preferredStyle: .actionSheet)
        alert.setValue(iconPickerVC, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        //MARK: - replace selectedRow protocol method since action happen here
        alert.addAction(UIAlertAction(title: "Selectionner", style: .default, handler: { [self] (UIAlertAction) in
            //Convert view model icon from data to uiimage, then displaying it
//            viewModel?.icon = iconPickerVC.icon.pngData()
            
            if let icon = iconPickerVC.icon.pngData() {
                iconHeader.setImage(UIImage(data: icon), for: .normal)
                viewModel?.icon = icon
            }
            
            
//            iconHeader.setImage(iconPickerVC.icon, for: .normal)
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
    //MARK: -Private METHODS
    
    
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
        viewModel?.subscription.commitment = commitmentDate.date
    }
    
    
    @objc func changeReminder() {
        print(#function)
        showPicker(reminderPickerView, reminder)
    }
    
    @objc func changeReccurency() {
        print(#function)

        showPicker(recurrencyPickerView, recurrency)
//        viewModel?.subscription.paymentRecurrency = recurrency.text

    }
    
    private func deletingAlert() {
        let alert = UIAlertController(title: "Suppression de l'abonnement", message: "Êtes-vous sur de vouloir supprimer l'abonnement : \(viewModel?.subscription.name ?? "")", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Confirmer", style: .default) { [unowned self] action in
            viewModel?.delete()
            viewModel?.goBack()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func refreshWith(subscription: Subscription) {
//        viewModel?.subscription = Subs
//        nameField.text = sub.name
        print("sub.name est : \(String(describing: viewModel?.subscription.name))")
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
                input.textField.text = "\(valueNumber) \(valueType)"
                viewModel?.recurrencyValue = valueNumber
                viewModel?.recurrencyType = valueType
//                viewModel?.subscription.paymentRecurrency = input.textField.text//"\(valueNumber) \(valueType)"
                viewModel?.recurrency = "\(valueNumber) \(valueType)"

            } else {
                input.textField.text = "\(valueNumber) \(valueType) \(string2)"
                viewModel?.reminderValue = valueNumber
                viewModel?.reminderType2 = valueType
                viewModel?.reminder = "\(valueNumber) \(valueType) \(string2)"

//                viewModel?.subscription.reminder = input.textField.text//"\(valueNumber) \(valueType) \(string2)"
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
                return ("\(componentDayMonthYear[row])")
            }
        } else {
            if component == 0 {
                return ("\(componentNumber[row])")
            }
            else if component == 1 {
                return ("\(componentDayMonthYear[row])")
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

    }
    
    private func configureCommitment() {
        commitmentStackView.addArrangedSubview(commitmentTitle)
        commitmentStackView.addArrangedSubview(commitmentDate)
        commitmentStackView.axis = .vertical
        commitmentStackView.alignment = .leading
//        commitmentStackView.spacing = 8
        commitmentTitle.textColor = MSColors.maintext
//        commitmentStackView.contentMode = .top
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
    
    private func setUpView() {
        name.configureView()
//        category.configureView()
        info.configureView()
        price.configureView()
        reminder.configureView()
        recurrency.configureView()
        colorChoosen.configureView()
        view.backgroundColor = MSColors.background
        iconHeader.translatesAutoresizingMaskIntoConstraints = false
        if let icon = viewModel?.icon {
            iconHeader.setImage(UIImage(data: icon), for: .normal)
//            iconHeader.image = UIImage(data: icon)
        } else {
            iconHeader.setImage(UIImage(systemName: "pc"), for: .normal)
        }
        iconHeader.imageView?.sizeToFit()
        iconHeader.addTarget(self, action: #selector(showIconPicker), for: .touchUpInside)
        view.addSubview(iconHeader)
        
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
        name.text = viewModel?.name
        print("viewmodel.name :\(String(describing: viewModel?.name))")
        // configurer la inpute view pour le name
        name.textFieldInputView = UIView()
        
        //MARK: Adding price field
        price.fieldTitle = "Prix"
        price.text = "\(viewModel?.price ?? 0)"
        formView.addArrangedSubview(price)
        
        //MARK: Adding commitment field
        commitmentTitle.text = "Dernier paiement"
        commitmentDate.datePickerMode = .date
        commitmentDate.translatesAutoresizingMaskIntoConstraints = false
        configureCommitment()
        commitmentDate.locale = Locale.init(identifier: "fr_FR")
        commitmentDate.date = viewModel?.date ?? Date.now
        formView.addArrangedSubview(commitmentStackView)


        //MARK: Adding reminder field
        reminder.fieldTitle = "Rappel"
        reminder.textField.allowsEditingTextAttributes = false
        reminder.text = "\(viewModel?.reminder ?? "marchepas") avant"
        reminder.shouldBehaveAsButton = true
        reminder.addTarget(self, action: #selector(changeReminder), for: .touchUpInside)
        formView.addArrangedSubview(reminder)

        //MARK: Adding recurrency field
        recurrency.fieldTitle = "Cycle"
//        var recurrencytodisplay = "\(viewModel?.recurrencyValue ?? 0) \(viewModel?.recurrencyType)"
//        print("\(viewModel?.recurrencyValue ?? 0) \(viewModel?.recurrencyType)")
//        recurrency.text = "\(viewModel?.recurrencyValue ?? 0) \(String(describing: viewModel?.recurrencyType))"
//        recurrency.text = recurrencytodisplay
        recurrency.text = "\(viewModel?.recurrency ?? "cassé")"
        recurrency.shouldBehaveAsButton = true
        recurrency.addTarget(self, action: #selector(changeReccurency), for: .touchUpInside)
        formView.addArrangedSubview(recurrency)
        
        colorChoosen.fieldTitle = "Couleur ▼"
        colorChoosen.shouldBehaveAsButton = true
        colorChoosen.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)
        colorChoosen.textField.text = "➕"
        colorChoosen.textField.backgroundColor = UIColor(hex: viewModel?.color ?? "#F7CE46")
        colorChoosen.textField.textAlignment = .right
        formView.addArrangedSubview(colorChoosen)

        //MARK: - action send values to viewModel for being save as new sub values
        name.textField.addTarget(self, action: #selector(nameFieldTextDidChange), for: .editingChanged)
        price.textField.addTarget(self, action: #selector(priceFieldTextDidChange), for: .editingChanged)
        commitmentDate.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
        //FIXME:
//        reminderPickerView.addTarget(self, action: #selector(reminderFieldDidChange), for: .valueChanged)
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
        iconHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        iconHeader.widthAnchor.constraint(equalToConstant: 50),
        iconHeader.heightAnchor.constraint(equalToConstant: 50),
        iconHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
        formView.topAnchor.constraint(equalTo: iconHeader.bottomAnchor, constant: 40),
        formView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        formView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        formView.heightAnchor.constraint(equalToConstant: 450),
        deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
        deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        deleteButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

//logo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
//logo.widthAnchor.constraint(equalToConstant: 34),
//logo.heightAnchor.constraint(equalToConstant: 34),
//logo.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),




//MARK: Adding category field
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
