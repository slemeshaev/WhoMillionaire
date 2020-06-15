//
//  TableViewCellViewModelType.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 15.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

protocol TableViewCellViewModelType: class {
    var earnedWinning: String { get }
    var countRightAnswers: String { get }
}
