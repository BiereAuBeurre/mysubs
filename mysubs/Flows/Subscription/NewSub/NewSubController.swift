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
    let componentDayMonthYear = [Calendar.Component.day, Calendar.Component.weekOfMonth, Calendar.Component.month, Calendar.Component.year] //["jour(s)", "semaine(s)", "mois", "année(s)"]
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedRow = 0
    var selectedColor: String = ""
    var newSubLabel = UILabel()
    var titleView = UIView()
    var separatorLine = UIView()
    
    //MARK: -LeftSideStackView properties
//    var leftSideStackView = UIStackView()
    var formView = UIStackView()
    var name = InputFormTextField()
    var commitment = InputFormTextField()
    var category = InputFormTextField()
    var info = InputFormTextField()
    //MARK: -RightSideStackView properties
    var colorAndIconStackView = UIStackView()
    var price = InputFormTextField()
    var reminder = InputFormTextField()
    var recurrency = InputFormTextField()
    var colorChoosen = InputFormTextField()
    var iconChoosen = InputFormTextField()
    var commitmentTitle = UILabel()
    var commitmentDate = UIDatePicker()
    let commitmentStackView = UIStackView()
    var reminderPickerView = UIPickerView()
    var recurrencyPickerView = UIPickerView()
    
    //MARK: LOGO PROPERTY
    var selectedIcon = UIImage()
    var suggestedLogo = UIButton()//UILabel()
    var logo = UIImageView()
    var iconCell = IconCell()
    var viewModel: NewSubViewModel?
    var storageService = StorageService()

    //TEST FOR ICON
    var iconCollectionView: UICollectionView!
    let iconDictionnary = ["custom.airplane.circle.fill", "custom.battery.100.bolt", "custom.bolt.car.fill", "custom.bolt.circle.fill", "custom.book.circle.fill", "custom.briefcase.fill", "custom.car.circle.fill", "custom.cart.circle.fill", "custom.creditcard.circle.fill", "custom.cross.vial", "custom.eye.circle.fill", "custom.fork.knife.circle.fill", "custom.gift.fill", "custom.graduationcap.fill", "custom.headphones.circle.fill", "custom.house.fill", "custom.ivfluid.bag", "custom.lock.fill", "custom.map.circle.fill", "custom.network", "custom.paintpalette.fill", "custom.pc", "custom.phone.fill", "custom.pills.fill", "custom.play.rectangle.fill", "custom.star.fill", "custom.suit.heart.fill", "custom.sun.haze.fill", "custom.sun.max.fill", "custom.testtube.2", "custom.tv.circle.fill", "custom.wifi.circle.fill"]
    var icon = UIImage()
    let iconPickerVC = IconPickerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: -OBJC METHODs
    
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
    func addButtonAction() {
//        if viewModel?.name == nil && viewModel?.price == nil {
//            showAlert("Champs manquants", "Merci d'ajouter au moins un nom et un prix")
//            return
//        } else {
            viewModel?.saveSub()
//        }
        
        print("dans add button action, ajouté à \(String(describing: viewModel?.subscriptions))")
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
        let alert = UIAlertController(title: "Select icon", message: "", preferredStyle: .actionSheet)
        alert.setValue(iconPickerVC, forKey: "contentViewController")
//        viewModel?.icon = iconPickerVC.icon.pngData()
        print("viewModel?.icon is \(String(describing: viewModel?.icon))")
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        //MARK: - replace selectedRow protocol method since action happen here
        alert.addAction(UIAlertAction(title: "Selectionner", style: .default, handler: { [self] (UIAlertAction) in
            viewModel?.icon = iconPickerVC.icon.pngData()

            iconChoosen.textField.setIcon(iconPickerVC.icon)

//            iconChoosen.textField.setIcon((viewModel?.icon ?? UIImage(systemName: "house"))!)
        }))
        self.present(alert, animated: true, completion: nil)
                                      
        }
    
    @objc
    func showColorPicker()  {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        self.present(colorPicker, animated: true, completion: nil)
        print("viewModel.color in showcolorpicker()is \(String(describing: viewModel?.color))")
    }
        

    //MARK: - PRIVATES METHODS
    
    private func configureCommitment() {
        commitmentStackView.addArrangedSubview(commitmentTitle)
        commitmentStackView.addArrangedSubview(commitmentDate)
        commitmentStackView.axis = .vertical
        commitmentStackView.alignment = .leading
        commitmentStackView.distribution = .fillEqually
        commitmentTitle.textColor = MSColors.maintext
        commitmentDate.contentMode = .topLeft
        commitmentStackView.translatesAutoresizingMaskIntoConstraints = false
        commitmentTitle.translatesAutoresizingMaskIntoConstraints = false
        commitmentDate.translatesAutoresizingMaskIntoConstraints = false
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
        let alert = UIAlertController(title: "Select reminder", message: "", preferredStyle: .actionSheet)
        
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
            let string2 = "avant"

            if input == recurrency {
                input.textField.text = "\(valueNumber) \(valueType)"
                viewModel?.recurrencyValue = valueNumber
                viewModel?.recurrencyType = valueType
            } else {
                input.textField.text = "\(valueNumber) \(valueType) \(string2)"
                viewModel?.reminderValue = valueNumber
                viewModel?.reminderType2 = valueType
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
        self.colorChoosen.textField.backgroundColor = viewController.selectedColor
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
        commitment.configureView()
        name.configureView()
        price.configureView()
        reminder.configureView()
        recurrency.configureView()
        colorChoosen.configureView()
        iconChoosen.configureView()
        
        // MARK: FORMVIEW
        formView.translatesAutoresizingMaskIntoConstraints = false
        formView.axis = .vertical
        formView.alignment = .fill
        formView.spacing = 8
        formView.distribution = .equalSpacing
        formView.distribution = .fillEqually
        view.addSubview(formView)
        
//        //MARK: Adding name field
        name.fieldTitle = "Nom"
        name.text = ""
        // configurer la inpute view pour le name
        name.textFieldInputView = UIView()
        name.textField.addTarget(self, action: #selector(nameFieldTextDidChange), for: .editingChanged)
        formView.addArrangedSubview(name)

        //MARK: price
        price.fieldTitle = "Prix"
        price.textField.addTarget(self, action: #selector(priceFieldTextDidChange), for: .editingChanged)
        formView.addArrangedSubview(price)
        
        //MARK: Adding commitment field
        commitmentDate.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
        commitmentTitle.text = "Dernier paiement"
        commitmentDate.datePickerMode = .date
        commitmentDate.translatesAutoresizingMaskIntoConstraints = false
        configureCommitment()
        commitmentDate.locale = Locale.init(identifier: "fr_FR")
        commitmentDate.date = Date.now
        formView.addArrangedSubview(commitmentStackView)
        //MARK: - reminder
        reminder.fieldTitle = "Rappel"
        reminder.textField.allowsEditingTextAttributes = false
        reminder.shouldBehaveAsButton = true
        reminder.addTarget(self, action: #selector(changeReminder), for: .touchUpInside)
        formView.addArrangedSubview(reminder)
        //MARK: - recurrency field
        recurrency.fieldTitle = "Cycle"
        recurrency.shouldBehaveAsButton = true
        recurrency.addTarget(self, action: #selector(changeReccurency), for: .touchUpInside)
        formView.addArrangedSubview(recurrency)
   
        //MARK: Adding recurrency field
        recurrency.fieldTitle = "Cycle"
        recurrency.shouldBehaveAsButton = true
        recurrency.addTarget(self, action: #selector(changeReccurency), for: .touchUpInside)
        
        
        colorAndIconStackView.axis = .horizontal
        
        colorChoosen.fieldTitle = "Choisir une couleur"
        colorChoosen.shouldBehaveAsButton = true
        colorChoosen.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)
        colorChoosen.textField.text = "➕"
        colorChoosen.textField.textAlignment = .right
        colorAndIconStackView.addArrangedSubview(colorChoosen)

        
        colorAndIconStackView.addArrangedSubview(iconChoosen)
        iconChoosen.fieldTitle = "Choisir une icône"
        iconChoosen.shouldBehaveAsButton = true
        iconChoosen.addTarget(self, action: #selector(showIconPicker), for: .touchUpInside)
        iconChoosen.textField.leftViewMode = .always
        colorAndIconStackView.distribution = .fillEqually
        colorAndIconStackView.spacing = 48
        
        formView.addArrangedSubview(colorAndIconStackView)

        // MARK: SETTING TITLE
        view.backgroundColor = MSColors.background
        newSubLabel.text = "Nouvel abonnement"
        newSubLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        newSubLabel.textColor = MSColors.maintext
        newSubLabel.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
    
        view.addSubview(titleView)
        titleView.addSubview(newSubLabel)
                
        // MARK: SEPARATOR LINE VIEW
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.backgroundColor = UIColor(named: "yellowgrey")
        view.addSubview(separatorLine)
        
        //MARK: Adding logo suggestion
       
 
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
            formView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 40),
            formView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            formView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            formView.heightAnchor.constraint(equalToConstant: 450),
            ])
    }
    

}

//Adding icon selected to left vuew mode of textfiel
extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}

//MARK: - BOTH PICKERVIEW SETUP
extension NewSubController: UIPickerViewDataSource, UIPickerViewDelegate {
    
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
                return ("\(componentDayMonthYear[row])")//componentDayMonthYear[row]
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
    
//        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
////            if component == 0 {
////                pickerView.reloadComponent(1)
////            }
//
//            if pickerView == recurrencyPickerView {
////                let string0 = componentNumber[pickerView.selectedRow(inComponent: 0)]
////                let string1 = componentDayMonthYear[pickerView.selectedRow(inComponent: 1)]
////                recurrency.textField.text = "\(string0) \(string1)"
//            }
//            else {
//                let valueNumber = componentNumber[pickerView.selectedRow(inComponent: 0)]
//                let valueType = componentDayMonthYear[pickerView.selectedRow(inComponent: 1)]
////                let string2 = "avant"
////                reminder.textField.text = "\(valueNumber) \(valueType) \(string2)"
//
//                viewModel?.reminderValue = valueNumber
////                viewModel?.reminderType = valueType
//                viewModel?.reminderType2 = valueType
//
////                let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: commitmentDate.date)
//
////                let nextDate = Calendar.current.date(byAdding: .day, value: valueNumber, to: commitmentDate.date)
//
//            }
//        }

}

//extension NewSubController : UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == iconCollectionView {
//            return iconDictionnary.count
//        } else  {
//            return 1
//        }
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == iconCollectionView {
//            let iconCell = collectionView.dequeueReusableCell(withReuseIdentifier: IconCell.identifier, for: indexPath) as! IconCell
//            iconCell.logo.image = UIImage(named: "\(iconDictionnary[indexPath.row])")
//            icon = UIImage(named: "\(iconDictionnary[indexPath.row])") ?? UIImage(systemName: "house.fill")!
//            return iconCell
//        } else { return UICollectionViewCell() }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == iconCollectionView {
//            icon = UIImage(named: "\(iconDictionnary[indexPath.row])") ?? UIImage(systemName: "house.fill")!
//            print("icon tapped \(String(describing: icon))")
//            viewModel?.icon = icon
//
//            print("viewModel?.icon is \(String(describing: viewModel?.icon))")
//        }
//    }
//
//}
