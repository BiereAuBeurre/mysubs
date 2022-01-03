//
//  ReminderModalController.swift
//  mysubs
//
//  Created by Manon Russo on 28/12/2021.
//

import Foundation
import UIKit

class CommitmentModalController: /*UINavigationController*/UIViewController, UINavigationBarDelegate {
    var numberPicker = UIPickerView()
    var viewModel: EditSubViewModel?
//    var categorys: [SubCategory] = []
    
    let doneButton: UIButton = UIButton(type: .custom)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


//        let doneButton: UIButton = UIButton(type: .custom)
//        doneButton.setTitle("Terminer", for: .normal)
//        let rightBarButtonItem:UIBarButtonItem = UIBarButtonItem(customView: doneButton)
//        rightBarButtonItem.customView = doneButton
//        navigationItem.rightBarButtonItem = rightBarButtonItem
//        rightBarButtonItem.customView?.isHidden = false
        setUpBasicUI()
    }
    
    @objc func doneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func setUpBasicUI() {
        view.backgroundColor = MSColors.background
        numberPicker.delegate = self
        numberPicker.dataSource = self
        numberPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numberPicker)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Terminer", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        doneButton.backgroundColor = .cyan
        view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            numberPicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            numberPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            numberPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            numberPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
//            doneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            doneButton.heightAnchor.constraint(equalToConstant: 20),
            doneButton.bottomAnchor.constraint(equalTo: numberPicker.topAnchor, constant: 16)
        ])
    }
//    let min = 0
//    let max = 30
//  var pickerData = [Int]()
}
    //MARK: PICKER VIEW PROTOCOL and SET UP
 
extension CommitmentModalController: UIPickerViewDataSource, UIPickerViewDelegate {
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            let pickerData = Array(stride(from: 0, to: 30 + 1, by: 1))
            if row != 0  {
                return ("\(pickerData[row])")
            } else {
                return "Pour toujours"
            }
        } else {
            let pickerData = ["", "Jour(s)","Semaine(s)", "Mois", "Années"]
            return pickerData[row]
        }
        //        if component == 0 {
        //            return "\(row)"
        //        } else {
        //            return "Second / \(row)"
        //        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
//            let min = 1 let max = 30 var pickerData = [Int]() pickerData = Array(stride(from: min, to: max + 1, by: 1))
            return 31//pickerData.count
        } else {
            return 5
        }
        
    }
    
    func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
        let pickerData = ["", "Jour(s)","Semaine(s)", "Mois", "Années"]
        let selectedValue = pickerData[row]
        viewModel?.subscription?.commitment = selectedValue
    }

}
