//
//  RecordTableViewCell.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 15.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var earnedWinningLabel: UILabel!
    @IBOutlet weak var countRightAnswersLabel: UILabel!
    
    weak var viewModel: TableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            earnedWinningLabel.text = viewModel.earnedWinning
            countRightAnswersLabel.text = viewModel.countRightAnswers
        }
    }

}
