//
//  RecordsTableViewController.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 02.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class RecordsTableViewController: UITableViewController {
    
    var viewModel: TableViewViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRows() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordIdentifier", for: indexPath) as? RecordTableViewCell
        
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
        tableViewCell.viewModel = cellViewModel
        
//        let record = Game.shared.records[indexPath.row]
//        cell.textLabel?.text = "Выигрыш - \(record.earnedWinning)"
//        cell.detailTextLabel?.text = "Правильных ответов - \(record.countRightAnswers)"
        return tableViewCell
    }

}
