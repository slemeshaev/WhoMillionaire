//
//  Game.swift
//  WhoMillionaire
//
//  Created by Станислав Лемешаев on 04.05.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

final class Game {
    
    static let shared = Game()
    var gameSession: GameSession?
    
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