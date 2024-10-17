//
//  EditRecipeView.swift
//  recipify
//
//  Created by Timo Ischen on 16.10.24.
//

import SwiftUI

struct EditRecipeView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @Environment(\.presentationMode) var presentationMode
    var recipe: Recipe
    @State private var title: String
    @State private var description: String
    
    init (recipe: Recipe) {
        self.recipe = recipe
        _title = State(initialValue: recipe.title)
        _description = State(initialValue: recipe.description)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Rezept bearbeiten")) {
                    TextField("Title", text: $title)
                    
                    ZStack(alignment: .topLeading) {
                        if description.isEmpty {
                            Text("Beschreibung")
                                .foregroundColor(Color.secondary.opacity(0.5))
                                .padding(.top, 8)
                                .padding(.leading, 5)
                        }
                        TextEditor(text: $description)
                            .frame(minHeight: 100)
                            .opacity(description.isEmpty ? 0.85 : 1)
                    }
                }
            }
            .navigationBarTitle("Rezept bearbeiten", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Zurück") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Speichern") {
                    recipeViewModel.editRecipe(recipe: recipe, title: title, description: description)
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

#Preview {
    let sampleIngredients = [
        Ingredient(id: 9, name: "Salzstangen", unit: "Packung", amount: 1),
        Ingredient(id: 1, name: "Mett", unit: "Kilo", amount: 3)
    ]
    
    EditRecipeView(recipe: Recipe(
        id: 1,
        title: "Mett Igel",
        description: "Lecker lecker Mett",
        ingredients: sampleIngredients
    ))
    .environmentObject(RecipeViewModel())
}
