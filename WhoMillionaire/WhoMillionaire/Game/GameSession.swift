//
//  GameSession.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 12.05.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

class GameSession: Codable {
    
    var countRightAnswers: Int // количество правильных ответов
    var earnedWinning: Int // заработанный выигрыш
    
    init(countRightAnswers: Int, earnedWinning: Int) {
        self.countRightAnswers = countRightAnswers
        self.earnedWinning = earnedWinning
    }
}
