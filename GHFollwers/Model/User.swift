//
//  User.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 23/02/2022.
//
    
import Foundation
struct User: Codable {
    let login: String?
    let avatarUrl: String?
    let name: String?
    let location: String?
    let bio: String?
    let publicRepos: Int?
    let publicGists: Int?
    let htmlUrl: String?
    let followers: Int?
    let following: Int?
    let createdAt: String?
}

