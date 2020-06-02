//
//  RecordsTableViewController.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 02.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class RecordsTableViewController: UITableViewController {

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.shared.records.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordIdentifier", for: indexPath)
        let record = Game.shared.records[indexPath.row]
        cell.textLabel?.text = "Выигрыш - \(record.earnedWinning)"
        cell.detailTextLabel?.text = "Правильных ответов - \(record.countRightAnswers)"
        return cell
    }

}
