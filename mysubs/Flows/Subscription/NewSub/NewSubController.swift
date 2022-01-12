//
//  NewSubController.swift
//  mysubs
//
//  Created by Manon Russo on 06/12/2021.
//

import UIKit
import CoreData

class NewSubController: UIViewController, UINavigationBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Pop up VC settings
    let componentNumber = Array(stride(from: 1, to: 30 + 1, by: 1))
    let componentDayMonthYear = ["jour(s)","semaine(s)", "mois", "année(s)"]
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedRow = 0

    var newSubLabel = UILabel()
    var titleView = UIView()
    var separatorLine = UIView()
    
    //MARK: -LeftSideStackView properties
    var leftSideStackView = UIStackView()
//    var formView = UIStackView()
    var name = InputFormTextField()
    var commitment = InputFormTextField()
    var category = InputFormTextField()
    var info = InputFormTextField()
    //MARK: -RightSideStackView properties
//    var rightSideStackView = UIStackView()
    var price = InputFormTextField()
    var reminder = InputFormTextField()
    var recurrency = InputFormTextField()
   
    //MARK: LOGO PROPERTY
    var suggestedLogo = UILabel()
    var logo = UIImageView()
    
    var viewModel: NewSubViewModel?

    var storageService = StorageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
//        reminder.setUpPickerView()
        commitment.addInputViewDatePicker()
//        recurrency.setUpPickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return componentNumber.count
        } else if component == 1 {
            return componentDayMonthYear.count
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
        }
        
            let string0 = componentNumber[pickerView.selectedRow(inComponent: 0)]
            let string1 = componentDayMonthYear[pickerView.selectedRow(inComponent: 1)]
            let string2 = "avant"
        reminder.textField.text = "\(string0) \(string1) \(string2)"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
            if component == 0 {
                return ("\(componentNumber[row])")
            }
            else if component == 1 {
                return componentDayMonthYear[row]
            } else {
                return "avant"
            }
    }
    
    //MARK: -OBJC METHODs
    @objc func addButtonAction() {
        if viewModel?.name == nil {
            showAlert("Champs manquants", "Merci d'ajouter au moins un nom et un prix")
            return
        } else {
            viewModel?.saveSub()
            print("dans add button action, ajouté à \(String(describing: viewModel?.subscriptions))")
        }
    }
    
    @objc func nameFieldTextDidChange(textField: UITextField) {
        viewModel?.name = textField.text
    }
    
    @objc
    func textFieldDidChange(textField: UITextField) {
        //delegate.textFieldDidCha
    }
    
    @objc
    func changeReminder() {
        print(#function)
        //reminder.showPicker = true
        //pickuper.show = true
        //viewModel.changeReminder()
        
        showReminderPicker()
        
//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
//            self.info.isHidden.toggle()
//            self.recurrency.isHidden.toggle()
//            self.suggestedLogo.isHidden.toggle()
//            self.logo.isHidden.toggle()
//
//        }, completion: nil)
    }
    //MARK: - PRIVATES METHODS
    
    func showReminderPicker() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height:screenHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        let alert = UIAlertController(title: "Select reminder", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = reminder
        alert.popoverPresentationController?.sourceRect = reminder.bounds
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
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
        commitment.configureView()
        name.configureView()
        category.configureView()
        info.configureView()
        price.configureView()
        reminder.configureView()
        recurrency.configureView()
        
        // MARK: FORMVIEW
//        formView.translatesAutoresizingMaskIntoConstraints = false
//        formView.axis = .horizontal
//        formView.alignment = .fill
//        formView.spacing = 8
//        formView.distribution = .fillEqually
//        view.addSubview(formView)
        
    //MARK: LEFTSIDE STACKVIEW
        leftSideStackView.translatesAutoresizingMaskIntoConstraints = false
//        leftSideStackView.contentMode = .top
        leftSideStackView.axis = .vertical
        leftSideStackView.backgroundColor = .cyan
//        leftSideStackView.alignment = .leading
        leftSideStackView.distribution = .fillEqually
        leftSideStackView.spacing = 8
//        //MARK: Adding name field
        leftSideStackView.addArrangedSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.label.text = "Nom"
        name.label.textColor = MSColors.maintext
        name.textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        name.textField.addTarget(self, action: #selector(nameFieldTextDidChange), for: .allEditingEvents)
        name.textField.borderStyle = .roundedRect
        
        //MARK: Adding commitment field
        leftSideStackView.addArrangedSubview(commitment)
        commitment.translatesAutoresizingMaskIntoConstraints = false
        commitment.label.text = "Dernier paiement"
        commitment.label.textColor = MSColors.maintext
//        commitment.textField.text = "\(sub.commitment ?? "")"
        commitment.textField.borderStyle = .roundedRect
        //MARK: Adding info field
        leftSideStackView.addArrangedSubview(info)
        info.translatesAutoresizingMaskIntoConstraints = false
        info.label.text = "INFOS"
        info.label.textColor = MSColors.maintext
        info.textField.borderStyle = .roundedRect
        info.textField.translatesAutoresizingMaskIntoConstraints = false
//        info.textField.text = sub.extraInfo ?? ""
        
        view.addSubview(leftSideStackView)

//        formView.addArrangedSubview(leftSideStackView)
        
    //MARK: RIGHTSIDE STACKVIEW
//        rightSideStackView.translatesAutoresizingMaskIntoConstraints = false
//        rightSideStackView.contentMode = .scaleToFill
//        rightSideStackView.axis = .vertical
//        rightSideStackView.alignment = .fill
//        rightSideStackView.distribution = .fillEqually
//        rightSideStackView.spacing = 8
        
        //MARK: Adding price field
        leftSideStackView.addArrangedSubview(price)

//        rightSideStackView.addArrangedSubview(price)
        price.translatesAutoresizingMaskIntoConstraints = false
        price.label.text = "Prix"
//        price.textField.text = "\(sub.price)"
        price.textField.borderStyle = .roundedRect
        price.textField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Adding reminder field
        leftSideStackView.addArrangedSubview(reminder)

//        rightSideStackView.addArrangedSubview(reminder)
        reminder.translatesAutoresizingMaskIntoConstraints = false
        reminder.label.text = "Rappel"
        reminder.shouldBehaveAsButton = true
        reminder.addTarget(self, action: #selector(changeReminder), for: .touchUpInside)
        reminder.textField.leftViewMode = .always
        reminder.textField.borderStyle = .roundedRect
        reminder.textField.translatesAutoresizingMaskIntoConstraints = false
        reminder.textField.allowsEditingTextAttributes = false
        //MARK: Adding recurrency field

//        rightSideStackView.addArrangedSubview(recurrency)
        recurrency.translatesAutoresizingMaskIntoConstraints = false
        recurrency.label.text = "Cycle"
//        recurrency.textField.inputView = recurrencyPickerView
        recurrency.textField.borderStyle = .roundedRect
        recurrency.textField.translatesAutoresizingMaskIntoConstraints = false
//        formView.addArrangedSubview(rightSideStackView)
        leftSideStackView.addArrangedSubview(recurrency)

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
        
        //MARK: Adding logo suggestion
        suggestedLogo.translatesAutoresizingMaskIntoConstraints = false
        logo.translatesAutoresizingMaskIntoConstraints = false
        suggestedLogo.text = "Logo suggéré"
        logo.backgroundColor = MSColors.maintext
        logo.addCornerRadius()
 
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
            
            suggestedLogo.topAnchor.constraint(equalTo: leftSideStackView.bottomAnchor, constant: 16),

//            suggestedLogo.topAnchor.constraint(equalTo: formView.bottomAnchor, constant: 16),
            suggestedLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logo.topAnchor.constraint(equalTo: suggestedLogo.bottomAnchor, constant: 8),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logo.widthAnchor.constraint(equalToConstant: 100),
            logo.heightAnchor.constraint(equalToConstant: 100),
            leftSideStackView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 40),
            leftSideStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            leftSideStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            leftSideStackView.heightAnchor.constraint(equalToConstant: 450),
            
//            formView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 40),
//            formView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            formView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            formView.heightAnchor.constraint(equalToConstant: 250),
            ])
    }
    

}
