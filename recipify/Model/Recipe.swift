//
//  Recipe.swift
//  recipify
//
//  Created by Timo Ischen on 15.10.24.
//

import Foundation

struct Recipe: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let description: String
    let ingredients: [Ingredient]
}
