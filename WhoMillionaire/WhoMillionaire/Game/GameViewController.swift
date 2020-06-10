//
//  GameViewController.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 02.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var issuePriceLabel: UILabel!
    
    // варианты ответов
    @IBOutlet weak var aAnswerLabel: UIButton!
    @IBOutlet weak var bAnswerLabel: UIButton!
    @IBOutlet weak var cAnswerLabel: UIButton!
    @IBOutlet weak var dAnswerLabel: UIButton!
    
    // кнопка забрать деньги
    @IBOutlet weak var takeMoneyLabel: UIButton! {
        didSet {
            takeMoneyLabel.isHidden = true
        }
    }
    
    // выбрать ответ
    @IBAction func answerClicked(_ sender: UIButton) {
        checkAnswer(sender.titleLabel!.text!)
        print(sender.titleLabel!.text!)
        takeMoneyLabel.isHidden = false
    }
    
    // забрать деньги
    @IBAction func takeMoneyTapped(_ sender: UIButton) {
        currentQuestion.isCurrentQuestion = false
        alertControllerСongratulation()
    }
    
    // загружаем банк с вопросами
    let bankQuestions = Bundle.main.decode([MQuestion].self, from: "questions.json")
    
    // создаем текущий вопрос
    var currentQuestion = QuestionSession(numberQuestion: 0, isCurrentQuestion: true, isAnswerLastQuestion: false)
    
    // создаем текущую сессию игры
    var currentGameSession = Game.shared.gameSession
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // установка прогресс-бара
        setupProgressBar()
        // возможный выигрыш
        issuePriceLabel.text = String(QuestionSession.issuePrice[currentQuestion.numberQuestion])
        // установка вопроса
        setupQuestion()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let scoreViewController = segue.destination as? ScoreViewController else { return }
        if currentQuestion.isCurrentQuestion {
            // несгораемые суммы
            switch currentQuestion.numberQuestion {
            case 0...5: scoreViewController.win = 0
            case 6...10: scoreViewController.win = QuestionSession.issuePrice[4]
            case 11...14: scoreViewController.win = QuestionSession.issuePrice[9]
            case 15 where currentQuestion.isAnswerLastQuestion: scoreViewController.win = QuestionSession.issuePrice[14]
            default:
                scoreViewController.win = QuestionSession.issuePrice[9]
            }
        } else {
            // когда решил забрать свой текущий выигрыш
            if currentQuestion.numberQuestion > 1 {
                scoreViewController.win = QuestionSession.issuePrice[currentQuestion.numberQuestion-2]
            }
        }
        if currentQuestion.isAnswerLastQuestion == true {
           currentGameSession = GameSession(countRightAnswers: currentQuestion.numberQuestion, earnedWinning: scoreViewController.win)
        }
        else {
            currentGameSession = GameSession(countRightAnswers: currentQuestion.numberQuestion-1, earnedWinning: scoreViewController.win)
        }
        guard let currentGameSession = currentGameSession else { return }
        Game.shared.addRecord(currentGameSession)
    }
    
    // функция "задать вопрос"
    func setupQuestion() {
        let question = bankQuestions[currentQuestion.numberQuestion]
        let answers:[String] = question.answers!
        
        print(question)
        print(answers)
            
        // стоимость вопроса
        issuePriceLabel.text = "Вопрос на \(QuestionSession.issuePrice[currentQuestion.numberQuestion]) рублей"
            
        //показываем вопрос
        questionLabel.text = String(question.question!)
            
        // показываем варианты ответов
        aAnswerLabel.setTitle(question.answers![0], for: .normal)
        aAnswerLabel.titleLabel!.adjustsFontSizeToFitWidth = true
        bAnswerLabel.setTitle(question.answers![1], for: .normal)
        bAnswerLabel.titleLabel!.adjustsFontSizeToFitWidth = true
        cAnswerLabel.setTitle(question.answers![2], for: .normal)
        cAnswerLabel.titleLabel!.adjustsFontSizeToFitWidth = true
        dAnswerLabel.setTitle(question.answers![3], for: .normal)
        dAnswerLabel.titleLabel!.adjustsFontSizeToFitWidth = true
        
        currentQuestion.numberQuestion += 1
        progressBar.setProgress(Float(currentQuestion.numberQuestion) / Float(bankQuestions.count),
                                animated: true)
        
    }
    
    // функция следующего вопроса
    func nextQuestion() {
        if(self.currentQuestion.numberQuestion < bankQuestions.count) {
            self.setupQuestion()
        } else {
            self.performSegue(withIdentifier: "toScore", sender: nil)
        }
    }
    
    // функция проверки ответа
    func checkAnswer(_ answer: String) {
        let question = bankQuestions[currentQuestion.numberQuestion-1]
        print(question.rightAnswer!)
        if (currentQuestion.numberQuestion < bankQuestions.count) {
            if (answer == question.rightAnswer!) {
                alertControllerTrueAnswer()
            } else {
                alertControllerFalseAnswer()
            }
        }
        if (currentQuestion.numberQuestion == bankQuestions.count && answer == question.rightAnswer!) {
            currentQuestion.isAnswerLastQuestion = true
            alertControllerСongratulation()
        } else {
            alertControllerFalseAnswer()
        }
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
    
    // функция отображения правильного ответа
    func alertControllerTrueAnswer() {
        let alert = UIAlertController(title: "Это правильный ответ!", message: "Играем дальше", preferredStyle: .alert)
        let action = UIAlertAction(title: "Следующий вопрос", style: .default, handler: { action in
            self.nextQuestion()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // функция отображения неправильного ответа
    func alertControllerFalseAnswer() {
        let alert = UIAlertController(title: "Это неверный ответ!", message: "Не отчаивайтесь", preferredStyle: .alert)
        let action = UIAlertAction(title: "Посмотреть результат", style: .default) { (action) in
            self.performSegue(withIdentifier: "toScore", sender: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // функция для поздравления миллионера
    func alertControllerСongratulation() {
        let yourPrice = currentQuestion.isAnswerLastQuestion ? QuestionSession.issuePrice[currentQuestion.numberQuestion-1] : QuestionSession.issuePrice[currentQuestion.numberQuestion-2]
        let alert = UIAlertController(title: "Поздравляем!", message: "Вы выиграли \(yourPrice) рублей!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Посмотреть результат", style: .default) { (action) in
            self.performSegue(withIdentifier: "toScore", sender: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
