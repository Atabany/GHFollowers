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
    
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    
    private func configure() {
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints   = false
        layer.cornerRadius                          = 10
        titleLabel?.font                            = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    
    func set(backgroudColor: UIColor, title: String) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroudColor
    }

    
}
