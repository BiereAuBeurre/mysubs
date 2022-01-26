//
//  Strings.swift
//  mysubs
//
//  Created by Manon Russo on 03/12/2021.
//

import Foundation

enum Strings {
    // Pour fichier de trad, on appelle ces statics let dans le code et on change la valeur ici
    static let menuTitle = "Menu"
    static let genericCancel = "generic_cancel".localized
    
    //NSLocalizedString("generic_cancel", comment: "alert when deleting subs")
}


extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
