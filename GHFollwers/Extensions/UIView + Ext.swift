//
//  UIView + Ext.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 04/03/2022.
//

import UIKit

extension UIView {
    func addSubviews(_ subivews: UIView...) {
        subivews.forEach {addSubview($0)}
    }
    
    
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
        ])
    }
}
