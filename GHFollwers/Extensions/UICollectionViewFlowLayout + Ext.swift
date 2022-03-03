//
//  UICollectionViewFlowLayout + Ext.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 03/03/2022.
//

import UIKit

extension UICollectionViewFlowLayout {
    
    func configureColoumnsFlowLayout(in view: UIView, with numberOfColumns: CGFloat)  {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minWidthSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2)  - ( minWidthSpacing * (numberOfColumns - 1))
        let itemWidth = availableWidth / numberOfColumns
        sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
    }

    
    
    
}
