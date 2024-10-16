//
//  RecipeListView.swift
//  recipify
//
//  Created by Timo Ischen on 15.10.24.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject var recipeViewModel = RecipeViewModel()
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State private var showingCreateRecipe = false
    
    var body: some View {
        NavigationView {
            List(recipeViewModel.recipes) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)
                    .environmentObject(recipeViewModel)) {
                    Text(recipe.title)
                }
            }
            .onAppear {
                recipeViewModel.fetchRecipes()
            }
            .navigationTitle("Meine Rezepte")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Logout") {
                        authViewModel.isAuthenticated = false
                        NetworkManager.shared.token = nil
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingCreateRecipe = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showingCreateRecipe) {
                        CreateRecipeView()
                            .environmentObject(recipeViewModel)
                    }
                }
            }
        }
        .alert(item: $recipeViewModel.errorMessage) { errorMessage in
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    RecipeListView()
        .environmentObject(AuthenticationViewModel())
}
