//
//  RecordsTableViewController.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 04.05.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class RecordsTableViewController: UITableViewController {
    
    var records = [Record]() // массив рекордов
    
    override func viewDidLoad() {
        super.viewDidLoad()
        records.append(Record(countRightAnswers: 8, earnedWinning: 90))
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.shared.records.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordIdentifier", for: indexPath)
        let record = Game.shared.records[indexPath.row]
        cell.textLabel?.text = "\(record.countRightAnswers)"
        cell.detailTextLabel?.text = "\(record.earnedWinning)"
        return cell
    }

}
