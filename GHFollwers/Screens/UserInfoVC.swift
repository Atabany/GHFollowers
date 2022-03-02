//
//  UserInfoVC.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 27/02/2022.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    //MARK: - Variable - Components
    var userName: String!
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    weak var delegate: FollwersListViewControllerDelegate!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    
    func configure() {
        configureVC()
        layoutUI()
        getUserData()
    }
    
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        configureNavBar()
    }
    
    func configureNavBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    @objc
    func dismissVC() {
        dismiss(animated: true)
    }
    
    
    func getUserData() {
        showLoadingView()
        NetworkManager.shared.getUser(for: userName) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.dismissLoadingView()
            }
            switch result {
            case .success(let user ):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            }
        }
    }
    
    
    func configureUIElements(with user: User) {
        add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        
        
        let reposItemVC = GFRepoItemSubVC(user: user)
        reposItemVC.delegate = self
        add(childVC: reposItemVC, to: self.itemViewOne)

        
        let followersItemVC = GFFollowerItemSubVC(user: user)
        followersItemVC.delegate = self
        add(childVC: followersItemVC, to: self.itemViewTwo)
        
        
        dateLabel.text = "On Github since" + " " + (user.createdAt?.convertToDisplayFormat() ?? "")
    }
    

    func layoutUI () {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        [headerView,
         itemViewOne,
         itemViewTwo,
         dateLabel]
            .forEach {
                view.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                    $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
                ])
            }
        
        
        NSLayoutConstraint.activate([
            
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)

            
        ])
    }
    
    
}


//MARK: -  ADD ChildView controller
extension UserInfoVC {
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}


//MARK: -  Delegate
extension UserInfoVC: UserInfoVCDelegate {
    
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl ?? "") else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
    
    
    func didTapGetFollowers(for user: User) {
        guard (user.followers ?? 0) > 0 else {
            presentGFAlertOnMainThread(title: "OH Sorry", message: "This user has no followers", buttonTitle: "OK")
            return
        }
        delegate.didRequestFollowers(for: user.login ?? "")
        dismissVC()
    }
}

