//
//  GFAvatarImageView.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 25/02/2022.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cashe = NetworkManager.shared.cashe
    
    let placeholderImage    = Images.avatarPlaceHolder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius                          = 10
        clipsToBounds                               = true
        image                                       = placeholderImage
        translatesAutoresizingMaskIntoConstraints   = false
        
    }
    
    
    func setImage(from urlString: String) {
        Task { image =  await NetworkManager.shared.downloadImage(from: urlString) ?? Images.avatarPlaceHolder }
    }
    
    
}
