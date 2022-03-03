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
}
