//
//  LogoFinderService.swift
//  mysubs
//
//  Created by Manon Russo on 30/11/2021.
//
import Foundation

class LogoFinderService {
    let httpHeader = "\(APIConfiguration.apiKey)"
    //        request.addValue(authorizationKey, forHTTPHeaderField: "Authorization")
    private var task: URLSessionDataTask?
    private var urlSession: URLSession = URLSession(configuration: .default)
    //    private override init() {}
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    private func loadLogoToGet(_ logoAsked: String) -> String{
        let stringUrl = "https://autocomplete.clearbit.com/v1/companies/suggest?query=\(logoAsked)"
        return stringUrl
    }
}




//    func fetchLogoData(_ logoAsked: String, completion: (Result<BrandInfo, Error>)) {
//        guard let logoUrl = URL(string: loadLogoToGet("nike")) else { return completion(.failure("invalid url" as! Error)) }
//        task?.cancel()
//        task = urlSession.dataTask(with: logoUrl) { data, response, error in
//            if let _ = error {
//                return print("error from API")
//            }
//            guard let response = response as? HTTPURLResponse else {
//                return print("error invalid response")
//            }
//            guard response.statusCode == 200 else {
//                return print("status code isnt 200, error")
//            }
//            guard let data = data else {
//                return print("error empty  data")
//            }
//            do {
//                let decodedData = try JSONDecoder().decode(BrandInfo.self, from: data)
//                return .success(decodedData)
//            } catch let error {
//                print(error)
//                return .failure("error decoding data")
//            }
//
//        }
//    }
//    private let session: Session
//    init(session: Session = .default) {
//        self.session = session
//    }
//
//    func testingClearBit(for searchTerms: String) {
//        let headers: HTTPHeaders = [
//            "Authorization": "\(httpHeader)"
//        ]
//
//
//
//
//        AF.request("https://autocomplete.clearbit.com/v1/companies/suggest?query=\(searchTerms)", headers: headers).responseJSON { response in
//            debugPrint(response)
//        }
//
//    }
