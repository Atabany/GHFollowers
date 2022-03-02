//
//  GError.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 27/02/2022.
//

import Foundation

enum GFError: String, Error {
   
    case badStuffHappend    = "Bad Stuff Happened"
    case invalidUsername    = "This username created an invalid request. Please try again."
    case invalidURL         = "This url  is  invalid . Please try again."
    case unableToComplete   =  "unable to complete your request. please check your internet connection"
    case invalidResponse    = "Invalid Response from the server please try again."
    case invalidData        = "The data received from the server is invalid, please try again."
    case unableToFavorite   = "Unable to favoriting the follower"
    case alreadyInFavorites = "You've already favorited this user. you must REALY like them!"

}
