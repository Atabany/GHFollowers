//
//  NetworkManager.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 24/02/2022.
//


import UIKit
class NetworkManager {
    static let shared = NetworkManager()
    let cashe = NSCache<NSString, UIImage>()
    private init() {}
    
    private let baseURL = "https://api.github.com"
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void ) {
        let endpoint = baseURL + "/users/" + username + "/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder                 =  JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers               =  try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
                return
            } catch {
                completed(.failure(.invalidData))
                return
            }
        }
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> ()  ) {
        let casheKey = NSString(string: urlString)
        if let image = cashe.object(forKey: casheKey) {
            completion(image)
            return
        }
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {return}
            if let _ = error { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
            guard let data = data, let image = UIImage(data: data) else {return}
            self.cashe.setObject(image, forKey: casheKey)
            DispatchQueue.main.async {
                completion(image)
                return
            }
        }
        task.resume()
    }
    
    
}


