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
    private let callToActionButton = GFButton(color: .systemGreen, title: "Get Followers", systemImageName: "person.3")
    
    private var isUsernameEntered: Bool { return !usernameTF.text!.isEmpty }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        view.addSubviews(logoIV, usernameTF, callToActionButton)
        configure()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        usernameTF.text = ""
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
            presentGFAlert(title: "Empty Username", message: "please enter your username we need to know who to look for 😀.", buttonTitle: "Ok")
            return
        }
        usernameTF.resignFirstResponder()
        let followersVC = FollowersListVC(username: usernameTF.text!)
        navigationController?.pushViewController(followersVC, animated: true)
    }
    
    
    private func configureScreen() {
        configureLogoIV()
        configureCallToActionButton()
        configureUsernameTF()
    }
    
    
    var topImageContstraint: NSLayoutConstraint!
    private func configureLogoIV() {
        
        logoIV.image =  Images.ghLogo
        logoIV.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8PlusZoomed ? 20 : 80
        topImageContstraint = logoIV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -500)
        topImageContstraint.isActive = true

        logoIV.frame = CGRect(x: 0, y: -100, width: 200, height: 200)
        UIView.animate(withDuration: 1) {
            
        }
        NSLayoutConstraint.activate([
            logoIV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoIV.heightAnchor.constraint(equalToConstant: 200),
            logoIV.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.topImageContstraint.constant = topConstraintConstant
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
        }
    }


    private func configureUsernameTF() {
        usernameTF.delegate = self
        NSLayoutConstraint.activate([
            usernameTF.topAnchor.constraint(equalTo: logoIV.bottomAnchor, constant: 48),
            usernameTF.heightAnchor.constraint(equalToConstant: 50),
            usernameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }


    private func configureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        let bottomButtonConstraint =  callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 500)
        bottomButtonConstraint.isActive = true
        NSLayoutConstraint.activate([
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            bottomButtonConstraint.constant = -50
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
        }

    }
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
    
}
