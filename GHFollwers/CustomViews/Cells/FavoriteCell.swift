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
    
    
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.setImage(from: follower.avatarUrl)
        avatarImageView.contentMode = .scaleAspectFit
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }
    
    private func configure() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
            
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
//            usernameLabel.heightAnchor.constraint(equalToConstant: 20),
            usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        
        ])
        
        
    }
}