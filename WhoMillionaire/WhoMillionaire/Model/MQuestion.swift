//
//  MQuestion.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 02.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

// структура вопрос
struct MQuestion: Hashable, Codable {
    
    var question: String
    var answers: [String]
    var rightAnswer: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MQuestion, rhs: MQuestion) -> Bool {
        return lhs.id == rhs.id
    }
    
}
