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
    
    // создаем сложность игры
    var difficulty = Game.shared.difficulty
    
    private var makeListQuestionsStrategy: QuestionsStrategy {
        switch self.difficulty {
        case .easy:
            return SequentialQuestions()
        case .medium:
            return RandomQuestions()
        }
    }
    
    // создаем список вопросов
    var listQuestions: [MQuestion] = []
    
    // создаем состояние для вопроса
    var currentQuestion = QuestionSession(numberQuestion: Observable<Int>(0), isCurrentQuestion: true, isAnswerLastQuestion: false)
    
    // создаем текущую сессию игры
    var currentGameSession = Game.shared.gameSession
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // установка прогресс-бара
        setupProgressBar()
        self.listQuestions = makeListQuestionsStrategy.getListQuestions(bankQuestions: bankQuestions)
        // возможный выигрыш
        issuePriceLabel.text = String(QuestionSession.issuePrice[currentQuestion.numberQuestion.value])
        // установка вопроса
        setupQuestion()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let scoreViewController = segue.destination as? ScoreViewController else { return }
        if currentQuestion.isCurrentQuestion {
            // несгораемые суммы
            switch currentQuestion.numberQuestion.value {
            case 0...5: scoreViewController.win = 0
            case 6...10: scoreViewController.win = QuestionSession.issuePrice[4]
            case 11...14: scoreViewController.win = QuestionSession.issuePrice[9]
            case 15 where currentQuestion.isAnswerLastQuestion: scoreViewController.win = QuestionSession.issuePrice[14]
            default:
                scoreViewController.win = QuestionSession.issuePrice[9]
            }
        } else {
            // когда решил забрать свой текущий выигрыш
            if currentQuestion.numberQuestion.value > 1 {
                scoreViewController.win = QuestionSession.issuePrice[currentQuestion.numberQuestion.value-2]
            }
        }
        if currentQuestion.isAnswerLastQuestion == true {
            currentGameSession = GameSession(countRightAnswers: currentQuestion.numberQuestion.value, earnedWinning: scoreViewController.win)
        }
        else {
            currentGameSession = GameSession(countRightAnswers: currentQuestion.numberQuestion.value-1, earnedWinning: scoreViewController.win)
        }
        guard let currentGameSession = currentGameSession else { return }
        Game.shared.addRecord(currentGameSession)
    }
    
    // функция "задать вопрос"
    func setupQuestion() {
        
        let question = listQuestions[currentQuestion.numberQuestion.value]
        let answers:[String] = question.answers
        
        print(question)
        print(answers)
            
        // стоимость вопроса
        issuePriceLabel.text = "Вопрос на \(QuestionSession.issuePrice[currentQuestion.numberQuestion.value]) рублей"
            
        //показываем вопрос
        currentQuestion.numberQuestion.addObserver(self, options: [.new, .initial]) { [weak self] (numberQuestion, _) in
            self?.questionLabel.text = "\(numberQuestion).  \(question.question)"
        }
            
        // показываем варианты ответов
        aAnswerLabel.setTitle(question.answers[0], for: .normal)
        aAnswerLabel.titleLabel!.adjustsFontSizeToFitWidth = true
        bAnswerLabel.setTitle(question.answers[1], for: .normal)
        bAnswerLabel.titleLabel!.adjustsFontSizeToFitWidth = true
        cAnswerLabel.setTitle(question.answers[2], for: .normal)
        cAnswerLabel.titleLabel!.adjustsFontSizeToFitWidth = true
        dAnswerLabel.setTitle(question.answers[3], for: .normal)
        dAnswerLabel.titleLabel!.adjustsFontSizeToFitWidth = true
        
        currentQuestion.numberQuestion.value += 1
        progressBar.setProgress(Float(currentQuestion.numberQuestion.value) / Float(bankQuestions.count),
                                animated: true)
        
    }
    
    // функция следующего вопроса
    func getNextQuestion() {
        if(self.currentQuestion.numberQuestion.value < bankQuestions.count) {
            self.setupQuestion()
        } else {
            self.performSegue(withIdentifier: "toScore", sender: nil)
        }
    }
    
    // функция проверки ответа
    func checkAnswer(_ answer: String) {
        let question = listQuestions[currentQuestion.numberQuestion.value-1]
        print(question.rightAnswer)
        if (currentQuestion.numberQuestion.value < listQuestions.count) {
            if (answer == question.rightAnswer) {
                alertControllerTrueAnswer()
            } else {
                alertControllerFalseAnswer()
            }
        }
        if (currentQuestion.numberQuestion.value == listQuestions.count && answer == question.rightAnswer) {
            currentQuestion.isAnswerLastQuestion = true
            alertControllerСongratulation()
        } else {
            alertControllerFalseAnswer()
        }
    }
    
}
