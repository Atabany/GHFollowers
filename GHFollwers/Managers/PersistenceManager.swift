//
//  PersistenceManager.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 02/03/2022.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}



enum PersistenceManager {
    static private let  defaults = UserDefaults.standard
    
    enum keys {
        static let favorites = "favorites"
    }
    
    
    
    static func removeAll() {
        defaults.removeObject(forKey: "favorites")
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?)->()) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {completed(.alreadyInFavorites); return}
                    retrievedFavorites.append(favorite)
                    break
                case .remove:
                    retrievedFavorites.removeAll {$0.login == favorite.login }
                    break
                }
                completed(save(favorites: retrievedFavorites))
            case .failure(let error):
                completed(error)
                break
            }
        }
    }
    
    
    static  func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> ()) {
        guard let favoritesData = defaults.object(forKey: keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder                     =  JSONDecoder()
            let favFollowers                =  try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favFollowers))
            return
        } catch {
            completed(.failure(.unableToFavorite))
            return
        }
    }
    
    
    static private func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder         = JSONEncoder()
            let data            =  try encoder.encode(favorites)
            defaults.set(data, forKey: keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
    
}

