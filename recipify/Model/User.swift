//
//  User.swift
//  recipify
//
//  Created by Timo Ischen on 15.10.24.
//

import Foundation

struct User: Codable {
    let email: String
    let password: String
    let displayName: String
}
