//
//  MQuestion.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 13.04.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

// структура вопрос
struct MQuestion: Hashable, Codable {
    
    var question: String?
    var answers: [String]?
    var rightAnswer: String?
    var id: Int?
    
    
//    init?(data: Data) {
//        let data = try! JSONSerialization.jsonObject(with: data, options: [])
//
//        guard let question = data["question"] as? String,
//            let answers = data["answers"] as? [String],
//            let rightAnswer = data["rightAnswer"] as? String,
//            let id = data["id"] as? Int else { return nil }
//
//        self.question = question
//        self.answers = answers
//        self.rightAnswer = rightAnswer
//        self.id = id
//    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MQuestion, rhs: MQuestion) -> Bool {
        return lhs.id == rhs.id
    }
    
}
