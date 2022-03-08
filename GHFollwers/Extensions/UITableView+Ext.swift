//
//  UITableView+Ext.swift
//  GHFollwers
//
//  Created by Mohamed Elatabany on 04/03/2022.
//

import UIKit

extension UITableView {
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {self.reloadData()}
    }

    
    func remeveExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
