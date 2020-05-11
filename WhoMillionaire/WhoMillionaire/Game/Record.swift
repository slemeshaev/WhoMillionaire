//
//  Record.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 11.05.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

struct Record: Codable {
    let countRightAnswers: Int // количество правильных ответов
    let earnedWinning: Int // заработанный выигрыш
}
