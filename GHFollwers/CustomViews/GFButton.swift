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
        // custom code
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }


    private func configure() {
        layer.cornerRadius      = 10

        titleLabel?.textColor  = UIColor.white
        titleLabel?.font       = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }

    
    
    
}
