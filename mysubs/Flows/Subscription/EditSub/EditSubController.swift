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
    //FIXME: MEMORY PROPERTIES from viewmodel values (to delete??)
    var sub: Subscription = Subscription()
    var categorys: [SubCategory] = []
    
    var commitmentPickerView = UIPickerView()
    var reminderPickerView = UIPickerView()
    let component1 = Array(stride(from: 0, to: 30 + 1, by: 1))
    let component2 = ["", "Jour(s)","Semaine(s)", "Mois", "Année(s)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        self.commitment.textField.delegate = self
        commitmentPickerView.translatesAutoresizingMaskIntoConstraints = false
        reminder.translatesAutoresizingMaskIntoConstraints = false
        commitmentPickerView.dataSource = self
        commitmentPickerView.delegate = self
        reminderPickerView.dataSource = self
        reminderPickerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.subscription = sub
//        self.viewModel?.categorys = categorys
    }
    
    //MARK: -OJBC METHODS
    
    @objc func deleteSub() {
//        showAlert("Attention vous allez supprimer votre abonnement", "Confirmez vous la suppression de l'abonnement \(String(describing: sub.name)) ?")
        viewModel?.delete()
        viewModel?.goBack()
    }
    
    @objc func doneEditingAction() {
        saveEditedSub()
        viewModel?.save()
        viewModel?.goBack()
    }
    
    //MARK: -Private METHODS
    private func saveEditedSub() {
        guard let name = name.textField.text,
              let price = Float(price.textField.text ?? "0"),
              let commitment = commitment.textField.text,
              let reminder = reminder.textField.text else { return }
        sub.setValue(name, forKey: "name")
        sub.setValue(price, forKey: "price")
        sub.setValue(commitment, forKey: "commitment")
        sub.setValue(reminder, forKey: "reminder")
    }
    
    private func refreshWith(subscription: Subscription) {
//        nameField.text = sub.name
        print("sub.name est : \(String(describing: sub.name))")
    }
   
}

//MARK: - PICKERVIEWSETTINGS
extension EditSubController: UIPickerViewDataSource, UIPickerViewDelegate {
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == commitmentPickerView {
            if component == 0 {
                if row != 0  {
                    return ("\(component1[row])")
                } else {
                    return "Pour toujours"
                }
            } else {
                return component2[row]
            }
        } else {
            if component == 0 {
                return ("\(component1[row])")
            } else if component == 1 {
                return component2[row]
            } else {
                return "avant"
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == commitmentPickerView {
            return 2
        } else {
            return 3
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == commitmentPickerView {
            if component == 0 {
                //let min = 1 let max = 30 var pickerData = [Int]() pickerData = Array(stride(from: min, to: max + 1, by: 1))
                return component1.count//31//pickerData.count
            } else {
                return component2.count
            }
        } else {
            if component == 0 {
                return component1.count
            } else if component == 1 {
                return component2.count
            } else {
                return 1
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
        }
        
        if pickerView == commitmentPickerView {
            let string0 = component1[pickerView.selectedRow(inComponent: 0)]
            let string1 = component2[pickerView.selectedRow(inComponent: 1)]
            commitment.textField.text = "\(string0) \(string1)"
        }
        else {
            let string0 = component1[pickerView.selectedRow(inComponent: 0)]
            let string1 = component2[pickerView.selectedRow(inComponent: 1)]
            let string2 = "avant"
            reminder.textField.text = "\(string0) \(string1) \(string2)"
        }
    }
}
// MARK: -Protocol from UITextFieldDelegate

extension EditSubController: UITextFieldDelegate {
    
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
        commitment.configureView()
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
        commitment.label.text = "Engagement"
        commitment.label.textColor = MSColors.maintext
        commitment.textField.text = sub.commitment
        commitment.textField.borderStyle = .roundedRect
        commitment.textField.inputView = commitmentPickerView
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
        //FIXME: Afficher cellule aligner avec leftStackView
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
//        reminder.backgroundColor = .cyan
        reminder.textField.leftViewMode = .always
        reminder.textField.inputView = reminderPickerView//subInfo.reminder
        reminder.textField.borderStyle = .roundedRect
        reminder.textField.translatesAutoresizingMaskIntoConstraints = false
        reminder.textField.allowsEditingTextAttributes = false
        reminder.textField.text = sub.reminder
        //MARK: Adding recurrency field
        rightSideStackView.addArrangedSubview(recurrency)
//        recurrency.backgroundColor = .green
        recurrency.translatesAutoresizingMaskIntoConstraints = false
        recurrency.label.text = "Récurrence paiement"
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
//        modifyButton.backgroundColor = UIColor(named: "reverse_bg")
//        modifyButton.addCornerRadius()
//        deleteButton.backgroundColor = UIColor(named: "reverse_bg")
        deleteButton.addCornerRadius()
        view.addSubview(footerStackView)
//        modifyButton.translatesAutoresizingMaskIntoConstraints = false
        
        deleteButton.titleLabel?.textAlignment = .center
        footerStackView.addArrangedSubview(modifyButton)
//        modifyButton.setTitle("Modifier", for: .normal)
//        modifyButton.titleLabel!.textAlignment = .center
//        modifyButton.titleLabel!.textColor = UIColor(named: "reverse_bg")
//
//        modifyButton.setTitleColor(MSColors.maintext, for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        footerStackView.addArrangedSubview(deleteButton)
        deleteButton.setTitle("Supprimer", for: .normal)
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
        footerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
        footerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        footerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        footerStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
