//
//  CharacterGender.swift
//  RickAndMorty
//
//  Created by Esra Alın on 5.04.2023.
//

import Foundation

enum CharacterGender: String, Codable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "unknown"
    
    var text: String {
        switch self {
        case .male, .female, .genderless, .unknown:
            return rawValue
        }
    }
}
