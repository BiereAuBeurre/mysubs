//
//  LogoFinderService.swift
//  mysubs
//
//  Created by Manon Russo on 30/11/2021.
//
import Foundation
import SystemConfiguration

class LogoFinderService {
    let httpHeader = "\(APIConfiguration.apiKey)"
    //        request.addValue(authorizationKey, forHTTPHeaderField: "Authorization")
    private var task: URLSessionDataTask?
    private var urlSession: URLSession = URLSession(configuration: .default)
    //    private override init() {}
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    private func loadLogoToGet(_ logoAsked: String) -> String {
        let stringUrl = "https://autocomplete.clearbit.com/v1/companies/suggest?query=\(logoAsked)"
        return stringUrl
    }

    func handleResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<BrandInfo, Error> {
        if let error = error {
            return .failure(error.localizedDescription as! Error)
        }
        guard let response = response as? HTTPURLResponse else {
            return .failure(error?.localizedDescription as! Error)
        }
        guard response.statusCode == 200 else {
            return .failure(error?.localizedDescription as! Error)
        }
        guard let data = data else {
            return .failure(error?.localizedDescription as! Error)
        }
        do {
            let decodedData = try JSONDecoder().decode(BrandInfo.self, from: data)
            return .success(decodedData)
        } catch let error {
            print(error)
            return .failure(error.localizedDescription as! Error)
        }
    }
    
    func fetchLogoData(_ logoAsked: String, completion: @escaping (Result<BrandInfo, Error>) -> Void) {
        guard let logoUrl = URL(string: loadLogoToGet("nike")) else { return completion(.failure("invalid url" as! Error)) }
        task?.cancel()
        
        task = urlSession.dataTask(with: logoUrl) { data, response, error in
            let result = self.handleResponse(data, response, error)
            completion(result)
            print("\(result)")
        }
        task?.resume()
    }
}
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
