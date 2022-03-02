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
        // the old tabbar appearance
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            //            tabBarAppearance.backgroundColor = UIColor.tabBarBackground
            UITabBar.appearance().standardAppearance = tabBarAppearance
            
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
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
