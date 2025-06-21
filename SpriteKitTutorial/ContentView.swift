//
//  ContentView.swift
//  SpriteKitTutorial
//
//  Created by 0-jerry on 6/20/25.
//

import SwiftUI
import Combine
import SpriteKit.SKScene

struct ContentView: View {

    init(gameManager: GameManager = GameManager()) {
        let gameScene = GameScene()
        gameScene.gameManager = gameManager
        self.gameManager = gameManager
        self.gameScene = gameScene
    }

    @ObservedObject private var gameManager: GameManager
    private let gameScene: GameScene
    
    var body: some View {
        ZStack {
            SpriteView(scene: gameScene)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("score: \(gameManager.score)")
                        .font(.title)
                    Spacer()
                    Text("moves: \(gameManager.move)")
                        .font(.title)
                }
                Spacer()
            }.padding(30)
        }
    }
}

#Preview {
    ContentView()
}
