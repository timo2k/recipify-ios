//
//  AuthenticationViewModel.swift
//  recipify
//
//  Created by Timo Ischen on 15.10.24.
//

import Foundation
import Combine

class AuthenticationViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        if NetworkManager.shared.token != nil {
            self.isAuthenticated = true
        }
    }
    
    func register(email: String, password: String, displayName: String) {
        NetworkManager.shared.register(email: email, password: password, displayName: displayName)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { _ in
                //TODO: Login automatically after registration
            })
            .store(in: &cancellables)
    }
    
    func login(email: String, password: String) {
        NetworkManager.shared.login(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] in
                self?.isAuthenticated = true
            })
            .store(in: &cancellables)
    }
}
