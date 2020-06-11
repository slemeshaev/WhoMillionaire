//
//  SequentialQuestions.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 06.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

// вопросы задаются в одном порядке
final class SequentialQuestions: QuestionsStrategy {
    
    func getListQuestions(bankQuestions: [MQuestion]) -> [MQuestion] {
        var listQuestions: [MQuestion] = []
        for (_, question) in bankQuestions.enumerated() {
            if listQuestions.count < 15 {
                listQuestions.append(question)
            }
        }
        return listQuestions
    }
    
}
