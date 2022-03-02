//
//  GFGFItemInfoSuperVC.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 01/03/2022.
//

import UIKit

class GFItemInfoSuperVC: UIViewController {
    
    //MARK: - Variables - Components
    let itemViewOne                      = GFItemInfoView()
    let itemViewTwo                      = GFItemInfoView()
    let actionButton                     = GFButton()
    private let infoItemsStackView       = UIStackView()
    
    
    var user: User!
    weak var delegate: UserInfoVCDelegate!
    
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActionButton()
        configureBackgroundView()
        layoutUI()
        configureStackView()
    }
    
    
    func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonDidTapped), for: .touchUpInside)
    }
    
    
    @objc
    func actionButtonDidTapped() {}
    
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    
    private func configureStackView() {
        infoItemsStackView.axis          = .horizontal
        infoItemsStackView.distribution  = .equalSpacing
        infoItemsStackView.addArrangedSubview(itemViewOne)
        infoItemsStackView.addArrangedSubview(itemViewTwo)
    }
    
    private func layoutUI() {
        [actionButton, infoItemsStackView].forEach { view.addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false }
        
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            infoItemsStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            infoItemsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            infoItemsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            infoItemsStackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
    }
    
    
    
    
}
