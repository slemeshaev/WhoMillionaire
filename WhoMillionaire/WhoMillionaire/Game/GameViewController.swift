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
        alertControllerСongratulation()
    }
    
    var questionNumber = 0 // номер вопроса
    var currentQuestion = false // текущий вопрос
    var answerLastQuestion = false // ответ на последний вопрос
    
    // стоимость вопросов
    let issuePrice: [Int] = [500, 1_000, 2_000, 3_000, 5_000,
                             10_000, 15_000, 25_000, 50_000, 100_000,
                             200_000, 400_000, 800_000, 1_500_000, 3_000_000]
    
    // загружаем банк с вопросами
    let bankQuestions = Bundle.main.decode([MQuestion].self, from: "questions.json")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // установка прогресс-бара
        setupProgressBar()
        // возможный выигрыш
        issuePriceLabel.text = String(issuePrice[questionNumber])
        // установка вопроса
        setupQuestion()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let scoreViewController = segue.destination as? ScoreViewController else { return }
        print(questionNumber)
        if currentQuestion {
            // несгораемые суммы
            switch questionNumber {
            case 0...5: scoreViewController.win = 0
            case 6...10: scoreViewController.win = issuePrice[4]
            case 11...14: scoreViewController.win = issuePrice[9]
            case 15 where answerLastQuestion: scoreViewController.win = issuePrice[14]
            default:
                scoreViewController.win = issuePrice[9]
            }
        } else {
            currentQuestion = true
            // когда решил забрать свой текущий выигрыш
            if questionNumber > 1 {
                scoreViewController.win = issuePrice[questionNumber-2]
            }
        }
    }
    
    // функция "задать вопрос"
    func setupQuestion() {
        let question = bankQuestions[questionNumber]
        let answers:[String] = question.answers!
        
        print(question)
        print(answers)
            
        // стоимость вопроса
        issuePriceLabel.text = "Вопрос на \(issuePrice[questionNumber]) рублей"
            
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
        
        questionNumber += 1
        progressBar.setProgress(Float(questionNumber) / Float(bankQuestions.count),
                                animated: true)
        
    }
    
    // функция следующего вопроса
    func nextQuestion() {
        if(self.questionNumber < bankQuestions.count) {
            self.setupQuestion()
        } else {
            self.performSegue(withIdentifier: "toScore", sender: nil)
        }
    }
    
    // функция проверки ответа
    func checkAnswer(_ answer: String) {
        let question = bankQuestions[questionNumber-1]
        print(question.rightAnswer!)
        if (questionNumber < bankQuestions.count) {
            if (answer == question.rightAnswer!) {
                alertControllerTrueAnswer()
            } else {
                alertControllerFalseAnswer()
            }
        }
        if (questionNumber == bankQuestions.count && answer == question.rightAnswer!) {
            answerLastQuestion = true
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
        let alert = UIAlertController(title: "Поздравляем!", message: "Вы выиграли \(issuePrice[questionNumber-2]) рублей!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Посмотреть результат", style: .default) { (action) in
            self.performSegue(withIdentifier: "toScore", sender: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
