//
//  MainMenuViewController.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 13.04.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var lastPriceLabel: UILabel!
    
    var lastPrice: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastPriceLabel.text = "Последний результат: \(lastPrice)"
    }
    
    @IBAction func unwindToMenu(unwindSegue: UIStoryboardSegue) {}

}
