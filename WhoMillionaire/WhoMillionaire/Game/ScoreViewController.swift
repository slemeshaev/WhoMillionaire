//
//  ScoreViewController.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 27.04.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var scorePriceLabel: UILabel!
    
    var win = 0 // результирущий выигрыш
    
    override func viewDidLoad() {
        scorePriceLabel.text = "\(win) рублей"
    }
    
}
