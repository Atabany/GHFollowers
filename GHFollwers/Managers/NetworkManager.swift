//
//  NetworkManager.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 27/02/2022.
//

import UIKit
class NetworkManager {
    static let shared = NetworkManager()
    let cashe = NSCache<NSString, UIImage>()
    private init() {}
    
    let baseURL = "https://api.github.com"
    
    private var baseGitHubURL: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        return urlComponents
    }

    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void ) {
        guard let url = _gitHubURL(with: "/users/\(username)/followers", query: ["per_page": "100", "page": String(page)]) else {
            completed(.failure(.invalidURL))
            return
        }
        _sendGHRequest(from: url, modelType: [Follower].self) { result in completed(result); return }
    }
    
    
    func getUser(for username: String, completed: @escaping (Result<User, GFError>) -> Void ) {
        guard let url = _gitHubURL(with: "/users/\(username)") else { completed(.failure(.invalidURL)); return }
        _sendGHRequest(from: url, modelType: User.self) { result in completed(result); return }
    }
    
}


extension NetworkManager {
    
    func _sendGHRequest<T: Codable>(from url: URL, modelType: T.Type, completed: @escaping (Result<T, GFError>) -> Void ) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
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
                decoder.dateDecodingStrategy = .iso8601
                let model                   =  try decoder.decode(T.self, from: data)
                completed(.success(model))
                return
            } catch {
                completed(.failure(.invalidData))
                return
            }
        }
        task.resume()
    }
    
    
    private func _gitHubURL(with path: String, query: [String: String]? = nil) -> URL? {
        var urlComponents = baseGitHubURL
        urlComponents.path = path
        
        if let query = query {
            var queryItems = [URLQueryItem]()
            
            for (key, value) in query {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            
            urlComponents.queryItems = queryItems
        }
        
        return urlComponents.url
    }
    
}

//MARK: -  Image
extension NetworkManager {
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> ()  ) {
        let casheKey = NSString(string: urlString)
        if let image = cashe.object(forKey: casheKey) {
            completion(image)
            return
        }
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                      completion(nil)
                      return
                  }
            self.cashe.setObject(image, forKey: casheKey)
            completion(image)
        }
        task.resume()
    }
}

