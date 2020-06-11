//
//  QuestionsStrategy.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 11.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

// стратегия получения списка вопросов
protocol QuestionsStrategy {
    func getListQuestions(bankQuestions: [MQuestion]) -> [MQuestion]
}
