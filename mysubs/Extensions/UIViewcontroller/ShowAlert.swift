//
//  ShowAlert.swift
//  mysubs
//
//  Created by Manon Russo on 01/12/2021.
//

import UIKit

extension UIViewController {
    /// This methods is creating a UIAlert.
    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
//    func deletingAlert() {
//        let alert = UIAlertController(title: "Suppression de l'abonnement", message: "Êtes-vous sur de vouloir supprimer l'abonnement : \(sub.name ?? "")", preferredStyle: .alert)
//        let deleteAction = UIAlertAction(title: "Confirmer", style: .default) { [unowned self] action in
//            viewModel?.delete()
//            viewModel?.goBack()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        alert.addAction(deleteAction)
//        alert.addAction(cancelAction)
//        present(alert, animated: true)
//    }
    
}
