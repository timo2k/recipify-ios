//
//  recipifyApp.swift
//  recipify
//
//  Created by Timo Ischen on 15.10.24.
//

import SwiftUI

@main
struct recipifyApp: App {
    @StateObject var authViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                RecipeListView()
                    .environmentObject(authViewModel)
            } else {
                LoginView()
                    .environmentObject(authViewModel)
            }
        }
    }
}

extension Optional where Wrapped == String {
    var isNotNil: Bool {
        self != nil
    }
}

extension String: Identifiable {
    public var id: Self { self }
}
