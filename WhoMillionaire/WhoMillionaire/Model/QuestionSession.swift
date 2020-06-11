//
//  QuestionSession.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 10.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

class QuestionSession {
    
    var numberQuestion = 0 // номер вопроса
    var isCurrentQuestion = true // текущий вопрос
    var isAnswerLastQuestion = false // ответ на последний вопрос
    
    // стоимость вопросов
    static let issuePrice: [Int] = [500, 1_000, 2_000, 3_000, 5_000,
                             10_000, 15_000, 25_000, 50_000, 100_000,
                             200_000, 400_000, 800_000, 1_500_000, 3_000_000]
    
    init(numberQuestion: Int, isCurrentQuestion: Bool, isAnswerLastQuestion: Bool ) {
        self.numberQuestion = numberQuestion
        self.isCurrentQuestion = isCurrentQuestion
        self.isAnswerLastQuestion = isAnswerLastQuestion
    }
    
}
