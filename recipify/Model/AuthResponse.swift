//
//  AuthResponse.swift
//  recipify
//
//  Created by Timo Ischen on 15.10.24.
//

import Foundation

struct AuthResponse: Codable {
    let token: String
    let type: String
}
