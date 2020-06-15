//
//  Question.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 14.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

final class Question {
    
    // вопрос
    var question: MQuestion?
    
    static let shared = Question()
    
    private(set) var questions: [MQuestion] {
        didSet {
            questionsCaretaker.save(records: self.questions)
        }
    }
    
    private let questionsCaretaker = QuestionsCaretaker()
    
    private init() {
        self.questions = self.questionsCaretaker.retriveRecords()
    }
    
    func addRecord(_ question: MQuestion) {
        self.questions.append(question)
    }
    
    func clearRecords() {
        self.questions = []
    }
    
}
