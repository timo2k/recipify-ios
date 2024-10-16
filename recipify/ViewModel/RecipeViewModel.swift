//
//  RecipeViewModel.swift
//  recipify
//
//  Created by Timo Ischen on 15.10.24.
//

import Foundation
import Combine

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    
    func fetchRecipes() {
        NetworkManager.shared.getRecipes()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] recipes in
                self?.recipes = recipes
            })
            .store(in: &cancellables)

    }
    
    func createRecipe(title: String, description: String) {
        NetworkManager.shared.createRecipe(title: title, description: description)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] recipe in
                self?.recipes.append(recipe)
            })
            .store(in: &cancellables)
    }
    
    func editRecipe(recipe: Recipe, title: String, description: String) {
        NetworkManager.shared.editRecipe(id: recipe.id, title: title, description: description)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] updatedRecipe in
                if let index = self?.recipes.firstIndex(where: { $0.id == updatedRecipe.id }) {
                    self?.recipes[index] = updatedRecipe
                }
            })
            .store(in: &cancellables)

    }
        
}
