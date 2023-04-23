//
//  LocationCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Esra Alın on 10.04.2023.
//
import Foundation

final class LocationCollectionViewCellViewModel: Hashable, Equatable {
    public let locationName: String


    init(
        locationName: String
    ) {
        self.locationName = locationName
    }

   
    static func == (lhs: LocationCollectionViewCellViewModel, rhs: LocationCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(locationName)
    }
}
