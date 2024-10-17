//
//  Ingredient.swift
//  recipify
//
//  Created by Timo Ischen on 17.10.24.
//

import Foundation

struct Ingredient: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let unit: String
    let amount: Int
}
