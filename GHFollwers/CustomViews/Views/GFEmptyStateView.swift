//
//  GFEmptyStateView.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 27/02/2022.
//

import UIKit

class GFEmptyStateView: UIView {
    
    //MARK: - Variables
    private var messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    private var logoIV = UIImageView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(message: String) {
        super.init(frame: .zero)
        self.messageLabel.text = message
        configure()
    }
    
    
    private func configure() {
        
        addSubview(messageLabel)
        addSubview(logoIV)
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        logoIV.image =  Images.emptyStateLogo
        logoIV.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            logoIV.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoIV.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoIV.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            logoIV.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40)
        ])

    }
    
    
    
}

