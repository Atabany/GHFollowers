//
//  ErrorMessage.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 25/02/2022.
//

import Foundation
enum GFError: String, Error {
    
   
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   =  "unable to complete your request. please check your internet connection"
    case invalidResponse    = "Invalid Response from the server please try again."
    case invalidData        = "The data received from the server is invalid, please try again."

       
    
}
