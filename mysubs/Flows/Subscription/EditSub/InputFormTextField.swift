//
//  InputFormTextField.swift
//  mysubs
//
//  Created by Manon Russo on 29/12/2021.
//

import UIKit

//class REminderPicjerView: UIPickerViewDataSource {
//
//}


class InputFormTextField: UIControl/*, UIPickerViewDelegate, UIPickerViewDataSource */{
    
    var textFieldInputView: UIView? {
        didSet {
            textField.inputView = inputView
        }
    }
    
    var fieldTitle: String? {
        didSet {
            label.text = fieldTitle
        }
    }
    
    var text: String? {
        didSet {
            textField.text = text
        }
    }
    
   
    var logoHeader = UIImageView()
    
    var stackView = UIStackView()
    var label = UILabel()
    
    let textField = UITextField()
    
    var paymentDatePicker = UIDatePicker()
    //MARK: SETTING UP DATE PICKER
    @objc func cancelPressed() {
        textField.resignFirstResponder()
    }
    
    @objc func didEditDate() {
        textField.text = formatteDate()
        textField.resignFirstResponder()
    }
    
    func formatteDate() -> String {
        //MARK: Setting up date format to return
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "fr_FR")
        dateFormatter.dateFormat = "dd MMM yyyy"
        let selectedDate = dateFormatter.string(from: paymentDatePicker.date)
        return selectedDate
    }
    
    var shouldBehaveAsButton = false {
        didSet {
            guard shouldBehaveAsButton else { return }
            stackView.isUserInteractionEnabled = false
            textField.isUserInteractionEnabled = false
            //textField.removeTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        }
    }
    
    func addInputViewDatePicker() {
        //MARK: DatePicker settings
        paymentDatePicker.datePickerMode = .date
//        paymentDatePicker.preferredDatePickerStyle = .wheels
        paymentDatePicker.translatesAutoresizingMaskIntoConstraints = false
        paymentDatePicker.locale = Locale.init(identifier: "fr_FR")
        if label.text == "Dernier paiement" {
        textField.inputView = paymentDatePicker
           
        }
        let screenWidth = UIScreen.main.bounds.width
        //MARK: ToolBar settings
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didEditDate))
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        if label.text == "Dernier paiement" {
        textField.inputAccessoryView = toolBar
        }
     }
    
    func configureView() {
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        textField.borderStyle = .roundedRect
        label.textColor = MSColors.maintext
        

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            textField.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
}


// FIXME: making uneditable textfield from keyboard for commitment, reccurency and reminder (only from associated picker view)
//extension InputFormTextField: UITextFieldDelegate {
    
    //MARK: making uneditable fields with pickerView
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if textField == self.textField {
//          // code which you want to execute when the user touch myTextField
//            print("can't edit here")
//       }
//       return false
//    }
    
//}
