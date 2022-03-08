//
//  FavouriteListVC.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 19/02/2022.
//

import UIKit

class FavoriteListVC: UIViewController {

    private let callToActionButton = GFButton(backgroundColor: .systemPink, title: "Search")
    let tableView = UITableView()
    var favorites: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavorites()
    }
    
    
    private func configureVC() {
        view.backgroundColor = UIColor.systemBackground
        tableView.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = self.view.bounds
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    
    private func fetchFavorites() {
        
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let favorites):
                self.favorites = favorites
                if favorites.isEmpty { self.updateEmptyState() }
                else {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentGFAlertOnMainThread(title: GFError.somethingWentWrong.rawValue, message: error.rawValue, buttonTitle: "Ok")
                }
                break
            }
        }
    }
    
    
    private func updateEmptyState() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.showEmptyStateView(with: "No Favorites?\n Add one on the followers screen.", in: self.view)
        }
    }
        
}


extension FavoriteListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId, for: indexPath) as? FavoriteCell else {
            return UITableViewCell()
        }
        guard indexPath.row < self.favorites.count else {return UITableViewCell()}
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
}

extension FavoriteListVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = favorites[indexPath.row]
        let vc = UserInfoVC()
        vc.userName = user.login
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else {return}
            if let error = error {
                self.presentGFAlertOnMainThread(title: GFError.somethingWentWrong.rawValue, message: error.rawValue , buttonTitle: "Ok")
                return
            }
            self.favorites.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            if self.favorites.isEmpty {
                self.updateEmptyState()
            }
        }
    }
}


extension FavoriteListVC: UserInfoVCDelegate {
    func didRequestFollowers(for username: String) {
        let vc = FollowersListVC(username: username)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
