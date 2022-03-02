//
//  FollowersListVC.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 20/02/2022.
//

import UIKit
protocol FollwersListViewControllerDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}


class FollowersListVC: UIViewController {
    
    //MARK: - Vars
    enum Section: CaseIterable { case main }
    
    var username: String!
    var followers: [Follower] = []
    //    var filteredFollowers: [Follower] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    var  searchController: UISearchController!
    
    
    
    
    //MARK: - Pagination
    var page = 1
    var hasMoreFollowers = true
    
    
    
    

    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        title = username
        self.username = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(page: page)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - Configure
    private func configureViewController() {
        view.backgroundColor = UIColor.systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = username
        configureNavBar()
    }
    
    func configureNavBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    func configureSearchController() {
        searchController                                   = UISearchController()
        searchController.searchResultsUpdater                  = self
        searchController.searchBar.delegate                    = self
        searchController.searchBar.placeholder                 = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation  = false
        navigationItem.searchController                        = searchController
        navigationItem.hidesSearchBarWhenScrolling             = false
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.configureColoumnsFlowLayout(in: view, with: 3))
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    
    @objc
    private func addButtonTapped() {
        showLoadingView()
        NetworkManager.shared.getUser(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                let follower = Follower(login: user.login ?? "", avatarUrl: user.avatarUrl ?? "")
                PersistenceManager.updateWith(favorite: follower, actionType: .add) { [weak self] error in
                    guard let self = self else {return}
                    guard  error == nil else {
                        self.presentGFAlertOnMainThread(title: GFError.badStuffHappend.rawValue, message: error?.rawValue ?? "", buttonTitle: "Ok")
                        return
                    }
                    self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully added the user to the favorites 🎉", buttonTitle: "Hooray!")
                    return
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentGFAlertOnMainThread(title: GFError.badStuffHappend.rawValue, message:error.rawValue, buttonTitle: "OK")
                }
            }
        }
    }
    
    
    
    //MARK: - Get Data
    private func getFollowers(page: Int) {
        self.showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.dismissLoadingView()
            }
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    let message = "This User doesn't have any followers 😞"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                        self.navigationItem.searchController?.searchBar.isHidden = true
                    }
                    return
                }
                self.updateData(on: self.followers)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentGFAlertOnMainThread(title: GFError.badStuffHappend.rawValue, message: error.rawValue, buttonTitle: "Ok")
//                    self.showEmptyStateView(with: error.rawValue, in: self.view)
                    self.navigationItem.searchController?.searchBar.isHidden = true
                }
                return
            }
        }
    }
    
    
    //MARK: - Diffable Data Source - Cell
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView)  { collectionView, indexPath, follower in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as? FollowerCell else {
                fatalError("Can't create Follower Cell")
            }
            cell.set(follower: follower)
            return cell
        }
    }
    
    
    private func updateData(on followers: [Follower]) {
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
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else {return}
            page += 1
            getFollowers(page: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let follower = dataSource.itemIdentifier(for: indexPath) else {return}
        let destinationVC = UserInfoVC()
        destinationVC.delegate = self
        destinationVC.userName = follower.login
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
        
    }
    
}


extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !(filter.isEmpty) else { return }
        let filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: self.followers)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        updateData(on: self.followers)
    }
}


extension FollowersListVC: FollwersListViewControllerDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        hasMoreFollowers = true
        updateData(on: followers)
        getFollowers(page: page)
        searchController.isActive = false
    }
}
