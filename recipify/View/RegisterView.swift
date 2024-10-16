//
//  RegisterView.swift
//  recipify
//
//  Created by Timo Ischen on 16.10.24.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var password = ""
    @State private var displayName = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Register")
                    .font(.largeTitle)
                TextField("Nickname", text: $displayName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Registrieren") {
                    authViewModel.register(email: email, password: password, displayName: displayName)
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    RegisterView()
        .environmentObject(AuthenticationViewModel())
}
