//
//  RecipeDetailView.swift
//  recipify
//
//  Created by Timo Ischen on 16.10.24.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @State private var showingEditView = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(recipe.title)
                .font(.title)
                .font(.largeTitle)
            Divider()
            Text(recipe.description)
                .padding(.top)
            Spacer()
        }
        .padding()
        .navigationTitle("Rezept Details")
        .navigationBarItems(trailing: Button("Bearbeiten") {
            showingEditView = true
        })
        .sheet(isPresented: $showingEditView) {
            EditRecipeView(recipe: recipe)
                .environmentObject(recipeViewModel)
        }
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe(id: 1, title: "Mett Igel", description: "Lecker lecker Mett"))
        .environmentObject(RecipeViewModel())
}
