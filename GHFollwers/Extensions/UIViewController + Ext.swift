//
//  UIViewController + Ext.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 21/02/2022.
// 

import UIKit
import SafariServices


extension UIViewController {
    
    func presentGFAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentDefaultError() {
        let alertVC = GFAlertVC(title: GFError.somethingWentWrong.rawValue, message: GFError.requestNotCompleted.rawValue , buttonTitle: "Ok")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    
    
    func presentSafariVC(with url: URL) {
        let SFSafariViewController = SFSafariViewController(url: url)
        SFSafariViewController.preferredControlTintColor = .systemGreen
        present(SFSafariViewController, animated: true)
    }
    
    
    
    
    
    func showEmptyStateView( with message: String, in view: UIView ) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    
}



