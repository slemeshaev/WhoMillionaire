//
//  ScoreViewController.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 02.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var scorePriceLabel: UILabel!
    
    var win = 0 // результирущий выигрыш
    
    override func viewDidLoad() {
        scorePriceLabel.text = "\(win) рублей"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "startGameSegue" else { return }
        guard let mainMenuViewController = segue.destination as? MainMenuViewController else { return }
            mainMenuViewController.lastPrice = win
    }
    
}
