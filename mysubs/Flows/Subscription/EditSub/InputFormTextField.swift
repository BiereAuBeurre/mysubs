//
//  InputFormTextField.swift
//  mysubs
//
//  Created by Manon Russo on 29/12/2021.
//

import UIKit

class InputFormTextField: UIControl {
    var logoHeader = UIImageView()
    
    var stackView = UIStackView()
    var label = UILabel()
    var textField = UITextField()
    
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
