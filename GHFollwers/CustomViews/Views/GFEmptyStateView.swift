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
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        self.messageLabel.text = message
        
    }
    
    private func configure() {
        addSubviews(logoIV, messageLabel)
        configureLogoIV()
        configureMessageLabel()
    }
    
    
    
    private func configureLogoIV() {

        logoIV.translatesAutoresizingMaskIntoConstraints = false
        logoIV.image                                     =  Images.emptyStateLogo
        let logoIVBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8PlusZoomed ? 80 : 40
        NSLayoutConstraint.activate([
            logoIV.bottomAnchor.constraint(equalTo: bottomAnchor, constant: logoIVBottomConstant),
            logoIV.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoIV.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoIV.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
        ])
        
    }
    
    
    private func configureMessageLabel() {
        messageLabel.numberOfLines  =  3
        messageLabel.textColor      = .secondaryLabel
        
        let messagelabelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8PlusZoomed ? -80 : -150        
        
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: messagelabelCenterYConstant),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        
    }
    
}

