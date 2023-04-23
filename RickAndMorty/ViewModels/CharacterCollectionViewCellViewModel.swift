//
//  CharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Esra Alın on 7.04.2023.
//

import Foundation
import Foundation

final class CharacterCollectionViewCellViewModel: Hashable, Equatable {
    public let characterName: String
    private let characterGender: CharacterGender
    private let characterImageUrl: URL?


    init(
        characterName: String,
        characterGender: CharacterGender,
        characterImageUrl: URL?
    ) {
        self.characterName = characterName
        self.characterGender = characterGender
        self.characterImageUrl = characterImageUrl
    }

    public var characterGenderText: String {
        return "Gender: \(characterGender.text)"
    }
    
    public var getCharacterGender: CharacterGender{
        return characterGender
    }

    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }


    static func == (lhs: CharacterCollectionViewCellViewModel, rhs: CharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterGender)
        hasher.combine(characterImageUrl)
    }
}
