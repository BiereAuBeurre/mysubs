//
//  InputFormTextField.swift
//  mysubs
//
//  Created by Manon Russo on 29/12/2021.
//

import UIKit

class InputFormTextField: UIControl, UIPickerViewDelegate, UIPickerViewDataSource {
    var logoHeader = UIImageView()
    
    var stackView = UIStackView()
    var label = UILabel()
    var textField = UITextField()
    
    var reminderPickerView = UIPickerView()
    var recurrencyPickerView = UIPickerView()
    let componentNumber = Array(stride(from: 1, to: 30 + 1, by: 1))
    let componentDayMonthYear = ["jour(s)","semaine(s)", "mois", "année(s)"]
    
    func setUpPickerView() {
        
        recurrencyPickerView.dataSource = self
        recurrencyPickerView.delegate = self
        reminderPickerView.dataSource = self
        reminderPickerView.delegate = self
        
        if label.text == "Rappel" {
        textField.inputView = reminderPickerView
        } else {
            textField.inputView = recurrencyPickerView
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

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            textField.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
   
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
            textField.text = "\(string0) \(string1)"
        }
        else {
            let string0 = componentNumber[pickerView.selectedRow(inComponent: 0)]
            let string1 = componentDayMonthYear[pickerView.selectedRow(inComponent: 1)]
            let string2 = "avant"
           textField.text = "\(string0) \(string1) \(string2)"
        }
    }
}


// FIXME: making uneditable textfield from keyboard for commitment, reccurency and reminder (only from associated picker view)
extension InputFormTextField: UITextFieldDelegate {
    
    //MARK: making uneditable fields with pickerView
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if textField == self.textField {
//          // code which you want to execute when the user touch myTextField
//            print("can't edit here")
//       }
//       return false
//    }
    
}
