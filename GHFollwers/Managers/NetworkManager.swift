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
    let decoder                 =  JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    let baseURL = "https://api.github.com"
    
    private var baseGitHubURL: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        return urlComponents
    }
    
    
    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        guard let url = _gitHubURL(with: "/users/\(username)/followers", query: ["per_page": "100", "page": String(page)]) else { throw GFError.invalidURL }
        return try await _sendGHRequest(from: url, modelType: [Follower].self)
    }
    
    
    func getUser(for username: String) async throws -> User {
        guard let url = _gitHubURL(with: "/users/\(username)") else { throw GFError.invalidURL }
        return try await _sendGHRequest(from: url, modelType: User.self)
    }
    
}


extension NetworkManager {
    
    func _sendGHRequest<T: Codable>(from url: URL, modelType: T.Type) async throws -> T {
        let (data, response)  = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        do { return try decoder.decode(T.self, from: data) }
        catch { throw GFError.invalidData }
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
    func downloadImage(from urlString: String) async -> UIImage? {
        let casheKey = NSString(string: urlString)
        if let image = cashe.object(forKey: casheKey) { return image }
        guard let url = URL(string: urlString) else {return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            self.cashe.setObject(image, forKey: casheKey)
            return image
        } catch { return nil }
    }
}




