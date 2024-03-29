//
//  FollowersListVC.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 20/02/2022.
//

import UIKit


class FollowersListVC: UIViewController, Loadable {
    
    var containerView: UIView!
    
    
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
    var isLoading = false
    
    
    
    

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
        searchController.searchBar.placeholder                 = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation  = false
        navigationItem.searchController                        = searchController
        navigationItem.hidesSearchBarWhenScrolling             = false
    }
    
    
    private func configureCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.configureColoumnsFlowLayout(in: self.view, with: 3)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    
    fileprivate func addUserToFavorite(_ user: (User), _ self: FollowersListVC) {
        let follower = Follower(login: user.login ?? "", avatarUrl: user.avatarUrl ?? "")
        PersistenceManager.updateWith(favorite: follower, actionType: .add) { [weak self] error in
            guard let self = self else {return}
            guard  error == nil else {
                DispatchQueue.main.async {
                    self.presentGFAlert(title: GFError.somethingWentWrong.rawValue, message: error?.rawValue ?? "", buttonTitle: "Ok")
                }
                return
            }
            DispatchQueue.main.async {
                self.presentGFAlert(title: "Success!", message: "You have successfully added the user to the favorites 🎉", buttonTitle: "Hooray!")
            }
            return
        }
    }
    
    @objc
    private func addButtonTapped() {
        showLoadingView()
        Task {
            do {
                let user = try await NetworkManager.shared.getUser(for: username)
                addUserToFavorite(user, self)
                dismissLoadingView() 
            } catch {
                if let gfError = error as? GFError {
                    presentGFAlert(title: GFError.somethingWentWrong.rawValue, message:gfError.rawValue, buttonTitle: "OK")
                } else {
                    presentDefaultError()
                }
                dismissLoadingView()
            }
        }
    }
    
    
    
    //MARK: - Get Data
    fileprivate func updateUIwith(followers: ([Follower])) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        if self.followers.isEmpty {
            let message = "This User doesn't have any followers 😞"
            self.showEmptyStateView(with: message, in: self.view)
            self.navigationItem.searchController?.searchBar.isHidden = true
            return
        }
        self.updateData(on: self.followers)
    }
    
    private func getFollowers(page: Int)  {
        guard !isLoading else {return}
        isLoading = true
        showLoadingView()
        Task {
            do {
                let followers = try await NetworkManager.shared.getFollowers(for: username, page: page)
                updateUIwith(followers: followers)
                dismissLoadingView()
                isLoading = false
            } catch {
                dismissLoadingView()
                isLoading = false
                if let  error = error as? GFError {
                    presentGFAlert(title: GFError.somethingWentWrong.rawValue, message: error.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
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
            guard hasMoreFollowers, !isLoading else {return}
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


extension FollowersListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !(filter.isEmpty) else {
            updateData(on: self.followers)
            return
        }
        let filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
}


extension FollowersListVC: UserInfoVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        hasMoreFollowers = true
        updateData(on: followers)
        getFollowers(page: page)
//        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        searchController.isActive = false
    }
}
