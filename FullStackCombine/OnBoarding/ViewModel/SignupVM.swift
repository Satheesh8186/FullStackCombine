//
//  SignupVM.swift
//  FullStackCombine
//
//  Created by satheesh kumar on 25/07/23.
//

import Foundation
import Combine
class SignupVM:ObservableObject{
    @Published var status: Int?
    @Published var errorMsg: String?
    @Published var errorMessage: String = ""
    private var cancellables = Set<AnyCancellable>()
    func singuPApiCall(reqData : [String:String]){
        guard let url = URL(string: "http://localhost:8080/v1/signup") else { return }
        APIService.requestData(method: .post, url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error in API calling:", error)
                }
            }, receiveValue: { (response: SignupModel) in
                self.status = response.status
                self.errorMsg = response.errorMsg
            })
            .store(in: &cancellables)
    }
}
