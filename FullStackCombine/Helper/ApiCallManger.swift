//
//  ApiCallManger.swift
//  FullStackCombine
//
//  Created by satheesh kumar on 25/07/23.
//

import Foundation
import Combine
enum HTTPMethod:String{
    case get = "GET"
    case post = "POST"
}
class ApiCallManger{
static let shared = ApiCallManger()
    
   private init() {}
    
    func makeApiReqest<T:Decodable>(from url:URL, method: HTTPMethod = .get, body:[String:String] = [:], modelType:T.Type) -> AnyPublisher<T,Error>{
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
               } catch {
                   return Fail(error: error).eraseToAnyPublisher()
               }
      
    }
}
