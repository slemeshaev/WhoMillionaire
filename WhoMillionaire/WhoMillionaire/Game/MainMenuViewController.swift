//
//  MainMenuViewController.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 02.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var lastPriceLabel: UILabel!
    
    var lastPrice = 0
    
    // пользователь выбирает сложность игры
    @IBOutlet weak var difficultyControl: UISegmentedControl!
    
    private var selectedDifficulty: Difficulty {
        switch self.difficultyControl.selectedSegmentIndex {
        case 0:
            return .easy
        case 1:
            return .medium
        default:
            return .easy
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "startGameSegue":
            guard let gameViewController = segue.destination as? GameViewController else { return }
            gameViewController.difficulty = self.selectedDifficulty
        default:
            break
        }
    }
    
    @IBAction func unwindToMenu(_ unwindSegue: UIStoryboardSegue) {
        guard let source = unwindSegue.source as? ScoreViewController else { return }
            lastPriceLabel.text = "Последний результат: \(String(source.win))"
    }

}
