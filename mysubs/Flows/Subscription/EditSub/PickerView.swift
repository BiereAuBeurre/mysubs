//
//  PickerView.swift
//  mysubs
//
//  Created by Manon Russo on 06/01/2022.
//

import UIKit

class CustomPickerView: UIPickerView {
    
    var valueToget = ""
    var recurrencyPickerView = UIPickerView()
    var reminderPickerView = UIPickerView()
    var paymentDatePicker = UIDatePicker()
    let componentNumber = Array(stride(from: 1, to: 30 + 1, by: 1))
    let componentDayMonthYear = ["jour(s)","semaine(s)", "mois", "année(s)"]
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
//            recurrency.textField.text = "\(string0) \(string1)"
        }
        else {
            let string0 = componentNumber[pickerView.selectedRow(inComponent: 0)]
            let string1 = componentDayMonthYear[pickerView.selectedRow(inComponent: 1)]
            let string2 = "avant"
            valueToget = "\(string0) \(string1)"
//            reminder.textField.text = "\(string0) \(string1) \(string2)"
        }
    }
}
