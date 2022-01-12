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
    
//    var commitment = InputFormTextField()
    var commitmentTitle = UILabel()
    var commitmentDate = UIDatePicker()
    let commitmentStackView = UIStackView()

    
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

    let componentNumber = Array(stride(from: 1, to: 30 + 1, by: 1))
    let componentDayMonthYear = ["jour(s)","semaine(s)", "mois", "année(s)"]
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    
    var selectedRow = 0
    var reminderPickerView = UIPickerView()
    var recurrencyPickerView = UIPickerView()
    
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
    @objc func deleteSub() {
        deletingAlert()
    }
    
    @objc func doneEditingAction() {
        viewModel?.saveEditedSub()
        viewModel?.goBack()
    }
    
    //MARK: -Private METHODS
    
    @objc func changeReminder() {
        print(#function)
//        showColorPicker()
        showPicker(reminderPickerView, reminder)
    }
    
    @objc func changeReccurency() {
        showPicker(recurrencyPickerView, recurrency)
    }
    
    private func deletingAlert() {
        let alert = UIAlertController(title: "Suppression de l'abonnement", message: "Êtes-vous sur de vouloir supprimer l'abonnement : \(viewModel?.subscription.name ?? "")", preferredStyle: .alert)
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
        print("sub.name est : \(String(describing: viewModel?.subscription.name))")
    }
    
    
    
//    func showColorPicker() {
//        var selectedColor = UIColor()
//        let colorPicker = UIColorPickerViewController()
//        colorPicker.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
//        selectedColor = colorPicker.selectedColor
//
//        self.present(colorPicker, animated: true, completion: nil)
//        print("selected color is: \(selectedColor)")
//
//    }
    
    private func showPicker(_ picker : UIPickerView, _ input: InputFormTextField) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
//        picker.frame.width = screenWidth
//        picker.frame.height = screenHeight
//        = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height:screenHeight))
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
        
        alert.addAction(UIAlertAction(title: "Ajouter", style: .default, handler: { (UIAlertAction) in
            self.selectedRow = picker.selectedRow(inComponent: 0)
            //voir methode select row commenté
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
    
//        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//            if component == 0 {
//                pickerView.reloadComponent(1)
//            }
//
//            if pickerView == recurrencyPickerView {
//                let string0 = componentNumber[pickerView.selectedRow(inComponent: 0)]
//                let string1 = componentDayMonthYear[pickerView.selectedRow(inComponent: 1)]
//                recurrency.textField.text = "\(string0) \(string1)"
//            }
//            else {
//                let string0 = componentNumber[pickerView.selectedRow(inComponent: 0)]
//                let string1 = componentDayMonthYear[pickerView.selectedRow(inComponent: 1)]
//                let string2 = "avant"
//                reminder.textField.text = "\(string0) \(string1) \(string2)"
//            }
//        }

}

//// MARK: -Protocol from UITextFieldDelegate
//
//extension EditSubController: UITextFieldDelegate {
//    //FIXME:
//    //MARK: making uneditable fields with pickerView
////    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
////        if textField == commitment.textField {
////          // code which you want to execute when the user touch myTextField
////            print("can't edit here")
////       }
////       return false
////    }
//
//}

// MARK: -SETTING UP ALL UI
extension EditSubController {
    
    private func setUpUI() {
        setUpNavBar()
        setUpView()
        //FIXME: fonctionne plus, pour supprimer bar texte sur textfield
//        self.commitment.textField.delegate = self
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
        category.configureView()
        info.configureView()
        price.configureView()
        reminder.configureView()
        recurrency.configureView()
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
//        leftSideStackView.contentMode = .top
        leftSideStackView.axis = .vertical
//        leftSideStackView.alignment = .leading
        leftSideStackView.distribution = .fillEqually
//        leftSideStackView.spacing = 8
//        //MARK: Adding name field
        leftSideStackView.addArrangedSubview(name)
        name.fieldTitle = "Nom"
        name.text = viewModel?.subscription.name
        print("viewmodel.sub.name :\(String(describing: viewModel?.subscription.name))")
        // configurer la inpute view pour le name
        name.textFieldInputView = UIView()
        
        //MARK: Adding commitment field
        commitmentTitle.text = "Dernier paiement"
        commitmentDate.datePickerMode = .date
        commitmentDate.translatesAutoresizingMaskIntoConstraints = false
        configureCommitment()
        commitmentDate.locale = Locale.init(identifier: "fr_FR")
        commitmentDate.date = viewModel?.subscription.commitment ?? Date.now
        leftSideStackView.addArrangedSubview(commitmentStackView)
        //MARK: Adding info field
        leftSideStackView.addArrangedSubview(info)
        info.fieldTitle = "INFOS"
        info.text = viewModel?.subscription.extraInfo ?? ""
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
        price.text = "\(viewModel?.subscription.price ?? 0)"
        //MARK: Adding reminder field
        rightSideStackView.addArrangedSubview(reminder)
        reminder.fieldTitle = "Rappel"
        reminder.textField.allowsEditingTextAttributes = false
        reminder.text = viewModel?.subscription.reminder
        reminder.shouldBehaveAsButton = true
        reminder.addTarget(self, action: #selector(changeReminder), for: .touchUpInside)
        
        //MARK: Adding recurrency field
        rightSideStackView.addArrangedSubview(recurrency)
        recurrency.fieldTitle = "Cycle"
        recurrency.text = "\(viewModel?.subscription.paymentRecurrency ?? "cassé")"
        recurrency.shouldBehaveAsButton = true
        recurrency.addTarget(self, action: #selector(changeReccurency), for: .touchUpInside)
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
