//
//  UserInfoVC.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 27/02/2022.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: UIViewController, Loadable {
    var containerView: UIView!
    
    //MARK: - Variable - Components
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    
    
    var userName: String!
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    weak var delegate: UserInfoVCDelegate!
    
    //    var containerView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.systemBackground
    }
    
    
    func configure() {
        configureVC()
        configureScrollView()
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
    
    
    private func configureScrollView() {
        view.addSubviews(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: self.view)
        contentView.pinToEdges(of: scrollView)
        contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        let heightAnchor = contentView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor)
        heightAnchor.isActive = true
        heightAnchor.priority = UILayoutPriority(rawValue: 250)
    }
    
    
    
    func getUserData() {
        Task {
            do {
                showLoadingView()
                let user = try await NetworkManager.shared.getUser(for: userName)
                dismissLoadingView()
                configureUIElements(with: user)
            } catch {
                if let gfError = error as? GFError {
                    presentGFAlert(title: GFError.somethingWentWrong.rawValue, message: gfError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
                dismissLoadingView()
            }
        }
    
    }
    
    
    func configureUIElements(with user: User) {
        add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        add(childVC: GFRepoItemSubVC(user: user, delegate: self), to: self.itemViewOne)
        add(childVC: GFFollowerItemSubVC(user: user, delegate: self), to: self.itemViewTwo)
        dateLabel.text = "On Github since" + " " + (user.createdAt?.convertToMonthYearString() ?? "")
        
    }
    
    
    func layoutUI () {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        contentView.addSubviews(headerView,
                                itemViewOne,
                                itemViewTwo,
                                dateLabel)
        
        [headerView,
         itemViewOne,
         itemViewTwo,
         dateLabel]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                    $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
                ])
            }
        
        
        let x = dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        x.isActive = true
        x.priority = UILayoutPriority(rawValue: 750)
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            
            dateLabel.topAnchor.constraint(greaterThanOrEqualTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
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
extension UserInfoVC: GFFollowerItemSubVCDelegate, GFRepoItemSubVCelegate {
    
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl ?? "") else {
            presentGFAlert(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
    
    
    func didTapGetFollowers(for user: User) {
        guard (user.followers ?? 0) > 0 else {
            presentGFAlert(title: "OH Sorry", message: "This user has no followers", buttonTitle: "OK")
            return
        }
        delegate.didRequestFollowers(for: user.login ?? "")
        dismissVC()
    }
}

