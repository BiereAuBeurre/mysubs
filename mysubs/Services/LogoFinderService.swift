//
//  LogoFinderService.swift
//  mysubs
//
//  Created by Manon Russo on 30/11/2021.
//
import Foundation
import Alamofire

class LogoFinderService {
    let httpHeader = "\(APIConfiguration.apiKey)"

    private let session: Session
    init(session: Session = .default) {
        self.session = session
    }

    func testingClearBit(for searchTerms: String) {
        let headers: HTTPHeaders = [
            "Authorization": "\(httpHeader)"
        ]
        
        AF.request("https://autocomplete.clearbit.com/v1/companies/suggest?query=\(searchTerms)", headers: headers).responseJSON { response in
            debugPrint(response)
        }
        
    }
}
