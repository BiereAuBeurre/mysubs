//
//  NewSubController.swift
//  mysubs
//
//  Created by Manon Russo on 06/12/2021.

import UIKit
import CoreData

class NewSubController: UIViewController, UINavigationBarDelegate {
    // Pop up VC settings
    let componentNumber = Array(stride(from: 1, to: 30 + 1, by: 1))
    let componentDayMonthYear = [Calendar.Component.day, Calendar.Component.weekOfMonth, Calendar.Component.month, Calendar.Component.year]
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedRow = 0
    var selectedColor = ""
    var newSubLabel = UILabel()
    var separatorLine = UIView()
    
    var formView = UIStackView()
    var name = InputFormTextField()
    var info = InputFormTextField()
    var colorAndIconStackView = UIStackView()
    var price = InputFormTextField()
    var reminder = InputFormTextField()
    var recurrency = InputFormTextField()
    
    var colorStackView = UIStackView()
    var iconStackView = UIStackView()
    var colorTitle = UIButton()
    var colorPreview = UIImageView()
    var iconTitle = UIButton()
    var iconPreview = UIImageView()
    
    var commitmentTitle = UILabel()
    var commitmentDate = UIDatePicker()
    let commitmentStackView = UIStackView()
    var reminderPickerView = UIPickerView()
    var recurrencyPickerView = UIPickerView()
    
    // LOGO PROPERTY
    var selectedIcon = UIImage()
    var suggestedLogo = UIButton()
    var logo = UIImageView()
    var iconCell = IconCell()
    var viewModel: NewSubViewModel?
    var storageService = StorageService()
    let iconPickerVC = IconPickerViewController()
    var notifAuthorizer = UIStackView()
    var notifTitle = UILabel()
    var switchNotif = UISwitch()
    var notifSettingsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
//    func presentNotificationAlert() {
//            let alertVC = UIAlertController(title: "Autoriser les notifications", message: "Si vous souhaitez recevoir une notification selon le rappel renseigné, merci d'autoriser les notifications.", preferredStyle: .alert)
//        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
//        }))
//
//            self.present(alertVC, animated: true, completion: nil)
//        construction alert controller
//        title message qui explique que tu dois demander autho
//        si user il tap ok
//        NotificationService.requestNotificationAuthorization()
//
//    }
    
    //MARK: -objc methods
    
    @objc
    func addButtonAction() {
        // For a valid sub, user have to fill at least a name and a price 
        if viewModel?.name == nil || viewModel?.price == nil {
            showAlert("Champs manquants", "Merci d'ajouter au moins un nom et un prix")
            return
        }
        // Then if the date is set up, user need to input reminder and recurrency as well (for notifications)
        if viewModel?.date != nil {
            if viewModel?.recurrencyType == .hour || viewModel?.reminderType == .hour {
                let alertVC = UIAlertController(title: "Champs manquant pour paramétrer la date du prochain paiement !", message: "merci d'accompagner la date d'un rappel et d'un cycle de paiement", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                alertVC.addAction(UIAlertAction(title: "Désactiver le rappel", style: .cancel, handler: { _ in
                    self.switchNotif.isOn = false
                    self.commitmentStackView.isHidden = true
                    self.recurrency.isHidden = true
                    self.reminder.isHidden = true
                }))
                self.present(alertVC, animated: true, completion: nil)
                return
            }
        }
        if switchNotif.isOn {
            NotificationService.requestNotificationAuthorization()
        }
        viewModel?.saveSub()
    }
    
    @objc
    func changeReminder() {
        print(#function)
        showPicker(reminderPickerView, reminder)
    }
    
    @objc
    func changeReccurency() {
        showPicker(recurrencyPickerView, recurrency)
    }

    
    @objc
    func nameFieldTextDidChange(textField: UITextField) {
        viewModel?.name = textField.text
    }

    @objc
    func priceFieldTextDidChange(textField: UITextField) {
        viewModel?.price = Float(textField.text ?? "")
    }
    
    @objc
    func textFieldDidChange(textField: UITextField) {
        //delegate.textFieldDidCha
    }
    
    @objc
    func dateDidChange() {
        viewModel?.date = commitmentDate.date
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
            //Convert view model icon from data to uiimage, then displaying it
            viewModel?.icon = iconPickerVC.icon.pngData()
            iconPreview.image = iconPickerVC.icon
            iconPreview.tintColor = .black
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
        }
    }
    
    @objc
    func displayNotifSettings() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.commitmentStackView.isHidden.toggle()
            self.recurrency.isHidden.toggle()
            self.reminder.isHidden.toggle()
        }, completion: nil)
        if switchNotif.isOn {
        viewModel?.date = commitmentDate.date
        } else {
            viewModel?.date = nil
        }
    }
    
    //MARK: - PRIVATES METHODS
    private func showPicker(_ picker : UIPickerView, _ input: InputFormTextField) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        picker.dataSource = self
        picker.delegate = self
        picker.selectRow(selectedRow, inComponent: 0, animated: false)
        vc.view.addSubview(picker)
        picker.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        picker.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        var alert = UIAlertController()
        if input == reminder {
            alert = UIAlertController(title: "Sélectionner le rappel", message: "Indiquez combien de jours avant le paiement vous souhaitez être notifié", preferredStyle: .actionSheet)
        } else {
            alert = UIAlertController(title: "Sélectionner un cycle", message: "Indiquez à quels intervalles vous payez", preferredStyle: .actionSheet)
        }
        
        alert.popoverPresentationController?.sourceView = input
        alert.popoverPresentationController?.sourceRect = input.bounds
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        //MARK: - replace selectedRow protocol method since action happen here
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { [self] (UIAlertAction) in
            self.selectedRow = picker.selectedRow(inComponent: 0)
            let valueNumber = self.componentNumber[picker.selectedRow(inComponent: 0)]
            let valueType = self.componentDayMonthYear[picker.selectedRow(inComponent: 1)]

            if input == recurrency {
                input.textField.text = "Tous les \(valueNumber) \(valueType.stringValue)"
                viewModel?.recurrencyValue = valueNumber
                viewModel?.recurrencyType = valueType
            } else {
                input.textField.text = "\(valueNumber) \(valueType.stringValue) avant"
                viewModel?.reminderValue = valueNumber
                viewModel?.reminderType = valueType
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func refreshWith(subscriptions: [Subscription]) {
        // myCollectionView.reloadData()
        print("refresh with is read")
    }
    
    
    
}

//MARK: - COLOR PICKER SETTINGS
extension NewSubController: UIColorPickerViewControllerDelegate {
    ///  Called on every color selection done in the picker.
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.colorPreview.backgroundColor = viewController.selectedColor
        self.selectedColor = viewController.selectedColor.toHexString()
        viewModel?.color = selectedColor
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
        view.addSubview(newSubLabel)
                
        // MARK: SEPARATOR LINE VIEW
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.backgroundColor = UIColor(named: "yellowgrey")
        view.addSubview(separatorLine)

        //Hide until user touche switch button
        commitmentStackView.isHidden = true
        recurrency.isHidden = true
        reminder.isHidden = true
        
//        //MARK: Adding name field
        name.fieldTitle = "Nom"
        name.text = ""
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
        
        colorTitle.setTitle("Couleur ▼", for: .normal) //= "Couleur ▼"
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
        switchNotif.isOn = false
        switchNotif.addTarget(self, action: #selector(displayNotifSettings), for: .touchUpInside)
        notifAuthorizer.addArrangedSubview(notifTitle)
        notifAuthorizer.addArrangedSubview(switchNotif)
        notifAuthorizer.axis = .horizontal
        notifAuthorizer.distribution = .equalCentering
        notifSettingsStackView.addArrangedSubview(notifAuthorizer)

        notifSettingsStackView.axis = .vertical
        notifSettingsStackView.spacing = 8
        formView.addArrangedSubview(notifSettingsStackView)
    
        
        //MARK: Adding commitment field
        commitmentTitle.translatesAutoresizingMaskIntoConstraints = false
        commitmentTitle.textColor = MSColors.maintext
        commitmentTitle.text = "Dernier paiement"
        commitmentStackView.addArrangedSubview(commitmentTitle)

        commitmentDate.timeZone = .current
        commitmentDate.translatesAutoresizingMaskIntoConstraints = false
        commitmentDate.contentMode = .topLeft
        commitmentDate.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
        commitmentDate.datePickerMode = .date
        commitmentDate.translatesAutoresizingMaskIntoConstraints = false
        commitmentDate.locale = Locale.init(identifier: "fr_FR")
        commitmentDate.date = Date.now
        commitmentStackView.addArrangedSubview(commitmentDate)
        
        commitmentStackView.translatesAutoresizingMaskIntoConstraints = false
        commitmentStackView.axis = .vertical
        commitmentStackView.alignment = .leading
        commitmentStackView.distribution = .fillEqually
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
        formView.spacing = 16
        view.addSubview(formView)
 
        NSLayoutConstraint.activate([
            newSubLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            newSubLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            newSubLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            newSubLabel.heightAnchor.constraint(equalToConstant: 30),
            
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            separatorLine.topAnchor.constraint(equalTo: newSubLabel.bottomAnchor, constant: 8),
            separatorLine.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            separatorLine.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            formView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 32),
            formView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: formView.trailingAnchor, constant: 16),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualTo: formView.bottomAnchor, constant: 16),
            iconPreview.heightAnchor.constraint(equalToConstant: 40),
            iconPreview.widthAnchor.constraint(equalToConstant: 80),
            colorPreview.heightAnchor.constraint(equalToConstant: 40),
            colorPreview.widthAnchor.constraint(equalToConstant: 80),
            iconStackView.trailingAnchor.constraint(greaterThanOrEqualTo: colorAndIconStackView.trailingAnchor, constant: -8),
            ])
    }
}

//MARK: - BOTH PICKERVIEW SETUP
extension NewSubController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == recurrencyPickerView {
            if component == 0 {
                return "\(componentNumber[row])"
            } else {
                return componentDayMonthYear[row].stringValue
            }
        }
        
        else {
            if component == 0 {
                return "\(componentNumber[row])"
            }
            else{
                return componentDayMonthYear[row].stringValue
            }
        }
    }
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
                return 2
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

//MARK: -Setting up notification authorization
//extension NewSubController: UNUserNotificationCenterDelegate {
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        completionHandler()
//    }
//    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.banner, .badge, .sound])
//    }
//
//    func requestNotificationAuthorization() {
//        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
//        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
//            if let error = error {
//                print("Error: ", error)
//            }
//        }
//    }
//    
//}
