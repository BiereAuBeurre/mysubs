//
//  AddDoneToolBar.swift
//  mysubs
//
//  Created by Manon Russo on 02/02/2022.
//
import UIKit
import Foundation
extension UITextField {
    // This method is defining the toolbar buttons of the keyboard and their actions.
    func addDoneToolBar() {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Fermer", style: .plain, target: self.target, action: #selector(closeKeyboard)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "OK", style: .plain, target: self.target, action: #selector(closeKeyboard))
        ]
        toolbar.sizeToFit()
        self.inputAccessoryView = toolbar
    }
    // Default action:
    @objc func closeKeyboard() { self.resignFirstResponder() }
}
