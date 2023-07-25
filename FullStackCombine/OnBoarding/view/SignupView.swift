//
//  SignupView.swift
//  FullStackCombine
//
//  Created by satheesh kumar on 25/07/23.
//

import SwiftUI

struct SignupView: View {
    @State private var userName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var conformPassword: String = ""
    @State private var mobileNumber: String = ""
    @StateObject private var vm = SignupVM()
    var body: some View {
        VStack(spacing: 20){
            TextField("username", text: $userName)
                .accessibilityLabel("Label").textFieldStyle(.roundedBorder).padding(.horizontal, 20)
            TextField("email", text: $email).padding(.horizontal, 20).textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password).padding(.horizontal, 20).textFieldStyle(.roundedBorder)
            SecureField("Confrom Password", text: $conformPassword).padding(.horizontal, 20).textFieldStyle(.roundedBorder)
            TextField("Mobile Number", text: $mobileNumber).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.horizontal, 20)
            HStack(spacing:30){
                Button("Signup", action: onSignupButtonClicked)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                .cornerRadius(10)
                Button("Login", action: onSignupButtonClicked)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 10.0)
            
        }
    }
    
    func onSignupButtonClicked() {
        let reqData = [
            "user_name": userName,
            "email": email,
            "password": password,
            "mobileNumber" : mobileNumber
        ]
        vm.singuPApiCall(reqData: reqData)
    }
    func emptyTextfileds(){
        userName = ""
        email = ""
        password = ""
        mobileNumber = ""
        conformPassword = ""
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
