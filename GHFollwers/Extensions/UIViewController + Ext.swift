//
//  UIViewController + Ext.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 21/02/2022.
//

import UIKit

extension UIViewController {
    
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String, padding: CGFloat? = nil) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle, padding: padding)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
}
