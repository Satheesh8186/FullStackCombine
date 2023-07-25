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
        guard let url = URL(string: "http://localhost:8080/v1/signup") else { return  }
        
        ApiCallManger.shared.makeApiReqest(from: url,method:.post,body: reqData,modelType: SignupModel.self).sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print("error in api calling",error)
                break
            }
        } receiveValue: {[weak self] data in
            self?.status = data.status
            self?.errorMsg = data.errorMsg
        }
        .store(in: &cancellables)
        
    }
    
    
    
}
