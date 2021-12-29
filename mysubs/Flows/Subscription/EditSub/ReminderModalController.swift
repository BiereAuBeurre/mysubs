//
//  ReminderModalController.swift
//  mysubs
//
//  Created by Manon Russo on 28/12/2021.
//

import Foundation
import UIKit

class ReminderModalController: UIViewController {
    var numberPicker = UIPickerView()
    var viewModel: EditSubViewModel?
    var categorys: [SubCategory] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.categorys = categorys
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBasicUI()
    }
    
    func setUpBasicUI() {
        view.backgroundColor = MSColors.background
        numberPicker.delegate = self
        numberPicker.dataSource = self
        numberPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numberPicker)
        
        NSLayoutConstraint.activate([
            numberPicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            numberPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            numberPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            numberPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8)
        ])
    }
}
    //MARK: PICKER VIEW PROTOCOL and SET UP
 
extension ReminderModalController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let pickerDataSource = categorys
        return pickerDataSource[row].name
//        if component == 0 {
//            return "First \(row)"
//        } else {
//            return "Second \(row)"
//        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //    let min = 1
        //    let max = 30
        //    var pickerData = [Int]()
        //    pickerData = Array(stride(from: min, to: max + 1, by: 1))
        //    return pickerData.count
        print("category.count : \(categorys.count)")
        return categorys.count
    }
    
}

