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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func unwindToMenu(_ unwindSegue: UIStoryboardSegue) {
        guard let source = unwindSegue.source as? ScoreViewController else { return }
            lastPriceLabel.text = "Последний результат: \(String(source.win))"
    }

}
