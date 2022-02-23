//
//  SearchVC.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 19/02/2022.
//

import UIKit

class SearchVC: UIViewController {

    private let logoIV = UIImageView()
    private let usernameTF = GFTextField(placeholder: "Enter a username")
    private let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Search")
    
    private var isUsernameEntered: Bool { return !usernameTF.text!.isEmpty }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    private func configure() {
        configureScreen()
        createDismissKeyboardTapGesture()
    }
    
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc
    private func pushFollowerListVC() {
        guard isUsernameEntered else {
            print("No username");
            presentGFAlertOnMainThread(title: "Empty Username", message: "please enter your username we need to know who to look for 😀.", buttonTitle: "Ok")
            return
        }
        let followersVC = FollowersListVC()
        followersVC.username = usernameTF.text
        followersVC.title = usernameTF.text
        navigationController?.pushViewController(followersVC, animated: true)
    }
    
    private func configureScreen() {
        configureLogoIV()
        configureCallToActionButton()
        configureUsernameTF()
    }
    
    
    private func configureLogoIV() {
        view.addSubview(logoIV)
        logoIV.image = #imageLiteral(resourceName: "gh-logo")
        logoIV.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoIV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoIV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoIV.heightAnchor.constraint(equalToConstant: 200),
            logoIV.widthAnchor.constraint(equalToConstant: 200)
        ])
    }


    private func configureUsernameTF() {
        view.addSubview(usernameTF)
        usernameTF.delegate = self
        NSLayoutConstraint.activate([
            usernameTF.topAnchor.constraint(equalTo: logoIV.bottomAnchor, constant: 48),
            usernameTF.heightAnchor.constraint(equalToConstant: 50),
            usernameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }


    private func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
    
}
