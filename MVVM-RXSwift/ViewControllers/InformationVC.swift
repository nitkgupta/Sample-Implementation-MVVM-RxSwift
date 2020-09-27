//
//  InformationVC.swift
//  MVVM-RXSwift
//
//  Created by Nitkarsh Gupta on 27/09/20.
//

import UIKit
import RxSwift

class InformationVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(InfoCell.nib, forCellReuseIdentifier: InfoCell.identifier)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = .darkGray
        self.infoListVM.actionHandler = {[weak self] action in
            self?.actionHandler(action)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.infoListVM.numberOfItems()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier) as? InfoCell else {
            print("Unable to find the cell")
            return UITableViewCell()
        }
        let info = infoListVM.info(at: indexPath.row)
        cell.configureCell(info)
        return cell
    }
    
    private func actionHandler(_ actions: Actions) {
        switch actions {
        case .reloadTable:
            self.tableView.reloadData()
        }
    }
    
    private let infoListVM = InfoListVM()
}
