//
//  GameManager.swift
//  SpriteKitTutorial
//
//  Created by 0-jerry on 6/21/25.
//

import Combine

class GameManager: ObservableObject {
    @Published var score: Int = 0
    @Published var move: Int = 0
}
