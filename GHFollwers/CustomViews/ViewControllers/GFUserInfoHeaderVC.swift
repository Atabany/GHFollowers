//
//  GFUserInfoHeaderVC.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 27/02/2022.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    
    //MARK: - Variables - Components
    private let avatarImageView     = GFAvatarImageView(frame: .zero)
    private let usernameLabel       = GFTitleLabel(textAlignment: .left, fontSize: 34)
    private let nameLabel           = GFSecondaryTitleLabel(fontSize: 18)
    private let locationImageView   = UIImageView()
    private let locationLabel       = GFSecondaryTitleLabel(fontSize: 18)
    private let bioLabel            = GFBodyLabel(textAlignment: .left)

    
    
    private let headerView = UIView()
    
    
    var user: User!
    
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        configureUIElements()
        self.view.backgroundColor = UIColor.systemBackground
    }
    
    
    private func configure() {
        addSubViews()
        layoutUI()
    }
    
    
    func configureUIElements() {
        guard let user = self.user else {return}
        avatarImageView.setImage(from: user.avatarUrl ?? "")
        usernameLabel.text      = user.login
        nameLabel.text          = user.name ?? user.login
        locationLabel.text      = user.location ?? "No location Available"
        bioLabel.text           = user.bio ?? "No Bio Available"
        bioLabel.lineBreakMode  = .byTruncatingTail
        bioLabel.numberOfLines  = 0
        locationImageView.image = SFSymbols.location
        locationImageView.tintColor = .secondaryLabel

    }
    
    
    private func addSubViews() {
        view.addSubviews(avatarImageView,
                         usernameLabel,
                         nameLabel,
                         locationImageView,
                         locationLabel,
                         bioLabel)
    }
    
    private func layoutUI() {
        
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // AvatarImageView
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),

            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo:avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)
//            bioLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            
            

        ])
        
        
    }
    
    
    
}

