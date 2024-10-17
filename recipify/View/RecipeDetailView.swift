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
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(recipe.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Divider()
                Text(recipe.description)
                    .font(.body)
                Divider()
                Text("Zutaten")
                    .font(.headline)
                
                if recipe.ingredients.isEmpty {
                    Text("Keine Zutaten hinzugefügt")
                        .foregroundColor(.gray)
                } else {
                    ForEach(recipe.ingredients) { ingredient in
                        HStack {
                            Text("\(ingredient.amount) \(ingredient.unit) \(ingredient.name)")
                                .font(.subheadline)
                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
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
    let sampleIngredients = [
        Ingredient(id: 9, name: "Salzstangen", unit: "Packung", amount: 1),
        Ingredient(id: 1, name: "Mett", unit: "Kilo", amount: 3)
    ]
    
    RecipeDetailView(recipe: Recipe(
        id: 1,
        title: "Mett Igel",
        description: "Lecker lecker Mett",
        ingredients: sampleIngredients
    ))
    .environmentObject(RecipeViewModel())
}
