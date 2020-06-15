//
//  TableViewCellViewModel.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 15.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

class TableViewCellViewModel: TableViewCellViewModelType {
    
    private var record: GameSession
    
    var earnedWinning: String {
        if let win = Game.shared.gameSession?.earnedWinning {
            return String(win)
        }
        return ""
    }
    
    var countRightAnswers: String {
        if let count = Game.shared.gameSession?.countRightAnswers {
            return String(count)
        }
        return ""
    }
    
    init(record: GameSession) {
        self.record = record
    }
}
