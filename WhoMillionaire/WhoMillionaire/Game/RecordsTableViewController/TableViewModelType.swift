//
//  TableViewModelType.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 15.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

protocol TableViewViewModelType {
    func getNumberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?
}