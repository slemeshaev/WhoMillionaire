//
//  GameSession.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 04.05.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

struct GameSession: Codable {
    let countRightAnswers: Int // количество правильных ответов
    let earnedWinning: Int // заработанный выигрыш
}
