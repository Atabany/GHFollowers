//
//  GFTabBarController.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 02/03/2022.
//

import UIKit

class GFTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        viewControllers = [createSearchNC(), createFavoritesNC()]
    }
    
    
    func configureAppearance() {
        UITabBar.appearance().tintColor = UIColor.systemGreen
    }
    
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let searchNC = UINavigationController(rootViewController: searchVC)
        return searchNC
    }
    
    
    func createFavoritesNC() -> UINavigationController {
        let favoriteVC = FavoriteListVC()
        favoriteVC.title = "Favorites"
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let favoriteNC = UINavigationController(rootViewController: favoriteVC)
        
        return favoriteNC
    }
    
    
}
