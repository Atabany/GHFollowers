//
//  GFBodyLabel.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 21/02/2022.
//

import UIKit

class GFBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    
    private func configure() {
        font = UIFont.preferredFont(forTextStyle: .body)
        numberOfLines = 0
        textColor                           = .secondaryLabel
        adjustsFontSizeToFitWidth           = true
        adjustsFontForContentSizeCategory   = true
        minimumScaleFactor                  = 0.75
        lineBreakMode                       = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
