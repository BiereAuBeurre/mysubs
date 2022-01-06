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
    var logoHeader = UIImageView()
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
    var suggestedLogo = UILabel()
    //MARK: -FOOTER BUTTON PROPERTIES
    var footerStackView = UIStackView()
    var modifyButton = UIButton()
    var deleteButton = UIButton()
    var viewModel: EditSubViewModel?
    var storageService = StorageService()
    //FIXME: deleteing sub and calling viewModel?.sub instead ?
    var sub: Subscription = Subscription()
//    var categorys: [SubCategory] = []
    
    var recurrencyPickerView = UIPickerView()
    var reminderPickerView = UIPickerView()
    var paymentDatePicker = UIDatePicker()
    let componentNumber = Array(stride(from: 1, to: 30 + 1, by: 1))
    let componentDayMonthYear = ["jour(s)","semaine(s)", "mois", "année(s)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.subscription = sub
//        self.viewModel?.categorys = categorys
    }
    
    //MARK: -OJBC METHODS
    @objc func cancelPressed() {
        commitment.textField.resignFirstResponder()
    }
    
    @objc func didEditDate() {
        commitment.textField.text = formatteDate()
        commitment.textField.resignFirstResponder()
    }
    
    @objc func deleteSub() {
        deletingAlert()
    }
    
    @objc func doneEditingAction() {
        viewModel?.saveEditedSub()
        viewModel?.goBack()
    }
    
    //MARK: -Private METHODS
    private func deletingAlert() {
        let alert = UIAlertController(title: "Suppression de l'abonnement", message: "Êtes-vous sur de vouloir supprimer l'abonnement : \(sub.name ?? "")", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Confirmer", style: .default) { [unowned self] action in
            viewModel?.delete()
            viewModel?.goBack()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func refreshWith(subscription: Subscription) {
//        nameField.text = sub.name
        print("sub.name est : \(String(describing: sub.name))")
    }
    
    func formatteDate() -> String {
        //MARK: Setting up date format to return
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "fr_FR")
        dateFormatter.dateFormat = "dd MMM yyyy"
        let selectedDate = dateFormatter.string(from: paymentDatePicker.date)
        return selectedDate
    }
}


//MARK: - PICKERVIEW SETTINGS
extension EditSubController: UIPickerViewDataSource, UIPickerViewDelegate {
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == recurrencyPickerView {
            if component == 0 {
                return ("\(componentNumber[row])")
            } else {
                return componentDayMonthYear[row]
            }
        } else {
            if component == 0 {
                return ("\(componentNumber[row])")
            }
            else if component == 1 {
                return componentDayMonthYear[row]
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
        }
        
        if pickerView == recurrencyPickerView {
            let string0 = componentNumber[pickerView.selectedRow(inComponent: 0)]
            let string1 = componentDayMonthYear[pickerView.selectedRow(inComponent: 1)]
            recurrency.textField.text = "\(string0) \(string1)"
        }
        else {
            let string0 = componentNumber[pickerView.selectedRow(inComponent: 0)]
            let string1 = componentDayMonthYear[pickerView.selectedRow(inComponent: 1)]
            let string2 = "avant"
            reminder.textField.text = "\(string0) \(string1) \(string2)"
        }
    }
}
// MARK: -Protocol from UITextFieldDelegate

extension EditSubController: UITextFieldDelegate {
    //FIXME: 
    //MARK: making uneditable fields with pickerView
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if textField == commitment.textField {
//          // code which you want to execute when the user touch myTextField
//            print("can't edit here")
//       }
//       return false
//    }

}

// MARK: -SETTING UP ALL UI
extension EditSubController {
    
    private func setUpUI() {
        setUpNavBar()
        setUpView()
        recurrencyPickerView.translatesAutoresizingMaskIntoConstraints = false
        reminder.translatesAutoresizingMaskIntoConstraints = false
        recurrencyPickerView.dataSource = self
        recurrencyPickerView.delegate = self
        reminderPickerView.dataSource = self
        reminderPickerView.delegate = self
        //FIXME: fonctionne plus, pour supprimer bar texte sur textfield
        self.commitment.textField.delegate = self

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
    
    private func addInputViewDatePicker() {
        //MARK: DatePicker settings
        paymentDatePicker.datePickerMode = .date
        paymentDatePicker.preferredDatePickerStyle = .wheels
        paymentDatePicker.translatesAutoresizingMaskIntoConstraints = false
        paymentDatePicker.locale = Locale.init(identifier: "fr_FR")
//        commitment.textField.inputView = paymentDatePicker
        let screenWidth = UIScreen.main.bounds.width
        //MARK: ToolBar settings
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didEditDate))
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        commitment.textField.inputAccessoryView = toolBar
     }
    
    private func setUpView() {
        
        commitment.configureView()
        name.configureView()
        category.configureView()
        info.configureView()
        price.configureView()
        reminder.configureView()
        recurrency.configureView()
        //MARK: DatePicker SetUp
        addInputViewDatePicker()
        
        view.backgroundColor = MSColors.background
        logoHeader.translatesAutoresizingMaskIntoConstraints = false
        logoHeader.image = UIImage(named: "ps")
        view.addSubview(logoHeader)
        
        // MARK: FORMVIEW
        formView.translatesAutoresizingMaskIntoConstraints = false
        formView.axis = .horizontal
        formView.alignment = .fill
        formView.spacing = 8
        formView.distribution = .fillEqually
        view.addSubview(formView)
        
    //MARK: LEFTSIDE STACKVIEW
        leftSideStackView.translatesAutoresizingMaskIntoConstraints = false
        leftSideStackView.contentMode = .top
        leftSideStackView.axis = .vertical
        leftSideStackView.alignment = .fill
        leftSideStackView.distribution = .fillEqually
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
        commitment.label.text = "Dernier paiement"
        commitment.label.textColor = MSColors.maintext
        commitment.textField.text = "\(sub.commitment ?? "")"
        commitment.textField.borderStyle = .roundedRect
        //MARK: Adding info field
        leftSideStackView.addArrangedSubview(info)
        info.translatesAutoresizingMaskIntoConstraints = false
        info.label.text = "INFOS"
        info.label.textColor = MSColors.maintext
        info.textField.borderStyle = .roundedRect
        info.textField.translatesAutoresizingMaskIntoConstraints = false
        info.textField.text = sub.extraInfo ?? ""
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
        price.label.text = "Prix"
        price.textField.text = "\(sub.price)"
        price.textField.borderStyle = .roundedRect
        price.textField.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Adding reminder field
        rightSideStackView.addArrangedSubview(reminder)
        reminder.translatesAutoresizingMaskIntoConstraints = false
        reminder.label.text = "Rappel"
        reminder.textField.leftViewMode = .always
        reminder.textField.inputView = reminderPickerView
        reminder.textField.borderStyle = .roundedRect
        reminder.textField.translatesAutoresizingMaskIntoConstraints = false
        reminder.textField.allowsEditingTextAttributes = false
        reminder.textField.text = sub.reminder
        //MARK: Adding recurrency field
        rightSideStackView.addArrangedSubview(recurrency)
        recurrency.translatesAutoresizingMaskIntoConstraints = false
        recurrency.label.text = "Cycle"
        recurrency.textField.text = "\(sub.paymentRecurrency ?? "")"
        recurrency.textField.inputView = recurrencyPickerView
        recurrency.textField.borderStyle = .roundedRect
        recurrency.textField.translatesAutoresizingMaskIntoConstraints = false
        formView.addArrangedSubview(rightSideStackView)

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
        logoHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        logoHeader.widthAnchor.constraint(equalToConstant: 100),
        logoHeader.heightAnchor.constraint(equalToConstant: 100),
        logoHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
        formView.topAnchor.constraint(equalTo: logoHeader.bottomAnchor, constant: 40),
        formView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        formView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        formView.heightAnchor.constraint(equalToConstant: 250),
        deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
        deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        deleteButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}






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
