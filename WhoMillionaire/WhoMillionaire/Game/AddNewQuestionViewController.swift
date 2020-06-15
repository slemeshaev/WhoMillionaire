//
//  AddNewQuestionViewController.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 14.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class AddNewQuestionViewController: UIViewController {
    
    var additingQuestion: MQuestion?

    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var answerATextField: UITextField!
    @IBOutlet weak var answerBTextField: UITextField!
    @IBOutlet weak var answerCTextField: UITextField!
    @IBOutlet weak var answerDTextField: UITextField!
    
    @IBOutlet weak var answerRightTextField: UITextField!
    
    @IBOutlet weak var saveQuestion: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // цвет фона брендовый фиолетовый
        view.backgroundColor = UIColor.brandPurple
        
        saveQuestion.isEnabled = false
        
        // заполнение всех полей
        fillInAllFields()
    }
    
    private func fillInAllFields() {
        answerATextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        answerBTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        answerCTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        answerDTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        answerRightTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    
    @IBAction func saveQuestionTapped() {
        additingQuestion = MQuestion(question: questionTextView.text!,
                                     answers: [answerATextField.text!,
                                               answerBTextField.text!,
                                               answerCTextField.text!,
                                               answerDTextField.text!],
                                     rightAnswer: answerRightTextField.text!,
                                     id: 127)
        
        Question.shared.question = additingQuestion
        if let question = Question.shared.question {
            Question.shared.addRecord(question)
            print(question)
        }
    }
    
}

// MARK: Text field delegate

extension AddNewQuestionViewController: UITextFieldDelegate {
    
    // скрываем клавиатуру по нажатию на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        if (answerATextField.text?.isEmpty == false) &&
            (answerBTextField.text?.isEmpty == false) &&
            (answerCTextField.text?.isEmpty == false) &&
            (answerDTextField.text?.isEmpty == false) &&
            (answerRightTextField.text?.isEmpty == false) {
            saveQuestion.isEnabled = true
        } else {
            saveQuestion.isEnabled = false
        }
    }
    
}
