//
//  GameViewController+Extension.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 10.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

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
            self.getNextQuestion()
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
        let yourPrice = currentQuestion.isAnswerLastQuestion ? QuestionSession.issuePrice[currentQuestion.numberQuestion.value-1] : QuestionSession.issuePrice[currentQuestion.numberQuestion.value-2]
        let alert = UIAlertController(title: "Поздравляем!", message: "Вы выиграли \(yourPrice) рублей!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Посмотреть результат", style: .default) { (action) in
            self.performSegue(withIdentifier: "toScore", sender: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
