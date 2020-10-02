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
        NotificationCenter.default.addObserver(self, selector: #selector(themeDidChange), name: Theme.notification, object: nil)
        
        //Other way if don't want to use DynamicType
//        self.infoListVM.actionHandler = {[weak self] action in
//            self?.actionHandler(action)
//        }
        
        self.infoListVM.infoList.bind {[weak self] _ in
            self?.tableView.reloadData()
        }
        
        // Just a hack to update font to other font for time being until a seperte user controlled config is developed
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            Theme.shared.changeTheme(to: .notoSans)
        }
    }
    
    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer, name: Theme.notification, object: nil)
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
    private var observer: Any?
}

extension InformationVC: ThemeApplicable {
    func themeDidChange() {
        if let indexs = tableView.indexPathsForVisibleRows {
            self.tableView.reloadRows(at: indexs, with: .automatic)
        }
    }
}
