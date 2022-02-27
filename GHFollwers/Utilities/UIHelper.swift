//
//  UIHelper.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 25/02/2022.
//

import UIKit

class UIHelper {
    static func configureColoumnsFlowLayout(in view: UIView, with numberOfColumns: CGFloat) -> UICollectionViewLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minWidthSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2)  - ( minWidthSpacing * (numberOfColumns - 1))
        let itemWidth = availableWidth / numberOfColumns
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
    
    
    
    
    

}
