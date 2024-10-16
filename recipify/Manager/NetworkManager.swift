//
//  NetworkManager.swift
//  recipify
//
//  Created by Timo Ischen on 15.10.24.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
        
    private init() {
        self.token = UserDefaults.standard.string(forKey: "token")
    }
    
    let baseURL = "http://localhost:8080/api"
    
    var token: String? {
        didSet {
            if let token = token {
                UserDefaults.standard.set(token, forKey: "token")
            } else {
                UserDefaults.standard.removeObject(forKey: "token")
            }
        }
    }
    
    func register(email: String, password: String, displayName: String) -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(baseURL)/auth/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters = [
            "email": email,
            "password": password,
            "displayName": displayName
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { _ in ()}
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
    
    func login(email: String, password: String) -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(baseURL)/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Void in
                let decoder = JSONDecoder()
                let authResponse = try decoder.decode(AuthResponse.self, from: data)
                self.token = authResponse.token
            }
            .eraseToAnyPublisher()
    }
    
    func getRecipes() -> AnyPublisher<[Recipe], Error> {
        guard let token = token else {
            return Fail(error: URLError(.userAuthenticationRequired))
                .eraseToAnyPublisher()
        }
        let url = URL(string: "\(baseURL)/recipes")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> [Recipe] in
                let decoder = JSONDecoder()
                let recipes = try decoder.decode([Recipe].self, from: data)
                return recipes
            }
            .eraseToAnyPublisher()
    }
    
    func createRecipe(title: String, description: String) -> AnyPublisher<Recipe, Error> {
        guard let token = token else {
            return Fail(error: URLError(.userAuthenticationRequired))
                .eraseToAnyPublisher()
        }
        let url = URL(string: "\(baseURL)/recipes")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters = [
            "title": title,
            "description": description
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Recipe in
                let decoder = JSONDecoder()
                let recipe = try decoder.decode(Recipe.self, from: data)
                return recipe
            }
            .eraseToAnyPublisher()
    }
    
    func editRecipe(id: Int, title: String, description: String) -> AnyPublisher<Recipe, Error> {
        guard let token = token else {
            return Fail(error: URLError(.userAuthenticationRequired))
                .eraseToAnyPublisher()
        }
        let url = URL(string: "\(baseURL)/recipes/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        let parameters = [
            "title": title,
            "description": description,
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Recipe in
                let decoder = JSONDecoder()
                let recipe = try decoder.decode(Recipe.self, from: data)
                return recipe
            }
            .eraseToAnyPublisher()
    }
    
}
