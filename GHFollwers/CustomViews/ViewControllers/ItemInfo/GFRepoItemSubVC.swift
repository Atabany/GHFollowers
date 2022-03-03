//
//  GFRepoItemSubVC.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 01/03/2022.
//

import UIKit
protocol GFRepoItemSubVCelegate: AnyObject {
    func didTapGithubProfile(for user: User)
}

class GFRepoItemSubVC: GFItemInfoSuperVC {
    
    var delegate: GFRepoItemSubVCelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    
    private func configureItems() {
        itemViewOne.set(itemInfoType: .repos, withCount: user.publicRepos ?? 0)
        itemViewTwo.set(itemInfoType: .gists, withCount: user.publicGists ?? 0)
        actionButton.set(backgroudColor: .systemPurple, title: "Github Profile")
    }
    
    
    override func actionButtonDidTapped() {
        self.delegate.didTapGithubProfile(for: user)
    }    
}

