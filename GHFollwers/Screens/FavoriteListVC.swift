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
    var favorties: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavorites()
    }
    
    
    private func configureVC() {
        self.view.backgroundColor = UIColor.systemBackground
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
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                self.favorties = favorites
                self.tableView.reloadData()
            case .failure(let error):
                break
            }
        }
    }
    
    

    
    
    
    
}


extension FavoriteListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorties.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId, for: indexPath) as? FavoriteCell else {
            return UITableViewCell()
        }
        guard indexPath.row < self.favorties.count else {return UITableViewCell()}
        let follower = favorties[indexPath.row]
        cell.set(follower: follower)
        return cell
    }
}

extension FavoriteListVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = favorties[indexPath.row]
        let vc = UserInfoVC()
        vc.userName = user.login
        vc.delegate = self
        present(vc, animated: true)
    }
}


extension FavoriteListVC: FollwersListViewControllerDelegate {
    func didRequestFollowers(for username: String) {
        let vc = FollowersListVC()
        vc.username = username
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
