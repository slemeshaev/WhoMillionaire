//
//  ViewModel.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 15.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

class ViewModel: TableViewViewModelType {

    func getNumberOfRows() -> Int {
        return Game.shared.records.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let record = Game.shared.records[indexPath.row]
        return TableViewCellViewModel(record: record)
    }
    
}
