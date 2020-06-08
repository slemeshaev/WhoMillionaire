//
//  Game.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 02.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

final class Game {
    
    var gameSession: GameSession?
    
    static let shared = Game()
    
    private(set) var records: [GameSession] {
        didSet {
            recordsCaretaker.save(records: self.records)
        }
    }
    
    private let recordsCaretaker = RecordsCaretaker()
    
    private init() {
        self.records = self.recordsCaretaker.retriveRecords()
    }
    
    func addRecord(_ record: GameSession) {
        self.records.append(record)
    }
    
    func clearRecords() {
        self.records = []
    }
    
}
