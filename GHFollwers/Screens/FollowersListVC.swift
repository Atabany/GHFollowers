//
//  FollowersListVC.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 20/02/2022.
//

import UIKit

class FollowersListVC: UIViewController {
    
    enum Section: CaseIterable { case main }
    
    var username: String!
    var followers: [Follower] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    //MARK: - Pagination
    var page = 1
    var hasMoreFollowers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(page: page)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    private func configureViewController() {
        view.backgroundColor = UIColor.systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    
    private func configureCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.configureColoumnsFlowLayout(in: view, with: 3))
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    
    
    private func getFollowers(page: Int) {
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                self.followers += followers
                self.updateData()
                print(followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad stuff happend", message: error.rawValue, buttonTitle: "Ok")
                return
            }
        }
    }
    
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView)  { collectionView, indexPath, follower in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as? FollowerCell else {
                fatalError("Can't create Follower Cell")
            }
            cell.set(follower: follower)
            return cell
        }
    }
    
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers, toSection: .main)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
        
    }
    
    
}


extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        
        print("scrollViewDidEndDragging height: \(height)")
        print("scrollViewDidEndDragging contentHeight: \(contentHeight)")
        print("scrollViewDidEndDragging offsetY: \(offsetY)")
        
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else {return}
            page += 1
            getFollowers(page: page)
        }
    }
    
    
    
}
