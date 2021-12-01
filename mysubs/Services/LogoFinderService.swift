//
//  LogoFinderService.swift
//  mysubs
//
//  Created by Manon Russo on 30/11/2021.
//
import Foundation
import Alamofire

class LogoFinderService {
    let httpHeader = "sk_660acc9a08a57b15fc87681a65fe5be8"

    private let session: Session
    init(session: Session = .default) {
        self.session = session
    }

    func testingClearBit() {
        let headers: HTTPHeaders = [
            "Authorization": "sk_660acc9a08a57b15fc87681a65fe5be8"
        ]
        
        AF.request("https://autocomplete.clearbit.com/v1/companies/suggest?query=laposte", headers: headers).responseJSON { response in
            debugPrint(response)
        }
        
    }
}
