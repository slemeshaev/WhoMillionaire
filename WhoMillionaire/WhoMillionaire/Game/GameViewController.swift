//
//  GameViewController.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 13.04.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var issuePriceLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    // варианты ответов
    @IBOutlet weak var aAnswerLabel: UIButton!
    @IBOutlet weak var bAnswerLabel: UIButton!
    @IBOutlet weak var cAnswerLabel: UIButton!
    @IBOutlet weak var dAnswerLabel: UIButton!
    
    @IBAction func answerClicked(_ sender: UIButton) {
        checkAnswer(sender.titleLabel!.text!)
    }
    
    var questionNumber = 0 // номер вопроса
    var totalAmount = 0 // общий выигрыш
    var issuePrice = 0 // стоимость вопроса
    var answerStreak = 0 // полоса ответов
    var startTime: DispatchTime? // начало игры
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // установка прогресс-бара
        setupProgressBar()
        // текущий выигрыш
        issuePriceLabel.text = String(totalAmount)
        // установка вопроса
        setupQuestion()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mainMenuViewController = segue.destination as? MainMenuViewController else { return }
        mainMenuViewController.lastPrice = totalAmount
    }
    
    // функция "задать вопрос"
    func setupQuestion() {
        let bankQuestions = Bundle.main.decode([MQuestion].self, from: "question.json")
    
        bankQuestions.forEach({ (questionModel) in
            let questionModel = MQuestion(question: questionModel.question,
                                          answers: questionModel.answers,
                                          rightAnswer: questionModel.rightAnswer,
                                          id: questionModel.id)
            
            // стоимость вопроса
            issuePriceLabel.text = "Вопрос на \(issuePrice) рублей"
            
            //показываем вопрос
            questionLabel.text = String(questionModel.question)
            
            // заработанная сумма
            totalAmountLabel.text = "Вы заработали \(totalAmount) рублей"
            
            // показываем варианты ответов
            aAnswerLabel.setTitle("A: \(questionModel.answers[0])", for: .normal)
            bAnswerLabel.setTitle("B: \(questionModel.answers[1])", for: .normal)
            cAnswerLabel.setTitle("C: \(questionModel.answers[2])", for: .normal)
            dAnswerLabel.setTitle("D: \(questionModel.answers[3])", for: .normal)
        })
        
        questionNumber += 1
        progressBar.setProgress(Float(questionNumber) / Float(15), animated: true)
        startTime = DispatchTime.now()
        
    }
    
    // функция проверки ответа
    func checkAnswer(_ answer: String) {
        //
    }
    
}

extension GameViewController {
    
    // функция установки progressBara
    func setupProgressBar() {
        progressBar.progress = 0.0
        progressBar.layer.cornerRadius = 5
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers![1].cornerRadius = 5
        progressBar.subviews[1].clipsToBounds = true
    }
}
