//
//  FollowerTableViewCell.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 02/03/2022.
//

import UIKit

class FavoriteCell: UITableViewCell {

    
    static let reuseId = "FollowerTableViewCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func set(favorite: Follower) {
        avatarImageView.image = nil
        avatarImageView.image = Images.ghLogo
        usernameLabel.text = favorite.login
        avatarImageView.setImage(from: favorite.avatarUrl)
        avatarImageView.contentMode = .scaleAspectFit
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        avatarImageView.image = Images.ghLogo
    }
    
    private func configure() {
        addSubviews(avatarImageView, usernameLabel)
        accessoryType = .disclosureIndicator
        selectionStyle = .none
            
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            
            usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40),
        
        ])
        
        
    }
}
