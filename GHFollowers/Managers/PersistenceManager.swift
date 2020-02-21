//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by jason on 2/20/20.
//  Copyright © 2020 jason. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}



enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard

    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                
                // action type will be determined by the user
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                case .remove:
                    // when you find a case where the favorite matches the login, remove it
                    favorites.removeAll { $0.login == favorite.login }
                }
                
                // note: saves the new array with the appended results
                completed(save(favorites: favorites))
                
            case .failure(let error):
                completed(error)
            }
        }
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
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
