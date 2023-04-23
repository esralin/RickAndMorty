//
//  GetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Esra Alın on 6.04.2023.
//

import Foundation

struct GetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: Info
    let results: [Character]
}
