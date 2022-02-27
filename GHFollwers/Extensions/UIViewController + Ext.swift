//
//  UIViewController + Ext.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 21/02/2022.
//

import UIKit
fileprivate var containerView: UIView!
extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String, padding: CGFloat? = nil) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle, padding: padding)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        UIView.animate(withDuration: 1) {
            containerView.alpha = 0.8
        }
        let spinner = UIActivityIndicatorView(style: .large)
        containerView.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        spinner.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1) {
                containerView.alpha = 0.8
            } completion: { _ in
                containerView.removeFromSuperview()
                containerView = nil
            }
        }
    }
    
    
    
    func showEmptyStateView( with message: String, in view: UIView ) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    
}



