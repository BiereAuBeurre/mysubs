//
//  InputFormTextField.swift
//  mysubs
//
//  Created by Manon Russo on 29/12/2021.
//

import UIKit
class InputFormTextField: UIControl {
    
    var textFieldInputView: UIView? {
        didSet {
            textField.inputView = inputView
        }
    }
    
    var logoHeader = UIImageView()
    var stackView = UIStackView()
    var label = UILabel()
    let textField = UITextField()
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
    
    var shouldBehaveAsButton = false {
        didSet {
            guard shouldBehaveAsButton else { return }
            stackView.isUserInteractionEnabled = false
            textField.isUserInteractionEnabled = false
            //textField.removeTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
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
//        stackView.alignment = .fill
        stackView.spacing = 8
        textField.borderStyle = .roundedRect
        label.textColor = MSColors.maintext
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            textField.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
}
