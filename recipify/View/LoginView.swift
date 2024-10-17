//
//  LoginView.swift
//  recipify
//
//  Created by Timo Ischen on 15.10.24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showingRegister = false
    
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password)
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Login") {
                authViewModel.login(email: email, password: password)
            }
            .padding()
            Button("Register") {
                showingRegister = true
            }
            .sheet(isPresented: $showingRegister) {
                RegisterView()
                    .environmentObject(authViewModel)
            }
        }
        .padding()
        .alert(item: $authViewModel.errorMessage) { errorMessage in
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthenticationViewModel())
}
