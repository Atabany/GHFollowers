//
//  DataLoadingVC.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 03/03/2022.
//

import UIKit


protocol Loadable: AnyObject {
    var containerView: UIView! { get set }
    func showLoadingView()
    func dismissLoadingView()
    func showEmptyStateView(with message: String, in view: UIView)
}


extension Loadable where Self: UIViewController {
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        UIView.animate(withDuration: 1) {
            self.containerView.alpha = 0.8
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
                self.containerView.alpha = 0.8
            } completion: { _ in
                self.containerView.removeFromSuperview()
                self.containerView = nil
            }
        }
    }

    
}
