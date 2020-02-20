//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by jason on 2/20/20.
//  Copyright © 2020 jason. All rights reserved.
//

import Foundation

enum PersistenceManager {
    static private let defaults = UserDefaults.standard

    enum Keys {
        static let favorites = "favorites"
    }
    // any time you're saving a custom object, you have to encode and decode it. it gets saved as data
    // if it's a default type, then user defaults can hold it no problem
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            // if no data found, then need to init w/ empty array
            completed(.success([]))
            return
        }
        
        // need do/try catch for custom object
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
}
