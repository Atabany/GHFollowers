//
//  GFButton.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 20/02/2022.
//


import UIKit
class GFButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(color: UIColor, title: String, systemImageName: String? = nil ) {
        self.init(frame: .zero)
        set(color: color, title: title, systemImageName: systemImageName)
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        configuration = .tinted()
        configuration?.cornerStyle = .medium
    }
    
    
    func set(color: UIColor, title: String, systemImageName: String? = nil) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor  = color
        configuration?.title = title
        
        if let systemImageName = systemImageName {
            configuration?.image = UIImage.init(systemName: systemImageName)
            configuration?.imagePadding = 6
            configuration?.imagePlacement = .leading
        }
        
    }

    
}
