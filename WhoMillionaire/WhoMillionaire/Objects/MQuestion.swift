//
//  MQuestion.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 13.04.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

// структура вопрос
struct MQuestion: Hashable, Decodable {
    var question: String
    var answerA: String
    var answerB: String
    var answerC: String
    var answerD: String
    var rightAnswer: String
    var id = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MQuestion, rhs: MQuestion) -> Bool {
        return lhs.id == rhs.id
    }
    
}
