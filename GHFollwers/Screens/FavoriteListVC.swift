//
//  FavouriteListVC.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 19/02/2022.
//

import UIKit

class FavoriteListVC: UIViewController {

    
    private let callToActionButton = GFButton(backgroundColor: .systemPink, title: "Search")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        configureCallToActionButton()
    }
    
    
    private func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        NSLayoutConstraint.activate([
            
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
}
