//
//  NewSubController.swift
//  mysubs
//
//  Created by Manon Russo on 06/12/2021.

import UIKit
import CoreData

class NewSubController: UIViewController, UINavigationBarDelegate {
    var dayComponent = DateComponents()
    
//    dayComponent.day = 1

    // Pop up VC settings
    let componentNumber = Array(stride(from: 1, to: 30 + 1, by: 1))
    let componentDayMonthYear = [Calendar.Component.day, Calendar.Component.weekOfMonth, Calendar.Component.month, Calendar.Component.year]
//    let componentDayMonthYear =  [Calendar.localized.unitTitle(.day),
//                                  Calendar.localized.unitTitle(.weekOfMonth),
//                                  Calendar.localized.unitTitle(.month),
//                                  Calendar.localized.unitTitle(.year),]//["jour(s)", "semaine(s)", "mois", "année(s)"]
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedRow = 0
    var selectedColor = UIColor()
    var newSubLabel = UILabel()
    var titleView = UIView()
    var separatorLine = UIView()
    
    //MARK: -LeftSideStackView properties
    var leftSideStackView = UIStackView()
    var formView = UIStackView()
    var name = InputFormTextField()
    var commitment = InputFormTextField()
    var category = InputFormTextField()
    var info = InputFormTextField()
    //MARK: -RightSideStackView properties
    var rightSideStackView = UIStackView()
    var price = InputFormTextField()
    var reminder = InputFormTextField()
    var recurrency = InputFormTextField()
    var commitmentTitle = UILabel()
    var commitmentDate = UIDatePicker()
    let commitmentStackView = UIStackView()
    var reminderPickerView = UIPickerView()
    var recurrencyPickerView = UIPickerView()
    
    //MARK: LOGO PROPERTY
    var suggestedLogo = UIButton()//UILabel()
    var logo = UIImageView()
    
    var viewModel: NewSubViewModel?
    var storageService = StorageService()
    

    
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
        if viewModel?.name == nil && viewModel?.price == nil {
         showAlert("Champs manquants", "Merci d'ajouter au moins un nom et un prix")
         return
         } else {
        viewModel?.saveSub()
                }

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
    
//    @objc
//    func reminderDidChange() {
//        viewModel?.reminderType2 = reminderPickerView.
//
//    }
    
    @objc
    func showColorPicker()  {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
//        colorPicker.selectedColor = self.logo.backgroundColor!
        self.present(colorPicker, animated: true, completion: nil)
        print("selected color is: \(String(describing: logo.backgroundColor?.toHexString()))") //voir extension uicolor
    }
        

    //MARK: - PRIVATES METHODS
    
    private func configureCommitment() {
        commitmentStackView.addArrangedSubview(commitmentTitle)
        commitmentStackView.addArrangedSubview(commitmentDate)
        commitmentStackView.axis = .vertical
        commitmentStackView.alignment = .leading
        commitmentStackView.distribution = .fillEqually
        commitmentStackView.spacing = 8
        commitmentTitle.textColor = MSColors.maintext
//        commitmentStackView.contentMode = .top
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
            } else {
                input.textField.text = "\(valueNumber) \(valueType) \(string2)"
            }
            viewModel?.reminderValue = valueNumber
//            viewModel?.reminderType = valueType
            viewModel?.reminderType2 = valueType
            
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
        self.logo.backgroundColor = viewController.selectedColor
        print("selected color in hex is: \(String(describing: logo.backgroundColor?.toHexString()))") //UIColor(hexa)
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
        formView.translatesAutoresizingMaskIntoConstraints = false
        formView.axis = .horizontal
        formView.alignment = .fill
        formView.spacing = 8
        formView.distribution = .fillEqually
        view.addSubview(formView)
        
    //MARK: LEFTSIDE STACKVIEW
        leftSideStackView.translatesAutoresizingMaskIntoConstraints = false
//        leftSideStackView.contentMode = .top
        leftSideStackView.axis = .vertical
//        leftSideStackView.alignment = .leading
        leftSideStackView.distribution = .fillEqually
//        leftSideStackView.spacing = 8
//        //MARK: Adding name field
        leftSideStackView.addArrangedSubview(name)
        name.fieldTitle = "Nom"
        name.text = ""
        // configurer la inpute view pour le name
        name.textFieldInputView = UIView()
        //MARK: - action send values to viewModel for being save as new sub values
        name.textField.addTarget(self, action: #selector(nameFieldTextDidChange), for: .editingChanged)
        price.textField.addTarget(self, action: #selector(priceFieldTextDidChange), for: .editingChanged)
        commitmentDate.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
        //FIXME: pour les pickerview mettre ca dans l'action du select? ce qui serait dans sa methode objc?
        
        //MARK: Adding commitment field
        commitmentTitle.text = "Dernier paiement"
        commitmentDate.datePickerMode = .date
        commitmentDate.translatesAutoresizingMaskIntoConstraints = false
        configureCommitment()
        commitmentDate.locale = Locale.init(identifier: "fr_FR")
        commitmentDate.date = Date.now
        leftSideStackView.addArrangedSubview(commitmentStackView)
//        leftSideStackView.addArrangedSubview(commitmentDate)
        //MARK: Adding info field
        leftSideStackView.addArrangedSubview(info)
        info.fieldTitle = "INFOS"
        info.text = ""
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
        price.fieldTitle = "Prix"
//        price.text = "\(viewModel?.subscription.price ?? 0)"
        //MARK: Adding reminder field
        rightSideStackView.addArrangedSubview(reminder)
        reminder.fieldTitle = "Rappel"
        reminder.textField.allowsEditingTextAttributes = false
//        reminder.text = viewModel?.subscription.reminder
        reminder.shouldBehaveAsButton = true
        reminder.addTarget(self, action: #selector(changeReminder), for: .touchUpInside)
        
        //MARK: Adding recurrency field
        rightSideStackView.addArrangedSubview(recurrency)
        recurrency.fieldTitle = "Cycle"
//        recurrency.text = "\(viewModel?.subscription.paymentRecurrency ?? "")"
        recurrency.shouldBehaveAsButton = true
        recurrency.addTarget(self, action: #selector(changeReccurency), for: .touchUpInside)
        formView.addArrangedSubview(rightSideStackView)


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
        suggestedLogo.setTitle("color to pick", for: .normal)
        suggestedLogo.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)
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
            suggestedLogo.topAnchor.constraint(equalTo: formView.bottomAnchor, constant: 16),
            suggestedLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logo.topAnchor.constraint(equalTo: suggestedLogo.bottomAnchor, constant: 8),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logo.widthAnchor.constraint(equalToConstant: 100),
            logo.heightAnchor.constraint(equalToConstant: 100),
            formView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 40),
            formView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            formView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            formView.heightAnchor.constraint(equalToConstant: 250),
            ])
    }
    

}
//class DateComponentsFormatter : Formatter  {
//
//    func formatterFrDate() -> String {
//        let componentDayMonthYear = [Calendar.Component.day, Calendar.Component.weekOfMonth, Calendar.Component.month, Calendar.Component.year]
//
//
//        let formatter = DateComponentsFormatter()
//        //formatter.unitsStyle = .full
//        //formatter.includesApproximationPhrase = true
//        //formatter.includesTimeRemainingPhrase = true
//        //                    formatter.allowedUnits = [.minute]
//
//        // Use the configured formatter to generate the string.
//        let outputString = formatter.string(for: componentDayMonthYear)
//        return outputString!
//    } // string(from: componentDayMonthYear)
//}
extension Date {

    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
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
//                    dayComponent.day = 1
//                    return dayComponent.day!
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
    
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//            if component == 0 {
//                pickerView.reloadComponent(1)
//            }
    
            if pickerView == recurrencyPickerView {
//                let string0 = componentNumber[pickerView.selectedRow(inComponent: 0)]
//                let string1 = componentDayMonthYear[pickerView.selectedRow(inComponent: 1)]
//                recurrency.textField.text = "\(string0) \(string1)"
            }
            else {
                let valueNumber = componentNumber[pickerView.selectedRow(inComponent: 0)]
                let valueType = componentDayMonthYear[pickerView.selectedRow(inComponent: 1)]
//                let string2 = "avant"
//                reminder.textField.text = "\(valueNumber) \(valueType) \(string2)"
                
                viewModel?.reminderValue = valueNumber
//                viewModel?.reminderType = valueType
                viewModel?.reminderType2 = valueType

//                let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: commitmentDate.date)

//                let nextDate = Calendar.current.date(byAdding: .day, value: valueNumber, to: commitmentDate.date)

            }
        }

}
//extension Calendar {
//
//    /// get a calendar configured with the language of the user
//    static var localized: Calendar {
////        let prefLanguage = Locale.preferredLanguages[0]
//        var calendar = Calendar(identifier: .gregorian)
//        calendar.locale = Locale.init(identifier: "fr_FR")
////Locale(identifier: prefLanguage)
//        return calendar
//    }
//    
//     func unitTitle(_ unit: NSCalendar.Unit, value: Int = 1, locale: Locale? = nil) -> String {
//        let emptyString = String()
//        let date = Date()
//        let component = getComponent(from: unit)
//         guard let sinceUnits = self.date(byAdding: component, value: value, to: date) else {
//            return emptyString
//        }
//
//        let timeInterval = sinceUnits.timeIntervalSince(date)
//        let formatter = DateComponentsFormatter()
//
//        formatter.calendar = self
//        formatter.allowedUnits = [unit]
//        formatter.unitsStyle = .full
//        guard let string = formatter.string(from: timeInterval) else {
//            return emptyString
//        }
//
//        return string.replacingOccurrences(of: String(value), with: emptyString).trimmingCharacters(in: .whitespaces).capitalized
//    }
//    
//    // swiftlint:disable:next cyclomatic_complexity
//    private func getComponent(from unit: NSCalendar.Unit) -> Component {
//        let component: Component
//
//        switch unit {
//        case .era:
//            component = .era
//        case .year:
//            component = .year
//        case .month:
//            component = .month
//        case .day:
//            component = .day
//        case .hour:
//            component = .hour
//        case .minute:
//            component = .minute
//        case .second:
//            component = .second
//        case .weekday:
//            component = .weekday
//        case .weekdayOrdinal:
//            component = .weekdayOrdinal
//        case .quarter:
//            component = .quarter
//        case .weekOfMonth:
//            component = .weekOfMonth
//        case .weekOfYear:
//            component = .weekOfYear
//        case .yearForWeekOfYear:
//            component = .yearForWeekOfYear
//        case .nanosecond:
//            component = .nanosecond
//        case .calendar:
//            component = .calendar
//        case .timeZone:
//            component = .timeZone
//        default:
//            component = .calendar
//        }
//        return component
//    }
//}
