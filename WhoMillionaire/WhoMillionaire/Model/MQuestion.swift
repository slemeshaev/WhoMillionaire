//
//  MQuestion.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 13.04.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

// структура вопрос
struct MQuestion: Codable {
    
    var question: String?
    var rightAnswer: String?
    var incorrectAnswers: [String]?

}
