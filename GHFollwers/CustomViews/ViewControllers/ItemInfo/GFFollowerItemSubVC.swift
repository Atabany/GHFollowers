//
//  GFFollowerItemSubVC.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 01/03/2022.
//

import UIKit
protocol GFFollowerItemSubVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemSubVC: GFItemInfoSuperVC {
    
    
    var delegate: GFFollowerItemSubVCDelegate!
    
    init(user: User, delegate: GFFollowerItemSubVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - Variables - components
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemViewOne.set(itemInfoType: .following, withCount: user.following ?? 0)
        itemViewTwo.set(itemInfoType: .followers, withCount: user.followers ?? 0)
        actionButton.set(backgroudColor: UIColor.systemGreen, title: "Get Followers")
    }
    
    
    override func actionButtonDidTapped() {        
        delegate.didTapGetFollowers(for: self.user)
    }
}
