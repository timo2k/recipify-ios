//
//  CreateRecipeView.swift
//  recipify
//
//  Created by Timo Ischen on 16.10.24.
//

import SwiftUI

struct CreateRecipeView: View {
    @EnvironmentObject var recipeViewModel: RecipeViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Rezept Informationen")) {
                    TextField("Titel", text: $title)
                    
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
            .navigationBarTitle("Neues Rezept", displayMode: .inline)
            .navigationBarItems(leading: Button("Zurück") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Speichern") {
                recipeViewModel.createRecipe(title: title, description: description)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    CreateRecipeView()
        .environmentObject(AuthenticationViewModel())
}
