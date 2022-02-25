//
//  Follower.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 23/02/2022.
//

import Foundation
struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
}





